#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#| label: r-conditionals
#| echo: true
#| code-fold: false
library(lubridate)
cur_time <- Sys.time()
writeLines(paste0(
    "The current time is ",
    hour(cur_time),":",
    minute(cur_time)
))
if (hour(cur_time) < 12) {
    print("Good morning!")
} else if (hour(cur_time) < 18) {
    print("Good afternoon!")
} else {
    print("Good evening!")
}
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#| label: r-ternary
#| echo: true
#| code-fold: false
ifelse(
    hour(cur_time) < 12,
    "morning",
    "evening"
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
#| label: r-for-loop
#| echo: true
#| code-fold: false
for (i in 1:10) {
    print(i)
}
#
#
#
#
#
#
#
#
#
