# ------------------------------------------------------------------------------
# ----------------------- MODULE 5 -- EXERCISES --------------------------------
# ------------------------------------------------------------------------------

library(tfa)
library(tidyverse)

# --- EXERCISE 5.8.1 -- Defining functions--------------------------------------

### 1) Create a function sum_n that for any given value, say  n, 
     # computes the sum of the integers from 1 to n (inclusive). 
     # Use the function to determine the sum of integers from 1 to 5000. 
     # Document your function too.
    
       #' Sum of integers from 1 to n
       #'
       #' @param n max integer
       #'
       #' @return sum of integers
       #' @export
       #'
       #' @examples
       sum_n <- function(n) {
         return(sum(1:n))
       }
       
       sum_n(5000)
       
       
### 2) Write a function compute_s_n that for any given n computes the sum
     # Sn = 1^2 + 2^2 + 3^3 + ... + n^2. Report the value of the sum when n = 10.
       
       compute_s_n <- function(n) {
         return(sum((1:n)^2))
       }
       
       compute_s_n(10)
       
       
### 3) Define an empty numerical vector s_n of size 25 using s_n <- vector("numeric", 25) 
     # and store in it the results of S1 ,S2 ,… ,S25 (previous function) using a for-loop. 
     # Confirm that the formula for the sum is Sn = n ( n + 1 ) ( 2 n + 1 ) / 6 for n = 1, …, 25.
       
       # Create vector
       s_n <- vector("numeric", 25)
       
       # For loop: fill vector with compute_s_n(n)
       for (n in 1:25) {
         s_n[n] <- compute_s_n(n)
       }
       s_n
       
       # Check formula
       s_n_check <- vector("numeric", 25)
       
       for (n in 1:25) {
         s_n_check[n] <- n*(n+1)*(2*n+1)/6
       }
       
       identical(s_n, s_n_check)
       
       # Teacher solution for checking formula (seems rather inefficient)
       compute_s_n_alt <- function(n) {
         return(n*(n+1)*(2*n+1)/6)
       }
       for (n in 1:25) {
         if (s_n[n] != compute_s_n_alt(n)) {
           cat('Error!')
           break
         }
       }
       
       
### 4) Write a function biggest which takes two integers as arguments. 
     # Let the function return 1 if the first argument is larger than the second and return 0 otherwise.
       
       biggest <- function(x, y){
         if (x > y) {
           return(1)
         } else {
           return(0)
         }
       }
       
       biggest(5, 10)
       biggest(10, 5)
       
       
### 5) Write a function that returns the shipping cost as 10% of the total cost of an order (input argument).
       
       shipping_cost <- function(total) {
         return(0.1 * total)
       }
       
       shipping_cost(100)
       
       
### 6) Given Question 5, rewrite the function so the percentage is an input argument with a default of 10%
       
       shipping_cost6 <- function(total, rate = 0.1) {
         return(rate * total)
       }
       
       shipping_cost6(100)
       shipping_cost6(100, 0.2)
       
       
### 7) Given Question 5, the shipping cost can be split into parts. 
     # One part is gasoline which is 50% of the shipping cost.
     # Write a function that has total cost as input argument
     # and calculate the gasoline cost and use the function defined in Question 5 inside it.
       
       gas_cost <- function(total) {
         return(0.5 * shipping_cost(total))
       }
       
       gas_cost(100)
       
       
### 8) Given Question 6, the shipping cost can be split into parts. 
     # One part is gasoline which is 50% of the shipping cost. 
     # Write a function that has total cost as input argument 
     # and calculate the gasoline cost and use the function defined in Question 6 inside it. 
     # Hint: Use the ... argument to pass arguments to shipping_cost
       
       gas_cost8 <- function(total, ...) {
         return(0.5 * shipping_cost6(total, ...))
       }
       
       gas_cost8(100)
       gas_cost8(100, rate = 0.2)
       
       
### 9) Given Question 8, write a function costs that, given total cost, returns the total cost, shipping cost and gasoline cost.
       
       costs <- function(total, ...) {
         shipping <- shipping_cost6(total, ...)
         gas <- gas_cost8(total, ...)
         
         return(list(total_cost = total, shipping_cost = shipping, gasoline_cost = gas))
       }
       
       costs(100)
       costs(100, rate = 0.2)
       
       
       
# --- EXERCISE 5.8.2 -- Scope --------------------------------------------------
       
### 1) After running the code below, what is the value of variable x?
       x <- 3
       my_func <- function(y){
         x <- 5
         return(y + 5)
       }
       my_func(7)
       
       # ANSWER: x = 3, variables in functions are used "by value".
       # Their value is not altered outside the function.
       # Newly defined variables in functions are not available outside those functions either.
       x
       
       
### 2) Is there any problems with the following code?
       x <- 3
       my_func <- function(y){
         return(y + x) 
       }
       my_func(7)
       
       # ANSWER: No. But it is better practice to define x as a function input and not call it as global variable.
       
       
### 3) Have a look at the documentation for operator <<- (run ?'<<-'). 
       ?'<<-'
     # After running the code below, what is the value of variable x?
       x <- 3
       my_func <- function(y){
         x <- 4
         x <<- 5
         return(y + 5)
       }
       
       # ANSWER: x = 3. While <<- uses a variable "by reference" instead of the default "by value",
       # and therefore its value outside the function is changed as well, my_func is not called here.
       # So x remains 3 until my_func called, then it will be 5
       x
       my_func(1)
       x
       
       
### 4) After running the code below, what is the value of variable x and output of the function call?
       x <- 3
       my_func <- function(y){
         x <- 4
         x <<- 5
         return(y + x)
       }
       my_func(7)
       
       # ANSWER: x = 5. See explanations above.
       x
       
       
       
# --- EXERCISE 5.8.3 -- Job sequencing -----------------------------------------
       
## This exercise is based on Exercise 6.12 in Wøhlk (2010) (VBA textbook).
## Consider a problem of determining the best sequencing of jobs on a machine. A set of startup costs are given for 5 machines:
       
   startup_costs <- c(27, 28, 32, 35, 26)
   startup_costs
   
## Moreover, when changing from one job to another job, the setup costs are given as:
   
   setup_costs <- matrix(c(
     NA, 35, 22, 44, 12,
     49, NA, 46, 38, 17,
     46, 12, NA, 29, 41,
     23, 37, 31, NA, 26,
     17, 23, 28, 34, NA), 
     byrow = T, nrow = 5)
   setup_costs
   
## The goal of the problem is to determine a sequence of jobs which minimizes the total setup cost including the startup cost.
## One possible way to find a sequence is the use a greedy strategy:
   
   # Greedy Algorithm
   ## Step 0: Start with the job which has minimal startup cost.
   ## Step 1: Select the next job as the job not already done 
   ##         with minimal setup cost given current job. 
   ## Step 2: Set next job in Step 1 to current job and 
   ##         go to Step 1 if not all jobs are done.
   
## In R the greedy algorithm can be implemented as:
   
   greedy <- function(startup, setup) {
     jobs <- nrow(setup)
     cur_job <- which.min(startup)
     cost <- startup[cur_job]
     # cat("Start job:", cur_job, "\n")
     job_seq <- cur_job
     setup[, cur_job] <- NA
     for (i in 1:(jobs-1)) {
       next_job <- which.min(setup[cur_job, ])
       # cat("Next job:", next_job, "\n") 
       cost <- cost + setup[cur_job, next_job]
       job_seq <- c(job_seq, next_job)
       cur_job <- next_job
       setup[, cur_job] <- NA
     }
     # print(setup)
     return(list(seq = job_seq, cost = cost))
   }
   greedy(startup_costs, setup_costs)
   
## First, the job with minimum startup cost is found using function which.min and we define cost as the startup cost.
## We use cat to make some debugging statements and initialize job_seq with the first job.
## Next, we have to find a way of ignoring jobs already done. 
## We do that here by setting the columns of setup cost equal to NA for jobs already done.
## Hence, they will not be selected by which.min. The for loop runs 4 times and selects jobs and accumulate the total cost.
   
## A well-known better strategy is to:
   
   # Better Algorithm
   ## Step 0: Subtract minimum of startup and setup cost for each job from setup and 
   ##         startup costs (that is columnwise)
   ## Step 1: Call the greedy algorithm with the modified costs. Note that the total 
   ##         cost returned has to be modified a bit.
   
### Implement a better function calculating a better strategy.
### Hint: to find the minimum column costs, you may use apply(rbind(startup, setup), 2, min, na.rm = T).
    
    better <- function(startup, setup) {
      jobs <- nrow(setup)
      
      min_col <- apply(rbind(startup, setup), 2, min, na.rm = T)
      startup <- startup - min_col
      
      min_mat <- matrix(rep(min_col, jobs), ncol = jobs, byrow = T)
      setup <- setup - min_mat
      
      lst <- greedy(startup, setup)
      lst$cost <- lst$cost + sum(min_col)
      return(lst)
    }
    better(startup_costs, setup_costs)
       
       