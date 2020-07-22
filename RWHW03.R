setwd(/Users/johnmoten/Desktop/BSDG30901)

library(ggplot2)
library(readxl)

usstates<-read.excel("us-states.xlsx", sheet = 1)

state <- usstates$state
date <- usstates$date
deaths <- usstates$deaths
cases <- usstates$cases


ggplot(usstates, aes(date, deaths)) +
  geom_line(group = state) +
  geom_smooth(group = 1, size = 3, method = "lm", se = FALSE) +
  labs(title = "COVID Deaths over Time", x = "Time") +
