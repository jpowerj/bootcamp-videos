#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#| warning: false
library(tidyverse)
set.seed(2024)
N <- 200
gen_clusters = function(N, dist) {
  cluster_size <- round(N / 2)
  mu_1 <- c(-dist/2,-dist/2)
  mu_2 <- c(dist/2, dist/2)
  Sigma <- matrix(c(1, 0, 0, 1), nrow=2, ncol=2, byrow=TRUE)
  c1_points <- MASS::mvrnorm(cluster_size, mu_1, Sigma)
  colnames(c1_points) <- c("X1", "X2")
  c1_points <- as_tibble(c1_points)
  c1_points <- c1_points |> mutate(label = "1")
  c2_points <- MASS::mvrnorm(cluster_size, mu_2, Sigma)
  colnames(c2_points) <- c("X1", "X2")
  c2_points <- as_tibble(c2_points)
  c2_points <- c2_points |> mutate(label = "2")
  return(rbind(c1_points, c2_points))
}
linear_data <- gen_clusters(N, 4.5)
linear_data |>
  ggplot(aes(x=X1, y=X2, color=label)) +
  geom_point() +
  theme_classic()
#
#
#
#
#
#
#
#
#
#| label: q1
# your code goes here
#
#
#
#
#
#| label: q1-soln
df <- linear_data
df |> head()
dim(df)
#
#
#
#
#
#
#
#| label: q2
# your code goes here
#
#
#
#
#
#| label: q2-soln
# df <- df |> mutate(
#   label = c(rep("1", 100), rep("2", 100))
# )
# head(df)
# tail(df)
labels <- c(rep("1", N/2), rep("2", N/2))
#
#
#
#
#
#
#
# your code goes here
#
#
#
#
#
#| label: q3-soln
cl_labels <- sample(labels, N)
#
#
#
#
#
#
#
# your code goes here
#
#
#
#
#
#| label: q4-soln
df <- df |> mutate(
  label = cl_labels
)
df |> head()
#
#
#
#
#
#
#
# your code goes here
#
#
#
#
#
#| label: q5-soln
c1 <- df |> filter(label == "1") |>
  select(X1, X2) |>
  summarize(X1c=mean(X1), X2c=mean(X2)) |>
  as.numeric()
c2 <- df |> filter(label == "2") |>
  select(X1, X2) |>
  summarize(X1c=mean(X1), X2c=mean(X2)) |>
  as.numeric()
c1
c2
#
#
#
#
#
#
#
# your code goes here
#
#
#
#
#
#| label: q6-soln
df |>
  ggplot(aes(x=X1, y=X2, color=label)) +
  geom_point() +
  geom_point(data=data.frame(X1=c1[1], X2=c1[2], label="C1")) +
  geom_point(data=data.frame(X1=c2[1], X2=c2[2], label="C2")) +
  theme_classic()
#
#
#
#
#
#
#
# your code goes here
#
#
#
#
#
compute_distance <- function(X1, X2, X1c, X2c) {
  X1_dist <- (X1c - X1)^2
  X2_dist <- (X2c - X2)^2
  return(sqrt(X1_dist + X2_dist))
}
compute_distance(0.5, 1.0, 3.2, 3.0)
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#| label: q8.1-response
# your code goes here
#
#
#
#
#
#| label: q8.1-solution
get_label <- function(x1, x2, c1, c2) {
  c1_dist <- compute_distance(x1, x2, c1[1], c1[2])
  c2_dist <- compute_distance(x1, x2, c2[1], c2[2])
  if (c1_dist < c2_dist) {
    return("1")
  } else {
    return("2")
  }
}
update_labels <- function(df, c1, c2) {
  for (i in 1:nrow(df)) {
    cur_X1 <- df[i, "X1"]
    cur_X2 <- df[i, "X2"]
    c1_dist <- compute_distance(cur_X1, cur_X2, c1[1], c1[2])
    c2_dist <- compute_distance(cur_X1, cur_X2, c2[1], c2[2])
    if (c1_dist < c2_dist) {
      df[i, "label"] <- "1"
    } else {
      df[i, "label"] <- "2"
    }
  }
}
#
#
#
#
#
#
#
#| label: q8.2-response
# Your code here
#
#
#
#
#
#| label: q8.2-solution
update_centroids <- function(df, c1, c2) {
  c1 <- df |> filter(label == "1") |>
    select(X1, X2) |>
    summarize(X1mean=mean(X1), X2mean=mean(X2)) |>
    as.numeric()
  c2 <- df |> filter(label == "2") |>
    select(X1, X2) |>
    summarize(X1mean=mean(X1), X2mean=mean(X2)) |>
    as.numeric()
}
#
#
#
#
#
#
#
#| label: q8.3-response
# Your code here
#
#
#
#| label: q8.3-solution
for (i in 1:10) {
  update_labels(df, c1, c2)
  update_centroids(df, c1, c2)
  print(list(c1, c2))
}
#
#
#
#
#
#
#
#| label: q9-response
# Your code here
#
#
#
#
#
#| label: q9-solution
df |>
  ggplot(aes(x=X1, y=X2, color=label)) +
  geom_point() +
  geom_point(data=data.frame(X1=c1[1], X2=c1[2], label="C1")) +
  geom_point(data=data.frame(X1=c2[1], X2=c2[2], label="C2")) +
  theme_classic()
#
#
#
#
