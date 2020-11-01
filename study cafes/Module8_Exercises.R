# ------------------------------------------------------------------------------
# ----------------------- MODULE 8 -- EXERCISES --------------------------------
# ------------------------------------------------------------------------------

remotes::install_github("bss-osca/tfa/tfa-package", upgrade = FALSE)  # run to upgrade
library(tfa)
library(tidyverse)


# --- EXERCISE 8.5.1 -- Gapminder ----------------------------------------------

## Te gapminder data set provides values for 
## life expectancy, GDP per capita, and population, every five years, from 1952 to 2007 for 142 countries.
## The data can be loaded using the gapminder package:

   library(gapminder)
   gapminder

## Let us try to examine the data set (use pipes %>% as much as possible).
   
### 1) Use glimpse, summary and tail to examine the data.
       
       glimpse(gapminder)
       summary(gapminder)
       tail(gapminder)
       
       
### 2) Use count to count the number of
       
       # a) countries
       gapminder %>% 
         count(country) %>% 
         nrow()
       
       # b) continents
       gapminder %>% 
         count(continent) %>% 
         nrow()
       
       # c) countries per continent
       gapminder %>% 
         count(continent, country) %>% 
         count(continent)
       
       
### 3) Retrieve a vector with all distinct continent values.
       
       gapminder %>% 
         distinct(continent) %>% 
         pull(continent) %>% 
         as.character()
       

### 4) Subset rows to find:
       
       # a) all rows with life expectancy less that 29 years,
       
       gapminder %>% 
         subset(lifeExp < 29)
       
       # b) all rows for Rwanda after year 1979,
       
       gapminder %>% 
         subset(country == "Rwanda" & year > 1979)
       
       # c) all rows for Rwanda, Afghanistan or France.
       
       gapminder %>% 
         subset(country %in% c("Afghanistan", "Rwanda", "France"))
       
       # NOTE: filter() would have worked equally well here, filter() and subset() are more or less the same
       # subset() is native R, filter() is dplyr
       
       
### 5) Select columns:
       
       # a) year and life expectancy
       
       gapminder %>% 
         select(year, lifeExp)
       
       # b) country and GDP per capita
       
       gapminder %>% 
         select(country, gdpPercap)
       
       
### 6) Subset your data set to find all rows with GDP per capita greater than 40000 in Europe
     # or with GDP per capita less than 500 in Africa.
       
       gapminder %>% 
         filter((gdpPercap > 40000 & continent == "Europe") | (gdpPercap < 500 & continent == "Africa"))
       
       
### 7) Use mutate to calculate each country’s GDP (population times GDP per capita).
       
       gapminder %>% 
         mutate(gdp = pop * gdpPercap)
       
       
## In general GDP numbers are large and abstract. Let us try to calculate relative numbers.
       
### 8) Use mutate to calculate GDP per capita relative to mean GDP per capita in Denmark over the whole period
     # (gdpPercap divided by the mean of Danish gdpPercap)
     # Have a look at the calculated data. Does the numbers seems reasonable?
     # I perceive Denmark to be a “high GDP” country, so I predict that the distribution of gdpPercapRel is located below 1, possibly even well below.
       
       # First calculate mean Danish GDP per capite over whole period
       meanGDP_DK <- gapminder %>% 
         filter(country == "Denmark") %>% 
         pull(gdpPercap) %>% 
         mean()
       meanGDP_DK
       
       # Mutate new column
       gapminder %>% 
         mutate(gdpPercapReltoDK = gdpPercap / meanGDP_DK) # %>% print(n=Inf) # print all rows to examine data
       
       # Data seems right to me. Many countries are well below 1 indeed. 
       # Norway is higher than 1 for example, one of the few with higher GDP per capita than Denmark.
       
       
### 9) Use arrange to order
       
       # a) data by year then country, as opposed to current by country then year
       
       gapminder %>% 
         arrange(year, country)
       
       # b) data from 2007, sorted on life expectancy
       
       gapminder %>% 
         filter(year == 2007) %>% 
         arrange(lifeExp)
       
       # c) data from 2007, sorted on life expectancy in descending order. Hint: use desc() inside arrange.
       
       gapminder %>% 
         filter(year == 2007) %>% 
         arrange(desc(lifeExp))

       
### 10) Use select to
       
       # a) rename year to yr and keep all other columns (the select helper everything may be used)
       
       gapminder %>% 
         rename(yr = year) # using rename() just make way more sense here...
       
       # b) remove pop
       
       gapminder %>% 
         select(-pop)
       
       # c) reorder columns in order year, pop, … (remaining)
       
       gapminder %>% 
         select(year, pop, everything())
       
       
### 11) Use group_by and summarize to find the

       # a) number of observations per continent
       
       gapminder %>% 
         group_by(continent) %>% 
         count() # this made sense for me, but teacher does it as:
         # summarise(n = n())
       
       # b) number of countries per continent (use n_distinct inside summarize to count the number of distinct observations)
       
       gapminder %>% 
         group_by(continent) %>% 
         count(countries_per_continent = n_distinct(country))
       
       # c) average life expectancy by continent
       
       gapminder %>% 
         group_by(continent) %>% 
         summarise(avg_lifeExp = mean(lifeExp))
       
       # d) minimum and maximum life expectancies seen by year in Asia
       
       gapminder %>% 
         group_by(year) %>% 
         filter(continent == "Asia") %>% 
         summarise(min_lifeExp = min(lifeExp), max_lifeExp = max(lifeExp))
       
       
### 12) Sometimes you don’t want to collapse the n rows for each group into one row.
      # That is, you don’t want to use summarize but mutate within your groups.
      # Try to make a new variable that is the years of life expectancy gained (lost) relative to 1952, for each individual country.
       
       gapminder %>% 
         group_by(country) %>% 
         select(country, year, lifeExp) %>% # so table is not overcrowded
         arrange(year, .by_group = TRUE) %>% # unnecessary but good practice to make sure
         mutate(delta_lifeExp = lifeExp - first(lifeExp)) # %>% print(n=Inf)
       
       
### 13) Which country experienced the sharpest 5-year drop in life expectancy in each continent?
      # Recall that the Gapminder data only has data every five years, e.g. for 1952, 1957, etc.
      # So this really means looking at life expectancy changes between adjacent timepoints.
       
       # First group by continent and add delta_lifeExp to look at changes in lifeExp
       gapminder %>% 
         group_by(continent) %>% 
         select(continent, country, year, lifeExp) %>% # relevant variables, continent first for better readability
         mutate(delta_lifeExp = lifeExp - lag(lifeExp)) %>%  # delta looks at the difference with previous timepoint
         
       # Then filter out the year 1952 (first observation), as the delta will be very low but a meaningless value
         filter(year > 1952) %>% 
         
       # Then use slice_min() to select the lowest observation (sharpest drop) from delta_lifeExp and sort ascending
         slice_min(delta_lifeExp) %>%  # I would use top_n() as learnt on Datacamp, but its documentation points to slice_min()
         arrange(delta_lifeExp)
       
       # Results show that Oceania had no drops in life expactancy since 1952, the continent has only 2 countries though.
       # Teacher has a slightly different method.
       
       

       
       
       
   
   