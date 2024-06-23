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
#| label: base-r-plot
#| code-fold: true
#| fig-height: 8
source("../_globals.r")
lexp_df <- read.csv("assets/lexp_by_ward.csv")
plot(
  lexp_df$ward, lexp_df$life_exp,
  main="DC Life Expectancy by Ward (2015)",
  xlab="Ward", ylab="Life Expectancy",
  pch=19, cex.lab=2, cex.main=2, cex.axis=2
)
#
#
#
#
#
#
#| label: ggplot-ward-lollipop
#| code-fold: true
#| fig-height: 8
#| fig-cap: "Data from [DC Dept. of Health](https://disb.dc.gov/sites/default/files/dc/sites/disb/publication/attachments/her_summary_report_final_with_letter_and_table_02_08_2019.pdf)"
library(tidyverse)
us_mean <- 78.69
lexp_df <- read_csv("assets/lexp_by_ward.csv")
lexp_df <- lexp_df |> mutate(
  above_avg = ifelse(life_exp > us_mean, "Above Mean", "Below Mean")
)
lexp_df |> ggplot(aes(x=as.factor(ward), y=life_exp, color=above_avg)) +
  geom_point(size=5) +
  geom_segment(
    aes(xend=ward, yend=us_mean),
    linewidth=1.5
  ) +
  geom_hline(
    aes(
      yintercept=us_mean,
      linetype="National Mean"
    ),
    linewidth=1
  ) +
  dsan_theme("half") +
  theme(
    plot.title = element_text(hjust = 0.5)
  ) +
  labs(
    x = "Ward",
    y = "Life Expectancy",
    title = "DC Life Expectancy by Ward (2015)"
  ) +
  scale_linetype_manual("test", values=c("dashed")) +
  remove_legend_title()
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
#| label: fig-ward-choropleth
#| code-fold: true
#| fig-cap: "Life expectancy by ward; Shapefile from [OpenData.DC.gov](https://opendata.dc.gov/datasets/c5cd8b40fb784548a6680aead5f919ed/explore)"
library(sf)
my_sf <- read_sf("assets/Wards_from_2022.geojson")
my_sf_merged <- my_sf |> left_join(
  lexp_df, by=c("WARD"="ward")
)
my_sf_merged |> ggplot(aes(fill=life_exp)) +
  geom_sf() +
  dsan_theme() +
  theme(
    axis.line = element_blank(),
    axis.text = element_blank(),
    axis.ticks = element_blank()
  ) +
  labs(
    title = "DC Life Expectancy by Ward (2015)",
    fill = "Life Exp."
  ) +
  scale_fill_viridis_c()
#
#
#
#
#
#
#
#
#
#| label: r-anscombe
#| echo: true
#| code-fold: true
library(tidyverse)
library(datasets)
anscombe_df <- datasets::anscombe |>
  #mutate(id = row_number()) |>
  pivot_longer(
    everything(),
    cols_vary = "slowest",
    names_to = c(".value", "Dataset"),
    names_pattern = "(.)(.)"
  )
anscombe_plot_base <- anscombe_df |>
  ggplot(aes(x=x, y=y, color=Dataset)) +
  geom_point(size=g_pointsize / 2) +
  geom_smooth(method="lm", se=FALSE, fullrange=TRUE) +
  dsan_theme("full") +
  xlim(c(4, 20)) + ylim(c(2, 14))
anscombe_plot_base +
  facet_wrap(vars(Dataset), nrow=2, scales="free")
#
#
#
#
#
#| label: anscombe-again
#| echo: false
#| fig-height: 3
anscombe_one_row <- anscombe_plot_base +
  facet_wrap(vars(Dataset), nrow=1)
anscombe_one_row
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
#| label: fig-anscombe-means
#| code-fold: true
#| fig-cap: "Column means for each dataset"
anscombe_df |> group_by(Dataset) |>
  summarize(
    x_mean = round(mean(x), 2),
    y_mean = round(mean(y), 2)
  )
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
#| label: fig-anscombe-sds
#| code-fold: true
#| fig-cap: "Standard deviations for each dataset"
anscombe_df |> group_by(Dataset) |>
  summarize(
    x_sd = round(sd(x), 2),
    y_sd = round(sd(y), 2)
  )
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
#| label: fig-anscombe-corrs
#| code-fold: true
#| fig-cap: "Correlation between $x$ and $y$ for each dataset"
library(corrr)
corr_df <- anscombe_df |>
  group_by(Dataset) |>
  summarize(
    r = round(cor(x, y), 2)
  )
corr_df
#
#
#
#
#
#
#
#
#| label: anscombe-yet-again
#| echo: false
#| fig-height: 3
anscombe_one_row
#
#
#
#| label: anscombe-reg-0
#| echo: true
#| code-fold: true
library(broom)
lm_df <- anscombe_df |> group_by(Dataset) |>
  do(tidy(lm(y ~ x, data = .))) |>
  mutate(across(where(is.numeric), round, 2)) |>
  ungroup() |>
  mutate(
    term = gsub("Intercept","Int", term)
  )
#
#
#
#
#
#
#| label: anscombe-reg-1
lm_df |> filter(Dataset == 1) |> select(!Dataset)
#
#
#
#
#
#
#| label: anscombe-reg-2
lm_df |> filter(Dataset == 2) |> select(!Dataset)
#
#
#
#
#
#
#
#
#
#| label: anscombe-reg-3
lm_df |> filter(Dataset == 3) |> select(!Dataset)
#
#
#
#
#
#
#| label: anscombe-reg-4
lm_df |> filter(Dataset == 4) |> select(!Dataset)
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
#| fig-height: 6
#| echo: true
#| label: geom-bar-demo
bar_data <- tribble(
  ~Category, ~Value,
  "A", 100,
  "B", 200
)
ggplot(bar_data, aes(x=Category, y=Value)) +
  geom_bar(stat="identity") +
  dsan_theme("quarter")
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
#| echo: true
#| label: stat-function-demo
#| fig-height: 7
ggplot(data.frame(x=c(-4,4)), aes(x=x)) +
  stat_function(fun=dnorm, linewidth=g_linewidth) +
  dsan_theme("quarter")
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
#| label: geom-point-demo
#| fig-height: 8
#| echo: true
N_scatter <- 50
random_points <- data.frame(x=runif(N_scatter,0,1),y=runif(N_scatter,0,1))
ggplot(random_points, aes(x=x, y=y)) +
  geom_point(size = g_pointsize) +
  dsan_theme("quarter")
```
#
#
#
#
#
#
#| label: geom-line-demo
#| fig-height: 8
#| echo: true
N_line <- 15
rand_line <- data.frame(x=seq(1,N_line),y=runif(N_line,0,10))
ggplot(rand_line, aes(x=x, y=y)) +
  geom_line(linewidth = g_linewidth) +
  dsan_theme("quarter")
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
#| label: geom-line-point-demo
#| echo: true
ggplot(rand_line, aes(x=x, y=y)) +
  geom_line(linewidth=g_linewidth) +
  geom_point(size=g_pointsize/2) +
  dsan_theme("full")
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
#| label: ggplot-labs
#| echo: true
rand_plot <- rand_line |>
  ggplot(aes(x=x, y=y)) +
  geom_line(linewidth=g_linewidth) +
  geom_point(size=g_pointsize/2) +
  dsan_theme("quarter") +
  labs(
    title = "My Cool Plot",
    x = "The x value",
    y = "The y value"
  )
#
#
#
#
#
#
#| label: ggplot-labs-output
#| echo: true
rand_plot
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
#| label: ggplot-gen-clusters
#| code-fold: true
#| code-summary: "(Clustered data generation code)"
set.seed(2024)
centroids <- list(c(0,0),c(0,1),c(1,0),c(1,1))
cluster_df <- tibble()
N <- 50
Sigma <- matrix(c(0.05, 0, 0, 0.05), nrow=2, ncol=2, byrow=TRUE)
for (i in 1:length(centroids)) {
  cur_centroid <- centroids[[i]]
  # Generate N points from this centroid
  cur_data <- MASS::mvrnorm(N, cur_centroid, Sigma)
  colnames(cur_data) <- c("x", "y")
  cur_df <- as_tibble(cur_data)
  cur_df <- cur_df |> mutate(
    cluster = i
  )
  cluster_df <- rbind(cluster_df, cur_df)
}
#
#
#
#
#
#
#
#
#| label: ggplot-plot-clusters-nofactor
#| echo: true
#| code-fold: show
cluster_df |> ggplot(aes(x=x, y=y, color=cluster)) +
  geom_point(size=g_pointsize / 2) +
  dsan_theme("half") +
  labs(color="Cluster")
#
#
#
#
#
#
#
#
#| label: ggplot-plot-clusters
#| echo: true
#| code-fold: show
cluster_df |> ggplot(aes(x=x, y=y, color=factor(cluster))) +
  geom_point(size=g_pointsize / 2) +
  dsan_theme("half") +
  labs(color="Cluster")
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
#| label: ggplot-facets
#| echo: true
#| code-fold: show
facet_plot <- cluster_df |>
  ggplot(aes(
    x=x, y=y,
    color=factor(cluster)
  )) +
  geom_point(size=g_pointsize / 2) +
  dsan_theme("half") +
  labs(color="Cluster") +
  facet_wrap(vars(cluster),nrow=2)
#
#
#
#
#
#
#| label: ggplot-show-facets
#| echo: true
#| code-fold: false
#| fig-height: 6
facet_plot
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
#| label: load-text-data
library(tidyverse)
library(tidytext)
result_df <- as_tibble(read_lines(text_url))
result_df <- result_df |> filter(value != "")
result_df |> head()
text_url <- "https://gist.githubusercontent.com/jpowerj/493e395c2688ea72eabd0277e8e7a392/raw/6f882d95f3a1dc21c3b7e0b18b68d64b165c6367/eggs.txt"
#
#
#
#
#
#
#
#| label: r-wordcloud
library(showtext)
showtext_auto()
library(ggwordcloud)
data("love_words_latin")
love_words_latin
set.seed(2024)
ggplot(love_words_latin, aes(label = word, size = speakers)) +
  geom_text_wordcloud() +
  scale_size_area(max_size = 40) +
  theme_minimal()
#
#
#
#
#
#| label: r-custom-wordcloud
library(tidyverse)
library(tidytext)
result <- as_tibble(read_lines("https://gist.githubusercontent.com/jpowerj/493e395c2688ea72eabd0277e8e7a392/raw/6f882d95f3a1dc21c3b7e0b18b68d64b165c6367/eggs.txt"))
# |>
#  unnest_tokens(word, text)
head(result)
#
#
#
