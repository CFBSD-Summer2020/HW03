#the goal of this is to make a publication - quality bar plot with individual data points 
#overlayed on top of the bars

#let's load some packages we may need
library(dplyr)
library(ggplot2)
library(ggrepel)
library(RColorBrewer)
library(ggthemes)
library(ggpubr)

#now let's enter our data by copying in the excel file the corresponding data and running
#the read table commands

#select and copy to clipboard the table in the "individual" tab in the excel file...cells A-C 1-37
#run the code below for "data_points"
data_points <- read.table(file = "clipboard", 
                              sep = "\t", header=TRUE)

#select and copy to clipboard the table in the "bio" tab in the excel file...cells A-D 1-13
#run the code below for "bio"
bio <- read.table(file = "clipboard", 
                      sep = "\t", header=TRUE)

#let's plot our data
ggplot(bio, aes(x = RNA, y = fold_change, fill = treatment)) +
  geom_col(alpha = 0.8, position = "dodge") +
  geom_errorbar(aes(ymin = fold_change - std_dev, ymax = fold_change + std_dev), width = 0.3, 
                position=position_dodge(.9)) +
  geom_point(data = data_points, aes(x = RNA, y = fold_change, 
                                         group = treatment, alpha = 0.8, shape = 1, stroke = 2), position = position_dodge(width = 0.9)) +
  scale_shape_identity() +
  geom_hline(yintercept = 1, alpha = 0.5) +
  labs(x = "qPCR target", y = "Fold change over specificity negative control",
       title = "Testing knockdown of a lncRNA") +
  scale_y_continuous(breaks=c(0, 0.2, 0.4, 0.6, 0.8, 1, 1.2, 1.4, 1.6, 1.8, 2.0)) +
  guides(alpha = FALSE) +
  scale_fill_brewer(palette="Accent") +
  theme_tufte() +
  theme(legend.position = c(.86, .86))