# The data I am working on is about the life expectancy from all contries from year 1800 to 2100, 
#[Behavioral Risk Factor Surveillance System (BRFSS)](https://www.cdc.gov/brfss/about/index.htm)
library(tidyverse)
library(ggplot2)

#import and take a look at the data
life <- read.csv("life_expectancy_years.csv", header = TRUE, stringsAsFactors = FALSE, check.names = FALSE)
head(life)

# modify the dataset structure
rownames(life) <- life[,1]
life$country <- NULL

# Then, I would like to look at the life expactancy trend for China from year 1800 to 2100
year <- colnames(life)
year <- as.numeric(year)
China <- as.numeric(life[c("China"),])

# Then, I would like to look at the life expactancy trend for United States from year 1800 to 2100
year <- colnames(life)
year <- as.numeric(year)
USA <- as.numeric(life[c("United States"),])

#draw the plot
new_life <- data.frame(year, China, USA)
colors <- c("China" = "red", "USA" = "blue")

ggplot(new_life)+
  geom_point(aes(x = year, y = China, color = "China"))+
  geom_point(aes(x = year, y = USA, color = "USA"))+
  labs(title = "Life Expectancy Comparison", x = "Year", y = "Life Expectancy (age)", color = "Legend")+
  theme(plot.title = element_text(hjust = 0.5))+
  scale_color_manual(values = colors)+
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank(), axis.line = element_line(colour = "black"))

ggsave("life_expectancy.png", plot = last_plot(), scale = 1)

