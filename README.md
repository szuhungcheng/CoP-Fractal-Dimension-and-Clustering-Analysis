
# CoP Fractal Dimension and Clustering Analysis

This project presents a comprehensive analysis of **Center of Pressure (CoP)** data collected from **single-leg balance tests** using the **KINVENT K-Force Plate** system.  
The aim is to evaluate the **temporal complexity** and **structural variability** of human balance control through both **nonlinear time series analysis** and **basic clustering** techniques.

---

## Project Structure

```
example_data/
    ├── single_leg_balance_鄭_思鴻_open_eyes.csv
    ├── single_leg_balance_鄭_思鴻_close_eyes.csv
k_means_example_results/
    ├── (png result files from R clustering script)

dimension_analysis.py   # Python code for CoP signal processing and fractal dimension analysis
k-means.r                    # R script for k-means clustering on CoP dimension features
close_eyes.csv                     # CoP feature dataset (closed eyes) for R clustering
open_eyes.csv                     # CoP feature dataset (open eyes) for R clustering
```

---

## 1. Experimental Design

The single-leg balance tests followed a standardized protocol embedded in the KINVENT K-Force system:

| Test Condition | Duration | Notes |
|:---------------|:---------|:------|
| Open Eyes, Left Foot Standing | 30 seconds | Visual feedback allowed |
| Open Eyes, Right Foot Standing | 30 seconds | Visual feedback allowed |
| Closed Eyes, Left Foot Standing | 30 seconds | No visual feedback |
| Closed Eyes, Right Foot Standing | 30 seconds | No visual feedback |

- **Rest Interval**: Approximately 10 seconds between tests.  
- **Environment**: Conducted under controlled laboratory conditions.  
- **Sampling Frequency**: 250 Hz.

---

## 2. Data Overview

The CoP data includes:
- Raw force sensor channels (CHANNEL_1 to CHANNEL_4)
- Computed AP (anterior-posterior) and ML (medial-lateral) CoP trajectories
- Summary features such as:
  - Mean CoP position
  - Standard deviation
  - Ellipse area
  - Total displacement
  - Mean velocity
  - Maximum distance

These metrics serve as inputs for both time series analysis and clustering.

---

## 3. Signal Processing and Temporal Complexity Analysis

Implemented in `dimension_analysis.py`:

### Load and Preprocess Data
- Extract AP and ML CoP trajectories separately for left and right legs.
- Apply a 4th order Butterworth low-pass filter (cutoff at 2 Hz) to remove high-frequency noise.

### Higuchi Fractal Dimension
- Compute the Higuchi fractal dimension separately for AP and ML CoP time series.
- Fractal dimension quantifies the temporal complexity of balance control strategies.

### Outputs
- Fractal dimension values for AP and ML directions.
- Log-log plots showing the scaling behavior between curve length and time scale.

> Note: Higuchi dimension values typically range between **1** (smooth) and **2** (highly irregular), offering insights into postural control complexity.

---

## 4. Dimensional Clustering Analysis

Implemented in `k-means.r`:

### Feature Extraction
- From pre-processed datasets (`open_eyes.csv`, `close_eyes.csv`), extract CoP spatial variability metrics for left and right foot.

### Clustering
- Perform k-means clustering (k=3) based on:
  - Raw dimension values (ML, AP variability)
  - Normalized scores (standardized by SD)

### Visualization
- Convex hull plots for each cluster.
- Highlight target subject(s) with distinctive markers.

---

## 5. Key Concepts and Interpretation

- **Center of Pressure (CoP)**:
  - Represents dynamic balance control strategies.
  - Variability and complexity indicate different neuromuscular adaptations.

- **Higuchi Fractal Dimension**:
  - Measures multiscale variability and self-similarity in CoP time series.

- **K-Means Clustering**:
  - Groups individuals based on balance control performance.
  - Facilitates identification of typical vs. atypical balance strategies.

---

## 6. Future Directions

- We tentatively propose a **performance indicator** as a score, calculated by dividing the fractal dimension by the standard deviation of the time series.
- Preliminary observations suggest that athletes tend to exhibit **higher performance scores along the anterior-posterior (A-P) axis (y-axis)**, indicating **greater control precision and adaptability** in this direction.
- Further validation with larger datasets and different balance conditions would be necessary to confirm this trend.


---

## 7. Requirements

**Python**:
- `numpy`
- `pandas`
- `scipy`
- `statsmodels`
- `matplotlib`

**R**:
- `tidyverse`
- `factoextra`

---

## Notes

- **M-L** = Medial-Lateral
- **A-P** = Anterior-Posterior

---

# 🧠 Summary

This project demonstrates an end-to-end process from real-world biomechanical data acquisition to nonlinear dynamic analysis and unsupervised clustering.  
It highlights technical proficiency in:
- Signal processing
- Fractal dimension computation
- Machine learning (k-means clustering)
- Scientific visualization
