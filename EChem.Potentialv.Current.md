EChem Data: Potential vs. Current
================
Sandra McClure
7/19/2020

``` r
knitr::opts_chunk$set(echo = TRUE, error = TRUE)
```

Original graph taken from Excel:

``` original
![](hello.jpeg)
```

Just some setup things :)

``` setup
install.packages("readr")
install.packages("ggplot2")

library(readr)
library(ggplot2)
```

``` load
Echem <- read.csv("concentrations v peak.csv")
str(Echem)
```

New and improved graph\!

``` graph
data(Echem)

ggplot(data = Echem, aes(x = Potential.V, y = X6.00E.05)) +
     geom_line(aes(y=X1.00E.04), color = "red") +
     geom_line(aes(y=X8.00E.05), color = "orange") +
     geom_line(aes(y=X6.00E.05), color = "yellow") +
     geom_line(aes(y=X4.00E.05), color = "green") +
     geom_line(aes(y=X2.00E.05), color = "blue") +
     geom_line(aes(y=X1.00E.05), color = "purple") +
     geom_line(aes(y=X8.00E.06), color = "pink") +
     labs(title = "Potential vs. Current", subtitle = "Analysis of peak position and height as a funciton \nof the analyte concentrations", x = "Potential (V)", y = "Current (Amp)")
```
