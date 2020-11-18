# ------------------------------------------------------------------------------
# ----------------------- MODULE 6 -- EXERCISES --------------------------------
# ------------------------------------------------------------------------------

remotes::install_github("bss-osca/tfa/tfa-package", upgrade = FALSE)  # run to upgrade
library(tfa)
library(tidyverse)


# --- EXERCISE 6.7.1 -- First markdown exercise---------------------------------

## Load the TFA package (see code above)

## The package contains templates for exercises etc. Go to File > New File > R Markdown…
## In the pop-up box select From template in the left column and then TFA Exercise.
## Press Ok and a new R Markdown document will be opened.

### 1) Change the meta text (e.g. the title and add your name) in the yaml.
### 2) Render/compile the document by pressing the Knit button (or Ctrl+Shift+K)
### 3) Change echo = TRUE to echo = FALSE in the first chunk setup and render the document. What has happened?

## You can easily go to a chunk using the navigation in the bottom left of the source window.

### 4) Try to change fig.asp = 0.25 to e.g. 0.5 in Chunk 10. What happens?
### 5) Create a new section ## Question 4 and add text in italic: What is the sum of all setup costs?
### 6) Add a code chunk solving Question 5 above.
### 7) Add a line of text with the result.



# --- EXERCISE 6.7.2 -- Tibbles ------------------------------------------------

### 1) Convert the dataset airquality to a tibble
       
       # Viewing the data set
       str(airquality)
       head(airquality)
       
       # Making tibble
       airquality_tbl <- as_tibble(airquality)
       airquality_tbl
       

### 2) Print the tibble and the original data frame and compare the difference.
       
       airquality
       # 153 rows with observations for each variable
       
       airquality_tbl
       # Shows first 10 rows ... with 143 more rows
       # Shows variable type for each column
       # Highlights NA observations
       
       
### 3) Create a tibble with 3 columns of data type string/character, double and list.
       
       tbl3 <- tibble(string = c("str1", "str2", "str3"), 
                      double = c(1.11, 2.22, 3.33), 
                      list = list(1:5, 1:10, 1:20))
       tbl3

