library(tidyverse)
library(factoextra)

# open_eyes左腳 (Open Eyes, Left Foot) - Dimension
open_df <- read.csv("open_eyes.csv")

# Separate 'subject' points and filter others
subject_open <- open_df %>% filter(File == "subject")
open_df <- open_df %>% filter(File != "subject")

dimension_x <- (open_df$left_x)
dimension_y <- (open_df$left_y)
open_df_left_cluster <- data.frame(dimension_x, dimension_y)

k <- 3

# Apply k-means clustering
set.seed(123) # For reproducibility
kmeans_result <- kmeans(open_df_left_cluster, centers = k, nstart = 25)

open_df_left_cluster$cluster <- kmeans_result$cluster
open_df_left_cluster$file <- open_df$File

hulls <- open_df_left_cluster %>%
  group_by(cluster) %>%
  slice(chull(dimension_x, dimension_y))

# Plot for raw dimensions with 'subject' as a star shape
ggplot(open_df_left_cluster, 
       aes(
         x = dimension_x, 
         y = dimension_y)) +
  # Add convex hulls as filled polygons
  geom_polygon(data = hulls, aes(fill = as.factor(cluster), group = cluster), alpha = 0.2, show.legend = FALSE) +
  # Add scatter points for clusters
  geom_point(aes(color = as.factor(cluster), shape = as.factor(file)), size = 3) +
  # Add 'subject' points with star shape
  geom_point(data = subject_open, aes(x = left_x, y = left_y), color = "black", size = 5, shape = 15) +
  labs(
    title = "Open Left Dimension",
    x = "dimension_m-l",
    y = "dimension_a-p",
    color = "Cluster",
    shape = "File",
    fill = "Cluster"
  ) +
  geom_abline(slope = 1, intercept = 0, linetype = "dashed", color = "black", size = 1) +
  theme_minimal()

# open_eyes左腳 (Open Eyes, Left Foot) - Score
open_df <- read.csv("open_eyes.csv")

# Separate 'subject' points and calculate scores
subject_open <- open_df %>% filter(File == "subject")
subject_open <- subject_open %>%
  mutate(score_x = left_x / left_x_sd, score_y = left_y / left_y_sd)

# Filter other data and calculate scores
open_df <- open_df %>% filter(File != "subject")
score_x <- (open_df$left_x) / (open_df$left_x_sd)
score_y <- (open_df$left_y) / (open_df$left_y_sd)
open_df_left_cluster <- data.frame(score_x, score_y)

k <- 3

# Apply k-means clustering
set.seed(123) # For reproducibility
kmeans_result <- kmeans(open_df_left_cluster, centers = k, nstart = 25)

open_df_left_cluster$cluster <- kmeans_result$cluster
open_df_left_cluster$file <- open_df$File

hulls <- open_df_left_cluster %>%
  group_by(cluster) %>%
  slice(chull(score_x, score_y))

# Plot for normalized scores with 'subject' as a star shape
ggplot(open_df_left_cluster, 
       aes(
         x = score_x, 
         y = score_y)) +
  # Add convex hulls as filled polygons
  geom_polygon(data = hulls, aes(fill = as.factor(cluster), group = cluster), alpha = 0.2, show.legend = FALSE) +
  # Add scatter points for clusters
  geom_point(aes(color = as.factor(cluster), shape = as.factor(file)), size = 3) +
  # Add 'subject' points with star shape
  geom_point(data = subject_open, aes(x = score_x, y = score_y), color = "black", size = 5, shape = 15) +
  labs(
    title = "Open Left Score",
    x = "score_m-l",
    y = "score_a-p",
    color = "Cluster",
    shape = "File",
    fill = "Cluster"
  ) +
  geom_abline(slope = 1, intercept = 0, linetype = "dashed", color = "black", size = 1) +
  theme_minimal()












# open_eyes右腳 (Open Eyes, right Foot) - Dimension
open_df <- read.csv("open_eyes.csv")

# Separate 'subject' points and filter others
subject_open <- open_df %>% filter(File == "subject")
open_df <- open_df %>% filter(File != "subject")

dimension_x <- (open_df$right_x)
dimension_y <- (open_df$right_y)
open_df_right_cluster <- data.frame(dimension_x, dimension_y)

k <- 3

# Apply k-means clustering
set.seed(123) # For reproducibility
kmeans_result <- kmeans(open_df_right_cluster, centers = k, nstart = 25)

open_df_right_cluster$cluster <- kmeans_result$cluster
open_df_right_cluster$file <- open_df$File

hulls <- open_df_right_cluster %>%
  group_by(cluster) %>%
  slice(chull(dimension_x, dimension_y))

# Plot for raw dimensions with 'subject' as a star shape
ggplot(open_df_right_cluster, 
       aes(
         x = dimension_x, 
         y = dimension_y)) +
  # Add convex hulls as filled polygons
  geom_polygon(data = hulls, aes(fill = as.factor(cluster), group = cluster), alpha = 0.2, show.legend = FALSE) +
  # Add scatter points for clusters
  geom_point(aes(color = as.factor(cluster), shape = as.factor(file)), size = 3) +
  # Add 'subject' points with star shape
  geom_point(data = subject_open, aes(x = right_x, y = right_y), color = "black", size = 5, shape = 15) +
  labs(
    title = "Open right Dimension",
    x = "dimension_m-l",
    y = "dimension_a-p",
    color = "Cluster",
    shape = "File",
    fill = "Cluster"
  ) +
  geom_abline(slope = 1, intercept = 0, linetype = "dashed", color = "black", size = 1) +
  theme_minimal()

# open_eyes右腳 (Open Eyes, right Foot) - Score
open_df <- read.csv("open_eyes.csv")

# Separate 'subject' points and calculate scores
subject_open <- open_df %>% filter(File == "subject")
subject_open <- subject_open %>%
  mutate(score_x = right_x / right_x_sd, score_y = right_y / right_y_sd)

# Filter other data and calculate scores
open_df <- open_df %>% filter(File != "subject")
score_x <- (open_df$right_x) / (open_df$right_x_sd)
score_y <- (open_df$right_y) / (open_df$right_y_sd)
open_df_right_cluster <- data.frame(score_x, score_y)

k <- 3

# Apply k-means clustering
set.seed(123) # For reproducibility
kmeans_result <- kmeans(open_df_right_cluster, centers = k, nstart = 25)

open_df_right_cluster$cluster <- kmeans_result$cluster
open_df_right_cluster$file <- open_df$File

hulls <- open_df_right_cluster %>%
  group_by(cluster) %>%
  slice(chull(score_x, score_y))

# Plot for normalized scores with 'subject' as a star shape
ggplot(open_df_right_cluster, 
       aes(
         x = score_x, 
         y = score_y)) +
  # Add convex hulls as filled polygons
  geom_polygon(data = hulls, aes(fill = as.factor(cluster), group = cluster), alpha = 0.2, show.legend = FALSE) +
  # Add scatter points for clusters
  geom_point(aes(color = as.factor(cluster), shape = as.factor(file)), size = 3) +
  # Add 'subject' points with star shape
  geom_point(data = subject_open, aes(x = score_x, y = score_y), color = "black", size = 5, shape = 15) +
  labs(
    title = "Open right Score",
    x = "score_m-l",
    y = "score_a-p",
    color = "Cluster",
    shape = "File",
    fill = "Cluster"
  ) +
  geom_abline(slope = 1, intercept = 0, linetype = "dashed", color = "black", size = 1) +
  theme_minimal()














# close_eyes左腳 (close Eyes, Left Foot) - Dimension
close_df <- read.csv("close_eyes.csv")

# Separate 'subject' points and filter others
subject_close <- close_df %>% filter(File == "subject")
close_df <- close_df %>% filter(File != "subject")

dimension_x <- (close_df$left_x)
dimension_y <- (close_df$left_y)
close_df_left_cluster <- data.frame(dimension_x, dimension_y)

k <- 3

# Apply k-means clustering
set.seed(123) # For reproducibility
kmeans_result <- kmeans(close_df_left_cluster, centers = k, nstart = 25)

close_df_left_cluster$cluster <- kmeans_result$cluster
close_df_left_cluster$file <- close_df$File

hulls <- close_df_left_cluster %>%
  group_by(cluster) %>%
  slice(chull(dimension_x, dimension_y))

# Plot for raw dimensions with 'subject' as a star shape
ggplot(close_df_left_cluster, 
       aes(
         x = dimension_x, 
         y = dimension_y)) +
  # Add convex hulls as filled polygons
  geom_polygon(data = hulls, aes(fill = as.factor(cluster), group = cluster), alpha = 0.2, show.legend = FALSE) +
  # Add scatter points for clusters
  geom_point(aes(color = as.factor(cluster), shape = as.factor(file)), size = 3) +
  # Add 'subject' points with star shape
  geom_point(data = subject_close, aes(x = left_x, y = left_y), color = "black", size = 5, shape = 15) +
  labs(
    title = "close Left Dimension",
    x = "dimension_m-l",
    y = "dimension_a-p",
    color = "Cluster",
    shape = "File",
    fill = "Cluster"
  ) +
  geom_abline(slope = 1, intercept = 0, linetype = "dashed", color = "black", size = 1) +
  theme_minimal()

# close_eyes左腳 (close Eyes, Left Foot) - Score
close_df <- read.csv("close_eyes.csv")

# Separate 'subject' points and calculate scores
subject_close <- close_df %>% filter(File == "subject")
subject_close <- subject_close %>%
  mutate(score_x = left_x / left_x_sd, score_y = left_y / left_y_sd)

# Filter other data and calculate scores
close_df <- close_df %>% filter(File != "subject")
score_x <- (close_df$left_x) / (close_df$left_x_sd)
score_y <- (close_df$left_y) / (close_df$left_y_sd)
close_df_left_cluster <- data.frame(score_x, score_y)

k <- 3

# Apply k-means clustering
set.seed(123) # For reproducibility
kmeans_result <- kmeans(close_df_left_cluster, centers = k, nstart = 25)

close_df_left_cluster$cluster <- kmeans_result$cluster
close_df_left_cluster$file <- close_df$File

hulls <- close_df_left_cluster %>%
  group_by(cluster) %>%
  slice(chull(score_x, score_y))

# Plot for normalized scores with 'subject' as a star shape
ggplot(close_df_left_cluster, 
       aes(
         x = score_x, 
         y = score_y)) +
  # Add convex hulls as filled polygons
  geom_polygon(data = hulls, aes(fill = as.factor(cluster), group = cluster), alpha = 0.2, show.legend = FALSE) +
  # Add scatter points for clusters
  geom_point(aes(color = as.factor(cluster), shape = as.factor(file)), size = 3) +
  # Add 'subject' points with star shape
  geom_point(data = subject_close, aes(x = score_x, y = score_y), color = "black", size = 5, shape = 15) +
  labs(
    title = "close Left Score",
    x = "score_m-l",
    y = "score_a-p",
    color = "Cluster",
    shape = "File",
    fill = "Cluster"
  ) +
  geom_abline(slope = 1, intercept = 0, linetype = "dashed", color = "black", size = 1) +
  theme_minimal()












# close_eyes右腳 (close Eyes, right Foot) - Dimension
close_df <- read.csv("close_eyes.csv")

# Separate 'subject' points and filter others
subject_close <- close_df %>% filter(File == "subject")
close_df <- close_df %>% filter(File != "subject")

dimension_x <- (close_df$right_x)
dimension_y <- (close_df$right_y)
close_df_right_cluster <- data.frame(dimension_x, dimension_y)

k <- 3

# Apply k-means clustering
set.seed(123) # For reproducibility
kmeans_result <- kmeans(close_df_right_cluster, centers = k, nstart = 25)

close_df_right_cluster$cluster <- kmeans_result$cluster
close_df_right_cluster$file <- close_df$File

hulls <- close_df_right_cluster %>%
  group_by(cluster) %>%
  slice(chull(dimension_x, dimension_y))

# Plot for raw dimensions with 'subject' as a star shape
ggplot(close_df_right_cluster, 
       aes(
         x = dimension_x, 
         y = dimension_y)) +
  # Add convex hulls as filled polygons
  geom_polygon(data = hulls, aes(fill = as.factor(cluster), group = cluster), alpha = 0.2, show.legend = FALSE) +
  # Add scatter points for clusters
  geom_point(aes(color = as.factor(cluster), shape = as.factor(file)), size = 3) +
  # Add 'subject' points with star shape
  geom_point(data = subject_close, aes(x = right_x, y = right_y), color = "black", size = 5, shape = 15) +
  labs(
    title = "close right Dimension",
    x = "dimension_m-l",
    y = "dimension_a-p",
    color = "Cluster",
    shape = "File",
    fill = "Cluster"
  ) +
  geom_abline(slope = 1, intercept = 0, linetype = "dashed", color = "black", size = 1) +
  theme_minimal()

# close_eyes右腳 (close Eyes, right Foot) - Score
close_df <- read.csv("close_eyes.csv")

# Separate 'subject' points and calculate scores
subject_close <- close_df %>% filter(File == "subject")
subject_close <- subject_close %>%
  mutate(score_x = right_x / right_x_sd, score_y = right_y / right_y_sd)

# Filter other data and calculate scores
close_df <- close_df %>% filter(File != "subject")
score_x <- (close_df$right_x) / (close_df$right_x_sd)
score_y <- (close_df$right_y) / (close_df$right_y_sd)
close_df_right_cluster <- data.frame(score_x, score_y)

k <- 3

# Apply k-means clustering
set.seed(123) # For reproducibility
kmeans_result <- kmeans(close_df_right_cluster, centers = k, nstart = 25)

close_df_right_cluster$cluster <- kmeans_result$cluster
close_df_right_cluster$file <- close_df$File

hulls <- close_df_right_cluster %>%
  group_by(cluster) %>%
  slice(chull(score_x, score_y))

# Plot for normalized scores with 'subject' as a star shape
ggplot(close_df_right_cluster, 
       aes(
         x = score_x, 
         y = score_y)) +
  # Add convex hulls as filled polygons
  geom_polygon(data = hulls, aes(fill = as.factor(cluster), group = cluster), alpha = 0.2, show.legend = FALSE) +
  # Add scatter points for clusters
  geom_point(aes(color = as.factor(cluster), shape = as.factor(file)), size = 3) +
  # Add 'subject' points with star shape
  geom_point(data = subject_close, aes(x = score_x, y = score_y), color = "black", size = 5, shape = 15) +
  labs(
    title = "close right Score",
    x = "score_m-l",
    y = "score_a-p",
    color = "Cluster",
    shape = "File",
    fill = "Cluster"
  ) +
  geom_abline(slope = 1, intercept = 0, linetype = "dashed", color = "black", size = 1) +
  theme_minimal()
