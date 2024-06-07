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
#| label: tidy-table1
#| classes: tidy-table
library(tidyverse)
table1
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
#| label: r-source-globals
source("../_globals.r")
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
#| label: tibble-backwards
#| echo: true
library(tibble)
data <- c(3.4,1.1,9.6)
labels <- c(0,1,0)
supervised_df <- tibble(x=data, y=labels)
supervised_df
#
#
#
#
#
#
#
#
#
#| label: tribble-example
#| echo: true
library(tibble)
dsan_df <- tibble::tribble(
    ~code, ~topic, ~credits,
    "dsan5000", "Data Science", 3,
    "dsan5100", "Probabilistic Modeling", 3
)
dsan_df
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
#| label: dplyr-filter
#| echo: true
#| code-fold: show
table1 |> filter(year == 2000)
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
#| label: dplyr-select
#| echo: true
#| code-fold: show
table1 |> select(country)
#
#
#
#
#
#
#
#
#| label: dplyr-arrange
#| echo: true
#| code-fold: show
table1 |> arrange(population)
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
#| label: dplyr-mutate
#| echo: true
#| code-fold: show
table1 |> mutate(newvar = 300)
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
#| label: dplyr-summarize
#| echo: true
#| code-fold: show
table1 |> 
  summarize(
    avg_cases = mean(cases),
    avg_pop = mean(population)
  )
#
#
#
#
#
#
#
#
#| label: dplyr-summarize-group
#| echo: true
#| code-fold: show
table1 |>
  group_by(country) |>
  summarize(
    avg_cases = mean(cases),
    avg_pop = mean(population)
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
#| label: forcats-example
#| echo: true
#| code-fold: show
month_levels <- c(
    "Jan", "Feb", "Mar", "Apr",
    "May", "Jun", "Jul", "Aug",
    "Sep", "Oct", "Nov", "Dec"
)
d <- c("Jan","Jan","Feb","Dec")
print(d)
#
#
#
#| label: forcats-parse-factor
#| echo: true
#| code-fold: show
dataf <- parse_factor(
    d,
    levels=month_levels
)
print(dataf)
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
#| label: relig-data
relig_summary <- gss_cat %>%
  group_by(relig) %>%
  summarise(
    age = mean(age, na.rm = TRUE),
    tvhours = mean(tvhours, na.rm = TRUE),
    n = n()
  )
relig_labs <- labs(
  x = "TV Hours / Day",
  y = "Religion"
)
#
#
#
#
#
#| label: relig-plot
#| fig-height: 7
#| echo: true
#| code-fold: show
relig_summary |>
  ggplot(aes(tvhours, relig)) +
  geom_point(size=g_pointsize) +
  geom_segment(aes(yend = relig, x=0, xend = tvhours)) +
  dsan_theme("half") +
  relig_labs
```
#
#
#
#
#
#
#| label: relig-plot-factors
#| fig-height: 7
#| echo: true
#| code-fold: show
relig_summary |>
  mutate(relig = fct_reorder(relig, tvhours)) |>
  ggplot(aes(x=tvhours, y=relig)) +
    geom_point(size=g_pointsize) +
    geom_segment(aes(yend = relig, x=0, xend = tvhours)) +
    dsan_theme("half") +
    relig_labs
```
#
#
#
#
#
#
#| label: sorting-barplots-labs
barplot_labs <- labs(
  title = "Respondents by Marital Status",
  x = "Marital Status",
  y = "Count"
)
#
#
#
#| label: sorting-barplots
#| echo: true
#| code-fold: show
gss_cat |>
  mutate(marital = marital |> fct_infreq() |> fct_rev()) |>
  ggplot(aes(marital)) + geom_bar() + barplot_labs +
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
#| label: fct-lump
#| echo: true
#| code-fold: show
gss_cat |>
    mutate(relig = fct_lump(relig)) |>
    count(relig)
#
#
#
#
#
#
#
#
#| label: fct-recode
#| echo: true
#| code-fold: true
gss_cat |>
    mutate(partyid = fct_recode(partyid,
    "Republican"  = "Strong republican",
    "Republican"  = "Not str republican",
    "Independent" = "Ind,near rep",
    "Independent" = "Ind,near dem",
    "Democrat"    = "Not str democrat",
    "Democrat"    = "Strong democrat",
    "Other"       = "No answer",
    "Other"       = "Don't know",
    "Other"       = "Other party"
  )) |>
  count(partyid)
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
#| label: read-csv-gist
gdp_df <- read_csv("https://gist.githubusercontent.com/jpowerj/fecd437b96d0954893de727383f2eaf2/raw/fec58507f7095cb8341b229d6eb74ce53232d663/gdp_2010.csv")
gdp_df |> head(6)
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
#| label: purrr-map
#| echo: true
#| code-fold: show
my_points <- c("Midterm"=18, "Final"=300)
total_points <- c("Midterm"=20, "Final"=400)
(avg_score <- map2(my_points, total_points,
  ~ list(frac=.x / .y, pct=(.x/.y)*100)))
#
#
#
#
#
#
#
#
#| label: purrr-flatten
#| echo: true
#| code-fold: show
list_flatten(avg_score)
#
#
#
#| label: purrr-every
#| echo: true
#| code-fold: show
every(avg_score, ~ .x$frac > 0.5)
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
#| label: tidyverse-select-load-data
library(tidyverse)
table1
#
#
#
#| label: tidyverse-select
#| code-fold: show
table1 |> select(country, year, population)
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
#| label: tidyverse-filter-year
table1 |> filter(year == 2000)
#
#
#
#| label: tidyverse-filter-country
table1 |> filter(country == "Afghanistan")
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
#| label: tidyverse-filter-select
df <- table1 |>
  select(country, year, population) |>
  filter(year == 2000)
df |> write_csv("assets/pop_2000.csv")
df
#
#
#
#
#
#
#
#| label: load-gdp-data
#| code-fold: show
gdp_df <- read_csv("https://gist.githubusercontent.com/jpowerj/c83e87f61c166dea8ba7e4453f08a404/raw/29b03e6320bc3ffc9f528c2ac497a21f2d801c00/gdp_2000_2010.csv")
gdp_df |> head(5)
#
#
#
#
#
#
#
#
#
#| label: clean-gdp-data
#| code-fold: show
gdp_2000_df <- gdp_df |>
  select(`Country Name`,Year,Value) |>
  filter(Year == "2000") |>
  rename(country=`Country Name`, year=`Year`, gdp=`Value`)
gdp_2000_df |> write_csv("assets/gdp_2000.csv")
gdp_2000_df |> head()
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
#| label: r-long-data
table2 |> write_csv("assets/long_data.csv")
table2 |> head()
#
#
#
#
#
#
#
#
#| label: r-wide-data
table1 |> write_csv("assets/wide_data.csv")
table1 |> head()
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
#| label: r-display-wide-for-reshape
#| code-fold: show
table1
#
#
#
#
#
#
#| label: r-reshape
#| code-fold: show
long_df <- gather(table1,
  key = "variable",
  value = cases,
  -c(country, year)
)
long_df |> head()
#
#
#
#
#
#
#
