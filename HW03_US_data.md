HW03\_US\_data
================
Patrick Haller
7/17/2020

``` r
knitr::opts_chunk$set(echo = TRUE, error = TRUE)
```

## HW03 Patrick Haller

**First things first, I want to make sure to load ggplot2, so that it
can be used for plotting later on.**

``` r
library("ggplot2")
```

**For this assignment, my goal is to make some graphs illustrating the
progression of COVID cases in the U.S. over time. For this, I went to
the NY Time’s github repository and downloaded their raw data on the
total number of cases and deaths in the U.S. since the first reported
case on 01/21/2020. Next, I uploaded the .csv file of the data (named:
us.csv) to my repository for HW03 and read it in from there:**

### Importing data

``` r
# read in data from us.csv file
US_data <- read.csv("us.csv", stringsAsFactors = FALSE)
```

**Here, the values in the “date” column are stored as *character (chr)*
values. However, we can also store them to *date* values, using the
`as.Date()` function:**

``` r
# convert from chr values to date values
US_data$date <- as.Date(US_data$date, format = "%Y-%m-%d")
```

**Using this data, I wanted to plot the total number of cases and deaths
in the United States over time:**

### Graph \#1

``` r
# the scales package will help with formatting the x-axis
library(scales)

ggplot(data = US_data) + 
  # separately adding geom_col() layers for covid cases and deaths
  geom_col(aes(x = date, y = cases), color = "blue", fill = "blue", alpha = 0.2) +
  geom_col(aes(x = date, y = deaths), color = "red", fill = "red", alpha = 0.2) +
  # formatting x and y axes
  scale_x_date(name = "Date", labels = date_format("%m/%d")) +
  scale_y_continuous(name="Total Number of Cases/Deaths", limits=c(0, 3800000), breaks = seq(0, 3800000, 500000)) +
  # adding title and subtitle
  labs(title = "COVID Data United States", subtitle = "Total number of cases and deaths since first reported case on 01/21/2020") +
  # add classic theme for background
  theme_classic() +
  # manually add a legend
  annotate("text", x = as.Date("2020-02-01", "%Y-%m-%d"), y = 3250000, label = "Cases =") +
  annotate("text", x = as.Date("2020-02-20", "%Y-%m-%d"), y = 3250000, label = "blue", color = "blue") +
  annotate("text", x = as.Date("2020-02-02", "%Y-%m-%d"), y = 3000000, label = "Deaths =") +
  annotate("text", x = as.Date("2020-02-20", "%Y-%m-%d"), y = 3000000, label = "red", color = "red") +
  annotate("rect", xmin = as.Date("2020-01-21", "%Y-%m-%d"), xmax = as.Date("2020-02-27", "%Y-%m-%d"), ymin = 2800000, ymax = 3400000, color = "grey", alpha = 0.2)
```

![](HW03_US_data_files/figure-gfm/graph%201-1.png)<!-- -->

**Additionally, instead of just plotting the total number of
cases/deaths, I also wanted to plot the number of cases/deaths per day.
For this, I created two new variables, showing only the number of new
cases *(named: diff\_cases)* and deaths *(named: diff\_deaths)* each day
using the `lead()` function of the dplyr package:**

``` r
library(dplyr)
```

    ## 
    ## Attaching package: 'dplyr'

    ## The following objects are masked from 'package:stats':
    ## 
    ##     filter, lag

    ## The following objects are masked from 'package:base':
    ## 
    ##     intersect, setdiff, setequal, union

``` r
# add variables for cases per day and deaths per day
US_data$diff_cases <- lead(US_data$cases, 1) - US_data$cases
US_data$diff_deaths <- lead(US_data$deaths, 1) - US_data$deaths
```

### Graph \#2

``` r
ggplot(data = US_data) + 
  # separately adding geom_col() layers for covid cases and deaths
  geom_col(aes(x = date, y = diff_cases), color = "blue", fill = "blue", alpha = 0.2) +
  geom_col(aes(x = date, y = diff_deaths), color = "red", fill = "red", alpha = 0.2) +
  # formatting x and y axes
  scale_x_date(name = "Date", labels = date_format("%m/%d")) +
  scale_y_continuous(name="Number of Cases/Deaths per day") +
  # adding title and subtitle
  labs(title = "COVID Data United States", subtitle = "Number of new cases and deaths per day since first reported case on 01/21/2020") +
  # adding classic theme for background
  theme_classic() +
  # manually add a legend
  annotate("text", x = as.Date("2020-02-01", "%Y-%m-%d"), y = 65000, label = "Cases =") +
  annotate("text", x = as.Date("2020-02-20", "%Y-%m-%d"), y = 65000, label = "blue", color = "blue") +
  annotate("text", x = as.Date("2020-02-02", "%Y-%m-%d"), y = 60000, label = "Deaths =") +
  annotate("text", x = as.Date("2020-02-20", "%Y-%m-%d"), y = 60000, label = "red", color = "red") +
  annotate("rect", xmin = as.Date("2020-01-21", "%Y-%m-%d"), xmax = as.Date("2020-02-27", "%Y-%m-%d"), ymin = 56000, ymax = 68000, color = "grey", alpha = 0.2)
```

    ## Warning: Removed 1 rows containing missing values (position_stack).
    
    ## Warning: Removed 1 rows containing missing values (position_stack).

![](HW03_US_data_files/figure-gfm/graph%202-1.png)<!-- -->
