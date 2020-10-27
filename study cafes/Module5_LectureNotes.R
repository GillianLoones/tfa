library(tfa)
library(tidyverse)

# Given a dice and a 52-card deck, use a for loop to write all the possible combinations as strings
# in the form Dice = [value] and card = [value]. Hint (fill the missing):

dice <- 1:6
card_suit <- c("clubs", "diamonds", "hearts", "spades")
card_number <- c("ace", 2:10, "jack", "queen", "king")
ite <- expand_grid(Dice = dice,
                   Card_suit = card_suit,
                   Card_number = card_number)

for (r in 1:nrow(ite)) { # iterate over rows
  cat("Dice = ", ite$Dice[r], 
      " and card = ", ite$Card_number[r], 
      " (", ite$Card_suit[r], ").\n", 
      sep="")
}



# Create a function that given some dice numbers and some cards from a 52-card deck (e.g. 1-spade), 
# write out all the possible combinations as strings in the form Dice = [value] and card = [value].

get_combinations <- function(dice, card) {
  ite <- expand_grid(d = dice, c = card)
  found <- FALSE
  for (i in 1:nrow(ite)) {
    if (ite$d[i] == 2) found = TRUE
    cat("Dice = ", ite$d[i], 
        " and card = ", ite$c[i], 
        ").\n", 
        sep="")
  } 
  return(found)
}
get_combinations(dice = c(2,3), card = c("2-spade", "ace-dimond"))
get_combinations(dice = c(3,1), card = c("10-heart", "king-dimond"))



# Create a function that calculates the present value (PV) of a future value. The equation is:
#     PV = FV / (1 + r) ^ n
# where FV is future value, r is the interest rate, and n is the number of periods.
# Input arguments must be FV, r, n, and a boolean round equal true if the output should be rounded to two decimals.
# The default interest rate is 0.1 (10%) and rounding is false by default.

get_PV <- function(FV, n, r = 0.1, round = TRUE) {
  PV = FV / (1 + r) ^ n
  if (round) return(round(PV, 2))
  return(PV)
}

# examples
get_PV(100, 7)
get_PV(100, 7, r = 0.25, round = FALSE)


