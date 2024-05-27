#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#| label: initializing-int
#| echo: true
#| code-fold: false
x <- 3
print(x)
class(x)
length(x)
#
#
#
#
#
#
#| label: init-len1-vector
#| echo: true
#| code-fold: false
y <- c(3)
print(y)
class(y)
length(y)
#
#
#
#
#
#
#| label: init-vector
#| echo: true
#| code-fold: false
z <- c(3, 4, 5)
print(z)
class(z)
length(z)
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
  #| label: r-concat-str
  #| echo: true
  #| code-fold: false
  #| error: true
  my_message <- "Hi" + " " + "Jeff"
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
  #| label: r-concat-lists
  #| echo: true
  #| code-fold: false
  #| error: true
  c(1,2) + c(3,4)
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#| label: base-r-example
#| echo: true
#| code-fold: false
base_df <- data.frame(
  x=c(1,2,3),
  y=c("a","b","c")
)
base_df
class(base_df)
#
#
#
#
#
#
#
#
#| label: tidyverse-example
#| echo: true
#| code-fold: false
library(tidyverse) # Imports "tibble" library
tv_df <- tribble(
  ~x, ~y,
  1, "a",
  2, "b",
  3, "c"
)
tv_df
class(tv_df)
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#| label: pipeline-valid
#| echo: true
#| code-fold: false
getSampleSize <- function() {
  return(20)
}
getSampleSize() |> rbinom(10, 0.5)
#
#
#
#
#
#
#| label: pipeline-invalid
#| echo: true
#| code-fold: false
getNumTrials <- function() {
  return(10)
}
getNumTrials() |> rbinom(100, 0.5)
#
#
#
#
#
#
#
#
#
#
#
#
#
#
  #| label: r-paste
  #| echo: true
  #| code-fold: false
  paste("Hi", "Jeff")
  paste0("Hi", " ", "Jeff")
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#| label: r-list
#| echo: true
#| code-fold: false
my_list <- c(1, 2, 3)
my_list
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#| label: r-insertion
#| echo: true
#| code-fold: false
my_list <- c(my_list, 4)
my_list
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#| label: r-rep
#| echo: true
#| code-fold: false
rep(my_list, 3)
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#| label: r-seq
#| echo: true
#| code-fold: false
seq(5, 10)
#
#
#
#
#
#
#
#
#| label: r-paste-vectors
#| echo: true
#| code-fold: false
names <- c("Aaliya", "Brandon", "Cyrus")
paste(names, sep=" ", collapse=" ")
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#| label: r-dataframe
#| echo: true
#| code-fold: false
x_data <- c(1, 2, 3)
y_data <- c(4, 5, 6)
df <- data.frame(
  x=x_data,
  y=y_data
)
df
#
#
#
#
#
#
#
