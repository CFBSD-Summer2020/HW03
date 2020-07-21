HW03
================
Andrea Watson
7/20/2020

## Objective

I am interested in using the New York Times’ publicly available COVID-19
[data](https://github.com/nytimes/covid-19-data/tree/b229258ee82e415b33abde8c26fedd57ee48509a)
to explore the number of cases and deaths in Cook County, Illinois in
the context of the Illinois and Chicago executive and public health
orders.

## Importing packages

``` r
library("dplyr")
library("ggplot2")
```

## Setting theme

``` r
my_theme <- theme_bw() + 
  theme(axis.text.x = element_text(angle = 45, hjust = 1))
theme_set(my_theme)
```

## Analysis

### Exploring data

The NYTimes historical county data can be downloaded
[here](https://github.com/nytimes/covid-19-data/blob/b229258ee82e415b33abde8c26fedd57ee48509a/us-counties.csv).
This dataset contains the the cumulative number of COVID-19 deaths and
cases in each county, over time. Their counts include both confirmed and
probable COVID-19 cases and deaths.

``` r
county_data <- read.csv("us-counties.csv", colClasses = c("Date", "factor", "factor", "integer", "integer", "integer"))

str(county_data)
```

    ## 'data.frame':    350365 obs. of  6 variables:
    ##  $ date  : Date, format: "2020-01-21" "2020-01-22" ...
    ##  $ county: Factor w/ 1906 levels "Abbeville","Acadia",..: 1579 1579 1579 412 1579 1269 412 1579 1061 1021 ...
    ##  $ state : Factor w/ 55 levels "Alabama","Alaska",..: 52 52 52 15 52 5 15 52 3 5 ...
    ##  $ fips  : int  53061 53061 53061 17031 53061 6059 17031 53061 4013 6037 ...
    ##  $ cases : int  1 1 1 1 1 1 1 1 1 1 ...
    ##  $ deaths: int  0 0 0 0 0 0 0 0 0 0 ...

I am interested in the data for Cook County, Illinois. There are
seperate columns in this dataset for state and county, so I first want
to make sure there isn’t another Cook County that exists outside of
Illinois.

``` r
county_data %>% 
  filter(county == "Cook") %>% 
  group_by(state) %>% 
  summarize()
```

    ## # A tibble: 3 x 1
    ##   state    
    ##   <fct>    
    ## 1 Georgia  
    ## 2 Illinois 
    ## 3 Minnesota

Wow, I did not know that there were Cook Counties in Georgia and
Minnesota\! I’ll have to be sure to use only Cook County, Illinois data
in my analysis. Let’s look at cases and deaths over time in Cook County.

``` r
cook_county <- county_data %>%
  filter(state == "Illinois" & county == "Cook")

cook_county %>% ggplot(aes(date, cases)) +
  geom_line(aes(group = 1)) +
  scale_x_date(date_labels = "%b %d", date_breaks = "1 month") +
  theme(axis.text.x = element_text(angle = 45))
```

![](HW03-code_files/figure-gfm/cook%20county%20cases%20and%20deaths-1.png)<!-- -->

``` r
cook_county %>% ggplot(aes(date, deaths)) +
  geom_line(aes(group = 1)) +
  scale_x_date(date_labels = "%b %d", date_breaks = "1 month") +
  theme(axis.text.x = element_text(angle = 45))
```

![](HW03-code_files/figure-gfm/cook%20county%20cases%20and%20deaths-2.png)<!-- -->

Alright, so that’s what the raw data looks like. Obviously the total
number of cases and deaths will continue to go up over time. But what
I’m really interested in is the rate of change of these numbers. Is
the number of new cases and new deaths each day increasing, or
decrasing? To look at this, I added new columns to the NYTimes data set
showing the number of new cases or new deaths daily and plotted those.

``` r
cook_county_rates <- cook_county %>%
  arrange(date) %>%
  mutate(new_cases = cases - lag(cases))  %>%
  mutate(new_deaths = deaths - lag(deaths))

ggplot(cook_county_rates, aes(date, new_cases)) +
  geom_line(aes(group = 1)) +
  scale_x_date(date_labels = "%b %d", date_breaks = "1 month")
```

![](HW03-code_files/figure-gfm/add%20rate%20columns-1.png)<!-- -->

``` r
ggplot(cook_county_rates, aes(date, new_deaths)) +
  geom_line(aes(group = 1)) +
  scale_x_date(date_labels = "%b %d", date_breaks = "1 month")
```

![](HW03-code_files/figure-gfm/add%20rate%20columns-2.png)<!-- -->

Finally, I would like to mark on which days different government public
health orders were implemented. Specifically:

  - 2020-03-09: [Gubernatorial disaster
    proclamation](https://www2.illinois.gov/sites/gov/Documents/CoronavirusDisasterProc-3-12-2020.pdf)
  - 2020-03-26: [Phase I: strict
    stay-at-home](https://www.chicago.gov/content/dam/city/sites/covid/Lakeshore%20Parks%20Ban%20Order%203.26.20.pdf)
  - 2020-05-01: [Phase II: stay-at-home
    Illinois](https://www.nbcchicago.com/news/coronavirus/illinois-is-already-in-phase-2-of-reopening-heres-when-phase-3-could-begin/2267532/)
  - 2020-06-03: [Phase III: cautiously
    reopen](https://www.chicago.gov/content/dam/city/depts/cdph/HealthProtectionandResponse/FINAL%20CDPH%20Order%202020-9%20-%20Cautiously%20Reopen.pdf)
  - 2020-06-26: [Phase IV: gradually
    resume](https://www.chicago.gov/content/dam/city/sites/covid/health-orders/FINAL%20CDPH%20Order%202020-9%20-%20Cautiously%20Reopen%206-26-2020V6.pdf)

<!-- end list -->

``` r
cook_county_rates %>% ggplot(aes(date, new_cases)) +
  geom_vline(xintercept = as.numeric(as.Date("2020-03-09")), color = "#00BFC4", size=1) +
  geom_vline(xintercept = as.numeric(as.Date("2020-03-26")), color = "#00BFC4", size=1) +
  geom_vline(xintercept = as.numeric(as.Date("2020-05-01")), color = "#00BFC4", size=1) +
  geom_vline(xintercept = as.numeric(as.Date("2020-06-03")), color = "#00BFC4", size=1) +
  geom_vline(xintercept = as.numeric(as.Date("2020-06-26")), color = "#00BFC4", size=1) +
  geom_line(aes(group = 1)) +
  scale_x_date(date_labels = "%b %d", date_breaks = "1 month") +
  theme(axis.text.x = element_text(angle = 45)) +
  ggtitle("New COVID-19 Cases per Day in Cook County, Illinois") +
  xlab("Date") + ylab("New Cases per Day") +
  labs(caption = "Data from The New York Times, based on reports from state and local health agencies.") +
  annotate(geom = "text", x = as.Date("2020-03-08"), y=2250, label = "Disaster\nProclamation", size = 3, hjust = 1) +
  annotate(geom = "text", x = as.Date("2020-03-27"), y=2250, label = "Phase I", size = 3, hjust = 0) +
  annotate(geom = "text", x = as.Date("2020-05-02"), y=2250, label = "Phase II", size = 3, hjust = 0) +
  annotate(geom = "text", x = as.Date("2020-06-04"), y=2250, label = "Phase III", size = 3, hjust = 0) +
  annotate(geom = "text", x = as.Date("2020-06-27"), y=2250, label = "Phase IV", size = 3, hjust = 0)
```

![](HW03-code_files/figure-gfm/include%20phase%20info-1.png)<!-- -->

``` r
cook_county_rates %>% ggplot(aes(date, new_deaths)) +
  geom_vline(xintercept = as.numeric(as.Date("2020-03-09")), color = "#00BFC4", size=1) +
  geom_vline(xintercept = as.numeric(as.Date("2020-03-26")), color = "#00BFC4", size=1) +
  geom_vline(xintercept = as.numeric(as.Date("2020-05-01")), color = "#00BFC4", size=1) +
  geom_vline(xintercept = as.numeric(as.Date("2020-06-03")), color = "#00BFC4", size=1) +
  geom_vline(xintercept = as.numeric(as.Date("2020-06-26")), color = "#00BFC4", size=1) +
  geom_line(aes(group = 1)) +
  scale_x_date(date_labels = "%b %d", date_breaks = "1 month") +
  theme(axis.text.x = element_text(angle = 45)) +
  ggtitle("New COVID-19 Deaths per Day in Cook County, Illinois") +
  xlab("Date") + ylab("New Deaths per Day") +
  labs(caption = "Data from The New York Times, based on reports from state and local health agencies.") +
  annotate(geom = "text", x = as.Date("2020-03-08"), y=150, label = "Disaster\nProclamation", size = 3, hjust = 1) +
  annotate(geom = "text", x = as.Date("2020-03-27"), y=150, label = "Phase I", size = 3, hjust = 0) +
  annotate(geom = "text", x = as.Date("2020-05-02"), y=150, label = "Phase II", size = 3, hjust = 0) +
  annotate(geom = "text", x = as.Date("2020-06-04"), y=150, label = "Phase III", size = 3, hjust = 0) +
  annotate(geom = "text", x = as.Date("2020-06-27"), y=150, label = "Phase IV", size = 3, hjust = 0)
```

![](HW03-code_files/figure-gfm/include%20phase%20info-2.png)<!-- -->
