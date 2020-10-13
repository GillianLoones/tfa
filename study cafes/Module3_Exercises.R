# ------------------------------------------------------------------------------
# ----------------------- MODULE 3 -- EXERCISES --------------------------------
# ------------------------------------------------------------------------------

library(tfa)
library(tidyverse)


# --- EXERCISE 3.10.3 -- Piping ------------------------------------------------

  head(mtcars)
  ?mtcars

  mtcars %>% select(cyl, gear, hp, mpg) %>% filter(gear == 4 & cyl == 4)

### 1) --- Create a pipe that selects columns related to miles, horsepower, transmission and gears.
           q1 <- mtcars %>% select(mpg, hp, am, gear)
           q1

### 2) --- Given the answer in 1), filter so cars have miles less than 20 and 4 gears.
           q1 %>% filter(mpg < 20 & gear == 4)

### 3) --- Given the answer in 1), filter so cars have miles less than 20 or 4 gears
           q1 %>% filter(mpg < 20 | gear == 4)

### 4) --- Create a pipe that filters the cars having miles less than 20 and 4 gears and selects columns related to weight and engine.
           mtcars %>% filter(mpg < 20 & gear == 4) %>% select(wt, vs)

### 5) --- Solve Question 4 without the pipe operator.
           mtcars_q5 <- filter(mtcars, mpg < 20 & gear == 4)
           mtcars_q5 <- select(mtcars_filtered, wt, vs)
           mtcars_q5




# --- EXERCISE 3.10.5 -- Vectors -----------------------------------------------

### 1) --- What is the sum of the first 100 positive integers?
###        The formula for the sum of integers 1 through n is n(n + 1) / 2. 
###        Define n = 100 and then use R to compute the sum of 1 through 100 using the formula. What is the sum?
           n <- 100
           sum_100 <- n*(n+1)/2

### 2) --- Now use the same formula to compute the sum of the integers from 1 through 1000.
           n <- 1000
           sum_1000 <- n*(n+1)/2

### 3) --- Look at the result of typing the following code into R:
           n <- 1000
           x <- seq(1, n)
           sum(x)

           # Based on the result, what do you think the functions seq and sum do? You can use e.g help("sum") or ?sum
           # B -- seq creates a list of numbers and sum adds them up.
           
### 4) --- Run code:
           set.seed(123)
           v <- sample.int(100,30)
           v
           
### 5) --- What is the sum, mean, and standard deviation of v?
           sum(v)
           mean(v)
           sd(v)
           
### 6) --- Select elements 1, 6, 4, and 15 of v.
           v[c(1, 6, 5, 15)]
           
### 7) --- Select elements with value above 50.
           v[v > 50]
           
### 8) --- Select elements with value above 75 or below 25.
           v[v > 75 | v < 25]
           
### 9) --- Select elements with value 43.
           v[v == 43]

### 10) -- Select elements with value NA.
           v[is.na(v)]
           
### 11) -- Which elements have value above 75 or below 25? Hint: see the documentation of function which.
           ?which
           which(v > 75 | v < 25)
           
           

           
# --- EXERCISE 3.10.6 -- Matrices ----------------------------------------------
           
## Consider matrices
    
   m1 <- matrix(c(37, 8, 51, NA, 50, 97, 86, NA, 84, 46, 17, 62L), nrow = 3)
   m2 <- matrix(c(37, 8, 51, NA, 50, 97, 86, NA, 84, 46, 17, 62L), nrow = 3, byrow = TRUE)
   m3 <- matrix(c(37, 8, 51, NA, 50, 97, 86, NA, 84, 46, 17, 62L), ncol = 3)
           
### 1) --- What is the difference between the three matrices (think/discuss before running the code).
           
          # m1 has 3 rows and n columns. The values are filled in in column 1 through n, from top to bottom (however many are necessary to maintain 3 columns)
          # m2 has 3 rows and n columns. The values are filled in in row 1 through 3, from left to right, for n columns (however many are necessary to maintain 3 rows)
          # m3 has n rows and 3 columns. The values are filled in in column through 3, from top to bottom, for n rows (however many are necessary to maintain 3 columns)
          
          m1
          m2
          m3
          
    
### 2) --- Calculate the row sums of m1 and column sums of m2 ignoring NA values. Hint: have a look at the documentation of rowSums.
           ?rowSums
           rowSums(m2, na.rm = TRUE)
           
### 3) --- Add row c(1, 2, 3, 4) as last row to m1.
           ?rbind
           rbind(m1, c(1, 2, 3, 4))
           
### 4) --- Add row c(1, 2, 3, 4) as first row to m1.
           rbind(c(1, 2, 3, 4), m1)
           
### 5) --- Add column c(1, 2, 3, 4) as last column to m3.
           cbind(m3, c(1, 2, 3, 4))
           
### 6) --- Select the element in row 2 and column 4 of m1.
           m1[2, 4]
           
### 7) --- Select elements in rows 2-3 and columns 1-2 of m1.
           m1[2:3, 1:2]
           
### 8) --- Select elements in row 3 and columns 1, 3 and 4 of m1.
           m1[3, c(1, 3, 4)]
           
### 9) --- Select elements in row 3 of m1.
           m1[3, ]
           
### 10) -- Select all NA elements in m2.
           m2[is.na(m2)]
           
### 11) -- Select all elements greater that 50 in m2.
           m2[m2 > 50]
           


# --- EXERCISE 3.10.7 -- Data Frames -------------------------------------------
           
## Data frames may be seen as cell blocks in Excel.
## They are representations of datasets in R ...
## ... where the rows correspond to observations and the columns correspond to variables that describe the observations.
           
## Consider the data frame mtcars
           
   str(mtcars)
   glimpse(mtcars) # needs some other library (have used in ML)
   ?mtcars

### 1) --- Use the head and tail functions to have a look at the data.
           head(mtcars)
           tail(mtcars)
           
### 2) --- Select column hp using index (column 4), its name, and the $ operator.
           mtcars[, 4]    # index
           mtcars[, "hp"] # name
           mtcars$hp      # $ operator
           
### 3) --- Update mtcars by adding row c(34, 3, 87, 112, 4.5, 1.515, 167, 1, 1, 5, 3). Name the row 'Phantom XE'.
           ?rbind
           mtcars <- rbind(mtcars, c(34, 3, 87, 112, 4.5, 1.515, 167, 1, 1, 5, 3))
           rownames(mtcars)[33] <- "Phantom XE"
           
### 4) --- Update mtcars by adding column:
           col <- c(NA, "green", "blue", "red", NA, "blue", "green", "blue", "red", "red", 
                    "blue", "green", "blue", "blue", "green", "red", "red", NA, NA, "red", 
                    "green", "red", "red", NA, "green", NA, "blue", "green", "green", 
                    "red", "green", "blue", NA)
           
           mtcars <- cbind(mtcars, col)
           
           # What class is column col?
           class(mtcars$col)
           
### 5) --- Select cars with a V-shaped engine.
           ?mtcars
           subset(mtcars, vs == 0) # how I did it
           mtcars[mtcars$vs == 0, ] # how teacher did it
              # I think mine's easier
           
        
              
           
# --- EXERCISE 3.10.8 -- Lists -------------------------------------------------

## Lists are general containers that can be used to store a set of different objects under one name 
## (that is, the name of the list) in an ordered way.
## These objects can be matrices, vectors, data frames, even other lists, etc.
   lst <- list(45, "Lars", TRUE, 80.5)
   lst
   
## Elements can be accessed using brackets:
   x <- lst[2]
   x
   
   y <- lst[[2]]
   y
   
### 1) --- What is the class of the two objects x and y? What is the difference between using one or two brackets?
           class(x)
           class(y)
           
           # 2 brackets = selecting a component from a list
           # 1 bracket = selecting an element from a component. Each component in a list can be matrix/vector/dataframe/... and thus contain its own elements
           
### 2) --- Add names age, name, male and weight to the 4 components of the list.
           names(lst) <- c("age", "name", "male", "weight")
           lst
           
### 3) --- Extract the name component using the $ operator.
           lst$name
   
## You can add/change/remove components using:
   lst$height <- 173  # add component
   lst$name <- list(first = "Lars", last = "Nielsen")  # change the name component
   lst$male <- NULL   # remove male component
   lst
   
### 4) --- Extract the last name component using the $ operator.
           lst$name$last

           
           
           
           
# --- EXERCISE 3.10.9 -- String Management -------------------------------------

## Strings in R can be defined using single or double quotes:
   str1 <- "Business Analytics (BA) refers to the scientific process of transforming data into insight for making better decisions in business."
   
   str2 <- 'BA can both be seen as the complete decision making process for solving a business problem or as a set of methodologies that enable the creation of business value.'
   
   str3 <- c(str1, str2)  # vector of strings
   
## The stringr package in tidyverse provides many useful functions for string manipulation. We will consider a few.
   str4 <- str_c(str1, 
                 str2, 
                 "As a process it can be characterized by descriptive, predictive, and prescriptive model building using data sources.",
                 sep = " ")   # join strings
   str4
   
   ?str_c
   str_c(str3, collapse = " ")    # collapse vector to a string
   
   ?str_replace
   str_replace(str2, "BA", "Business Analytics")  # replace first occurrence
   
   ?str_replace_all
   str_replace_all(str2, "the", "a")              # replace all occurrences
   
   ?str_remove
   str_remove(str1, " for making better decisions in business")
   
   ?str_detect
   str_detect(str2, "BA")  # detect a pattern
   
### 1) --- Is Business (case sensitive) contained in str1 and str2?
           str_detect(str1, "Business")
           str_detect(str2, "Business")
   
### 2) --- Define a new string that replace BA with Business Analytics in str2
           str_q2 <- str_replace_all(str2, "BA", "Business Analytics")
           
### 3) --- In the string from Question 2, remove "or as a set of methodologies that enable the creation of business value".
           str_q2
           str_q3 <- str_remove(str_q2, " or as a set of methodologies that enable the creation of business value")
           
### 4) --- In the string from Question 3, add "This course will focus on programming and descriptive analytics.".
           str_q4 <- str_c(str_q3, "This course will focus on programming and descriptive analytics.", sep = " ")
           
### 5) --- In the string from Question 4, replace analytics with business analytics.
           str_q5 <- str_replace(str_q4, "analytics", "business analytics")
           
### 6) --- Do all calculations in Question 2-5 using pipes.
           str_q6 <- str_replace_all(str2, "BA", "Business Analytics") %>% 
           str_remove(" or as a set of methodologies that enable the creation of business value") %>% 
           str_c("This course will focus on programming and descriptive analytics.", sep = " ") %>% 
           str_replace("analytics", "business analytics")
           
           #Is it the same?
           str_q5 == str_q6   
