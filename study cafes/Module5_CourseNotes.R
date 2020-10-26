# The ... argument

my_name <- function(first = "Lars", last = "Nielsen") {
  str_c(first, last, sep = " ")
}
my_name()

cite_text <- function(text, ...) {
  str_c(text, ', -', my_name(...))
}
cite_text("Learning by doing is the best way to learn how to program!")

cite_text("Learning by doing is the best way to learn how to program!", last = "Relund")

cite_text("To be or not to be", first = "Shakespeare", last = "")


test <- function(...) {
  return(list(...))
}
test(x = 4, y = "hey", z = 1:5)


# Documenting functions

#' Substract two vectors
#'
#' @param x First vector.
#' @param y Vector to be subtracted.
#'
#' @return The difference.
#' @export
#'
#' @examples
#' substract(x = c(5,5), y = c(2,3))
substract <- function(x, y) {
  return(x-y)
}
