library(tfa)
library(tidyverse)

##### CONDITIONALS AND CONTROL FLOW #####

x <- c(-5:5, NA)

## using if and for
res <- rep("", length(x))
for (i in seq_along(x)) {
  if (is.na(x[i])) res[i] <- "missing"
  else if (x[i] < 0) res[i] <- "negative"
  else res[i] <- "positive"
}
res

## implicit if statement
res <- rep("", length(x))
res

res[x < 0] <- "negative"
res[x >= 0] <- "positive"
res[is.na(x)] <- "missing"
res

## using if_else
res <- if_else(x < 0, "negative", "positive", "missing")
res

