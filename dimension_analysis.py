import numpy as np
import pandas as pd
import math
from scipy.fft import fft, ifft, fftfreq
import statsmodels.api as sm
from scipy.signal import hilbert, butter, filtfilt
from io import BytesIO
import tkinter as tk
import os
from tkinter import filedialog, messagebox
from matplotlib.colors import LinearSegmentedColormap
import matplotlib.pyplot as plt

def load_csv_data(file_path, skiprows_first_dataset):
    try:
        
        new_column_names = ['time', 'col1', 'col2', 'col3', 'col4', 'pass_1',
                            'cop_y', 'cop_x'] + ['q'] * 10  # Add 'q' placeholders dynamically
        # Columns to retain for COP calculation
        columns_to_keep = ['time', 'cop_y', 'cop_x']

        # ---------------- First Dataset (Left COP) ----------------
        df_left = pd.read_csv(file_path, skiprows=skiprows_first_dataset, header=None, on_bad_lines='skip')
        if not df_left.empty:
            # Assign column names dynamically
            df_left.columns = new_column_names[:df_left.shape[1]]
            df_left = df_left[columns_to_keep]

            # Find the index where 'time' column first becomes NA
            first_na_index = df_left['cop_y'].isna().idxmax()  # Get the first occurrence of NA
            if pd.isna(df_left.loc[first_na_index, 'cop_y']):  # Confirm it's an NA
                df_left = df_left.iloc[:first_na_index]  # Keep rows only up to the first NA

            # Rename COP columns
            df_left.rename(columns={'cop_y': 'cop_y_left', 'cop_x': 'cop_x_left'}, inplace=True)


        # ---------------- Find Start of Second Dataset ----------------
        second_start = None
        time_sec_count = 0  # Counter to track occurrences of "Time (sec)"
        
        with open(file_path, 'r') as file:
            for i, line in enumerate(file):
                if "Time (sec)" in line:
                    time_sec_count += 1
                    if time_sec_count == 2:  # Detect the second occurrence
                        second_start = i
                        break

        if second_start is None:
            raise ValueError("Could not find the second 'Time (sec)' header for the second dataset.")

        # ---------------- Second Dataset (Right COP) ----------------
        df_right = pd.read_csv(file_path, skiprows=second_start+1, header=None, on_bad_lines='skip')
        if not df_right.empty:
            df_right.columns = new_column_names[:df_right.shape[1]]
            df_right = df_right[columns_to_keep]
            df_right.rename(columns={'cop_y': 'cop_y_right', 'cop_x': 'cop_x_right'}, inplace=True)
            
            


        return df_left, df_right

    except Exception as e:
        print(f"Failed to load CSV file: {str(e)}")
        return None, None

 
# Function to apply the Butterworth filter
def apply_lowpass_filter(data, cutoff, fs, order=5):
    nyquist = 0.5 * fs
    normal_cutoff = cutoff / nyquist
    b, a = butter(order, normal_cutoff, btype='low', analog=False)
    return filtfilt(b, a, data)
cutoff = 2  # Hz (example cutoff frequency)
fs = 250  # Sampling frequency in Hz
order = 4  # Order of the filter





# main program starts here
df_left,df_right=load_csv_data("single_leg_balance_鄭_思鴻_閉眼.csv", 30)

df_left['cop_y_left'] = pd.to_numeric(df_left['cop_y_left'], errors='coerce')  # Convert non-numeric to NaN
df_left['cop_x_left'] = pd.to_numeric(df_left['cop_x_left'], errors='coerce')  # Convert non-numeric to NaN
df_left['cop_y_left_filtered']= apply_lowpass_filter(df_left['cop_y_left'], cutoff, fs, order)
df_left['cop_x_left_filtered']= apply_lowpass_filter(df_left['cop_x_left'], cutoff, fs, order)



df_right['cop_y_right'] = pd.to_numeric(df_right['cop_y_right'], errors='coerce')  # Convert non-numeric to NaN
df_right['cop_x_right'] = pd.to_numeric(df_right['cop_x_right'], errors='coerce')  # Convert non-numeric to NaN
df_right['cop_y_right_filtered']= apply_lowpass_filter(df_right['cop_y_right'], cutoff, fs, order)
df_right['cop_x_right_filtered']= apply_lowpass_filter(df_right['cop_x_right'], cutoff, fs, order)





def higuchi_fractal_dimension(time_series, k_max):

    N = len(time_series)
    L_k = []
    
    for k in range(1, k_max + 1):
        L_mk = []
        for m in range(k):
            L_m = 0
            for i in range(1, (N - m) // k):
                L_m += abs(time_series[m + i * k] - time_series[m + (i - 1) * k])
            L_m /= (N - m) // k
            L_mk.append(L_m)
        L_k.append(np.mean(L_mk) * (N - 1) / (k * k))
    
    log_k = np.log(range(1, k_max + 1))
    log_Lk = np.log(L_k)
    slope, _ = np.polyfit(log_k, log_Lk, 1)
    
    return -slope, log_k, log_Lk


k_max=100
s_left_y,log_k_left_y,log_lk_left_y=higuchi_fractal_dimension(df_left['cop_y_left_filtered'], k_max)
s_left_x,log_k_left_x,log_lk_left_x=higuchi_fractal_dimension(df_left['cop_x_left_filtered'], k_max)


s_right_y,log_k_right_y,log_lk_right_y=higuchi_fractal_dimension(df_right['cop_y_right_filtered'], k_max)
s_right_x,log_k_right_x,log_lk_right_x=higuchi_fractal_dimension(df_right['cop_x_right_filtered'], k_max)




print("s_left_y:",s_left_y,
      "s_left_x:",s_left_x,
      "s_right_y:",s_right_y,
      "s_right_x:",s_right_x)


left_y_sd=np.std(df_left['cop_y_left_filtered'])
left_x_sd=np.std(df_left['cop_x_left_filtered'])
right_y_sd=np.std(df_right['cop_y_right_filtered'])
right_x_sd=np.std(df_right['cop_x_right_filtered'])

print("left_y_sd:",left_y_sd,
"left_x_sd:",left_x_sd,
"right_y_sd:",right_y_sd,
"right_x_sd:",right_x_sd)

# Plotting function
def plot_higuchi_log_log(log_k, log_lk, slope, title):
    plt.figure(figsize=(8, 6))
    plt.plot(log_k, log_lk, 'o-', label=f'Slope (D): {slope:.2f}')
    plt.xlabel('log(k)')
    plt.ylabel('log(L(k))')
    plt.title(title)
    plt.legend()
    plt.grid()
    plt.show()

# Plot each dataset
plot_higuchi_log_log(log_k_left_y, log_lk_left_y, s_left_y, "Higuchi Log-Log Plot (Left COP - cop_y)")
plot_higuchi_log_log(log_k_left_x, log_lk_left_x, s_left_x, "Higuchi Log-Log Plot (Left COP - cop_x)")

plot_higuchi_log_log(log_k_right_y, log_lk_right_y, s_right_y, "Higuchi Log-Log Plot (Right COP - cop_y)")
plot_higuchi_log_log(log_k_right_x, log_lk_right_x, s_right_x, "Higuchi Log-Log Plot (Right COP - cop_x)")

# higuchi_fractal_dimension搞定，再來是box-counting






