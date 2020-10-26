# ------------------------------------------------------------------------------
# ----------------------- MODULE 3 -- EXERCISES --------------------------------
# ------------------------------------------------------------------------------

library(tfa)
library(tidyverse)

# --- EXERCISE 4.6.1 -- Conditional expressions --------------------------------

### 1) Consider object X:
       x <- c(1, 2, -3, 4)
       
     # What will this conditional expression return?
       if(all(x>0)){
         print("All Postives")
       } else {
         print("Not all positives")
       }
       
       # ANSWER: "Not all positives"
       

### 2) What will the following expression return?
       x <- c(TRUE, FALSE, TRUE, TRUE)
       all(x)
       any(x)
       any(!x)
       all(!x)
       
       # ANSWER: 
       ## FALSE
       ## TRUE
       ## TRUE
       ## FALSE
       
       
### 3) Which of the expressions above is always FALSE when at least one entry of a logical vector x is TRUE?
       
       # ANSWER: all(!x)
       
       
## Consider vector:
   x <- 1:15
   x
   
   
### 4) Use the if_else function to set elements with value below 7 to 0.
       if_else(x < 7, as.integer(0), x)
       
       
### 5) Use the if_else function to set elements with value below 7 or above 10 to NA_integer_ 
     # (which is the NA/missing value of an integer).
       if_else(x < 7 | x > 10, NA_integer_, x)

       
### 6) Consider code
       x <- sample(c(1:10,NA,5.5), 1)
       x
     # which generates a number from the vector c(1:10,NA,5.5).
       
     # Write code which sets object y equal to “even” if x is even, “odd” if x is odd, 
     # “decimal” if x has a decimal not zero and “missing” if x is NA. 
     # Hint: have a look at ?'%%' (the modulo operator).
       
       if (is.na(x)) {
               y <- "missing"
       } else if (x %% 2 == 0) {
               y <- "even"
       } else if (x %% 2 == 1) {
               y <- "odd"
       } else if (x %% 1 > 0) {
               y <- "decimal"
       }
       
       x
       y
       
       
# --- EXERCISE 4.6.2 -- Loops --------------------------------------------------

### 1) Using a for loop, create a vector having values 2i+4 given i=1…4
       x <- rep(NA, 4) # create empty vector
       
       for (i in 1:4) {
               x[i] <- 2 * i + 4
       }
       
       x


### 2) Using a for loop, create a vector having values 2i+4 given i=2,5,6,12
       i <- c(2, 5, 6, 12) # values of i
       x <- rep(NA, length(i)) # create empty vector
       
       for (ite in 1:length(i)) {
               x[ite] <- 2 * i[ite] + 4
       }
       
       x
       
       
### 3) Solve Question 2 using a while loop.
       i <- c(2, 5, 6, 12) # values of i
       x <- rep(NA, length(i)) # create empty vector
       ite <- 1 # set iterating number to 1
       
       while (ite <= 4) {
               x[ite] <- 2 * i[ite] + 4
               ite <- ite + 1
       }
       
       x
       
       
### 4) Solve Questions 1 and 2 using a vectorized alternative.
     # Question 1:
       i <- 1:4
       x <- 2 * i + 4
       x
       
     # Question 2:
       i <- c(2, 5, 6, 12)
       x <- 2 * i + 4
       x
       
       
       
# --- EXERCISE 4.6.2 -- Calculating distances-----------------------------------

## Consider zip codes in Jutland
   zips
       
## We want to calculate distances between a subset of zip areas:
   idx <- 1:5
   dat <- zips[idx,]
   dat
   
   distanceMat <- matrix(NA, nrow = length(idx), ncol = length(idx))
   colnames(distanceMat) <- str_c(dat$Zip[idx], dat$Area[idx], sep = " ") 
   rownames(distanceMat) <- colnames(distanceMat)
   distanceMat

## We can find average distances between two zip codes (here rows 1 and 2 in dat) using Bing maps:
   key <- "AlUJdApmvPe8y2_IMrC4j4x8fzytbD2M0SvlmpemL09ae_CWS6-IuNSgrAtXoyeP"
   url <- str_c("http://dev.virtualearth.net/REST/V1/Routes/Driving?wp.0=",
                dat$Zip[1], ",Denmark",
                "&wp.1=",
                dat$Zip[2], ",Denmark",
                "&avoid=minimizeTolls&key=", key)
   library(jsonlite)
   lst <- jsonlite::fromJSON(url)
   dist <- lst$resourceSets$resources[[1]]$travelDistance
   dist

## Note we call the Bing maps API with the two zip codes. A json file is returned and stored in a list. 
## To get the average travel distance we access travelDistance. 
## The status code should be 200 if the calculation returned is okay.  
   
### Use nested for loops to fill distanceMat with distances. 
### Assume that the distance from a to b is the same as from b to a. 
### That is, you only have to call the API once for two zip codes. 
### Use an if statement to check if the status code is okay.
    
    library(jsonlite)
    key <- "AlUJdApmvPe8y2_IMrC4j4x8fzytbD2M0SvlmpemL09ae_CWS6-IuNSgrAtXoyeP"
    
    for (i in 1:nrow(distanceMat)) {
            for (j in 1:ncol(distanceMat)) {
                    # if symmetrical distance already calculated, simply copy
                    if (!is.na(distanceMat[j,i])) {
                            distanceMat[i,j] <- distanceMat[j,i]
                            next
                    }
                    # If actual distance already calculated, next
                    if (!is.na(distanceMat[i,j])) {next}
                    
                    # Cannot calculate distance from a to a
                    if (i == j) {distanceMat[i,j] <- 0; next}
                    
                    # Calculate distance and fill in matrix
                    url <- str_c("http://dev.virtualearth.net/REST/V1/Routes/Driving?wp.0=",
                                 dat$Zip[i], ",Denmark",
                                 "&wp.1=",
                                 dat$Zip[j], ",Denmark",
                                 "&avoid=minimizeTolls&key=", key)
                    lst <- jsonlite::fromJSON(url)
                    # Check if status code is ok (calculation is correct) before filling in matrix
                    if (lst$statusCode == 200) {
                            distanceMat[i,j] <-  lst$resourceSets$resources[[1]]$travelDistance
                    }
            }
    }
    
    distanceMat

    
    
# --- EXERCISE 4.6.4 -- expand_grid --------------------------------------------

## Consider the solution of Exercise 4.6.3 and assume that you only want to calculate the distance 
## from rows 1 and 5 to rows 2 and 3 in dat.
    
### Modify the solution using expand_grid so only one loop is used.
    
    # Rebuild empty matrix
    idx <- 1:5
    dat <- zips[idx,]
    dat
    
    distanceMat <- matrix(NA, nrow = length(idx), ncol = length(idx))
    colnames(distanceMat) <- str_c(dat$Zip[idx], dat$Area[idx], sep = " ") 
    rownames(distanceMat) <- colnames(distanceMat)
    distanceMat
    
    # Call expand_grid
    ite <- expand_grid(i = c(1,5), j = 2:3)
    ite
    
    # Loop and fill matrix
    library(jsonlite)
    key <- "AlUJdApmvPe8y2_IMrC4j4x8fzytbD2M0SvlmpemL09ae_CWS6-IuNSgrAtXoyeP"
    
    for (r in 1:nrow(ite)) {
            i <- ite$i[r]
            j <- ite$j[r]
            
            if (i == j) {distanceMat[i,j] <- 0; next}
            
            url <- str_c("http://dev.virtualearth.net/REST/V1/Routes/Driving?wp.0=",
                         dat$Zip[i], ",Denmark",
                         "&wp.1=",
                         dat$Zip[j], ",Denmark",
                         "&avoid=minimizeTolls&key=", key)
            lst <- jsonlite::fromJSON(url)
            if (lst$statusCode == 200) {
                    distanceMat[i,j] <- lst$resourceSets$resources[[1]]$travelDistance
                    distanceMat[j,i] <- distanceMat[i,j]
            }
    }
    
    distanceMat
   
   
       