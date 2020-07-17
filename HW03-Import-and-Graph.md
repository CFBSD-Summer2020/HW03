HW03
================
Laura Cespedes Arias

## Package loading

``` r
library("ggplot2")
library("tidyverse")
```

    ## ── Attaching packages ─────────────────────────────────────────────────────────── tidyverse 1.3.0 ──

    ## ✓ tibble  3.0.1     ✓ dplyr   0.8.5
    ## ✓ tidyr   1.0.2     ✓ stringr 1.4.0
    ## ✓ readr   1.3.1     ✓ forcats 0.4.0
    ## ✓ purrr   0.3.4

    ## ── Conflicts ────────────────────────────────────────────────────────────── tidyverse_conflicts() ──
    ## x dplyr::filter() masks stats::filter()
    ## x dplyr::lag()    masks stats::lag()

``` r
library("lubridate")
```

    ## 
    ## Attaching package: 'lubridate'

    ## The following object is masked from 'package:base':
    ## 
    ##     date

## Data import and subsetting

I used a table with information about the coronavirus in the US, at the
state level. This is available in a [NY Times
repository](https://github.com/nytimes/covid-19-data).

``` r
corona_by_state <- read.csv("https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-states.csv",h=T)
```

Below, I made a few adjustments to the dataset. Specificically, I wanted
the dates to be read as such, and created three separate columns with
year, month and day. This WAS be important for making the figure.

``` r
corona_by_state$date <- as.Date(corona_by_state$date)

corona_by_state = corona_by_state %>% 
  mutate(date = ymd(date)) %>% 
  mutate_at(vars(date), funs(year, month, day))

corona_by_state$month <- as.factor(corona_by_state$month)
```

Finally, I was only interested in the data for the states of Illinois
and Arizona so I subseted the
table:

``` r
corona_ill_ari <- subset(corona_by_state,state=="Illinois"|state=="Arizona")
```

## Figure

I was interested in visualizing the number of cases per month and per
state. So, this is what I
did:

``` r
ggplot(corona_ill_ari,mapping = aes(x = month, y = cases, fill=state, color=state)) +
  #To add boxes with a transparency
  geom_boxplot(alpha=0.6) +
  #To add points
  geom_jitter(position = position_jitterdodge(4)) +
  #To change the default grey background
  theme_bw()+
  #To add title and change the default size
  ggtitle(label="Coronavirus cases by month",subtitle="For Illinois and Arizona")+
  theme(plot.title = element_text(size = 25))+
  #To add axes labels
  xlab("Month (2020)") +
  ylab("Number of cases") +
  theme(axis.text.x = element_text(color="black", size=14, angle=45,hjust=1))+
  theme(axis.text.y = element_text(color="black", size=10))+
  theme(axis.title = element_text(color="black", size=20))+
  scale_x_discrete(labels=c("January","February","March","April","May","June","July"))+
  #To change the position of the legend and it's size
  theme(legend.position = c(0.25, 0.7))+
  theme(legend.title = element_text(size = 20),legend.text = element_text(size = 15))
```

![](HW03-Import-and-Graph_files/figure-gfm/pressure-1.png)<!-- -->
