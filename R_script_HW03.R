library(readxl)
library(ggplot2)
my_data <- read_excel("Conv_data_for_HW03.xlsx", sheet = 1)

fCategory <- as.factor(my_data$Category)
fSex <- as.factor(my_data$Sex)
Transit_time <- my_data$`transit-time`
Transit_rate <- my_data$`transit-rate`
Pellets_per_hour <- my_data$`pellets/hr`
Pellet_capacity <- my_data$`pellet-capacity`
Total_intestine_length_cm <- my_data$`total-intestinal-length`
Small_intestine_length_cm <- my_data$`before-cecum`
Colon_length_cm <- my_data$`colon-length(cm)`
Cecum_length_cm <- my_data$`cecum-length(cm)`
my_data_with_factors <- cbind(my_data, Transit_time, fCategory, fSex)

transit_time_by_category_sexes_pooled <- ggplot(
  my_data_with_factors, aes(x = fCategory, y = Transit_time, color = fSex)) + 
  geom_point(alpha = 0.6, position = position_jitterdodge(jitter.width = 0.5, dodge.width = 0.5)) +
  theme_bw() +
  geom_boxplot() +
  scale_y_continuous(limits = c(0, 10))

transit_rate_by_category_sexes_pooled <- ggplot(
  my_data_with_factors, aes(x = fCategory, y = Transit_rate, color = fSex)) + 
  geom_point(alpha = 0.6, position = position_jitterdodge(jitter.width = 0.5, dodge.width = 0.5)) +
  theme_bw() +
  geom_boxplot()

pellets_per_hour_by_category_sexes_pooled <- ggplot(
  my_data_with_factors, aes(x = fCategory, y = Pellets_per_hour, color = fSex)) + 
  geom_point(alpha = 0.6, position = position_jitterdodge(jitter.width = 0.5, dodge.width = 0.5)) +
  theme_bw() +
  geom_boxplot()

pellet_capacity_by_category_sexes_pooled <- ggplot(
  my_data_with_factors, aes(x = fCategory, y = Pellet_capacity, color = fSex)) + 
  geom_point(alpha = 0.6, position = position_jitterdodge(jitter.width = 0.5, dodge.width = 0.5)) +
  theme_bw() +
  geom_boxplot()

total_intestinal_length_by_category_sexes_pooled <- ggplot(
  my_data_with_factors, aes(x = fCategory, y = Total_intestine_length_cm, color = fSex)) + 
  geom_point(alpha = 0.6, position = position_jitterdodge(jitter.width = 0.5, dodge.width = 0.5)) +
  theme_bw() +
  geom_boxplot()

small_intestine_length_by_category_sexes_pooled <- ggplot(
  my_data_with_factors, aes(x = fCategory, y = Small_intestine_length_cm, color = fSex)) + 
  geom_point(alpha = 0.6, position = position_jitterdodge(jitter.width = 0.5, dodge.width = 0.5)) +
  theme_bw() +
  geom_boxplot()

colon_length_by_category_sexes_pooled <- ggplot(
  my_data_with_factors, aes(x = fCategory, y = Colon_length_cm, color = fSex)) + 
  geom_point(alpha = 0.6, position = position_jitterdodge(jitter.width = 0.5, dodge.width = 0.5)) +
  theme_bw() +
  geom_boxplot()

cecum_length_by_category_sexes_pooled <- ggplot(
  my_data_with_factors, aes(x = fCategory, y = Cecum_length_cm, color = fSex)) + 
  geom_point(alpha = 0.6, position = position_jitterdodge(jitter.width = 0.5, dodge.width = 0.5)) +
  theme_bw() +
  geom_boxplot()

transit_time_by_category_sexes_pooled
transit_rate_by_category_sexes_pooled
pellets_per_hour_by_category_sexes_pooled
pellet_capacity_by_category_sexes_pooled
total_intestinal_length_by_category_sexes_pooled
small_intestine_length_by_category_sexes_pooled
colon_length_by_category_sexes_pooled
cecum_length_by_category_sexes_pooled




