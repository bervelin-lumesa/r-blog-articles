########################################################
# By Bervelin Lumesa                                   #
#                                                      #
# Mail     : lumesabervelin@gmail.com                  #
# Github   : https://github.com/bervelin-lumesa        #
# Twitter  : https://twitter.com/bervelinL             #
# Linkedin : https://linkedin/in/bervelin-lumesa       #
########################################################

# loading libraries
library(tidyverse)
library(questionr)
library(naniar)

# dataset to use
data(hdv2003) 

# making a tibble
hdv2003 <- as_tibble(hdv2003)

# dimension of dataset
dim(hdv2003) 

# names of variables
names(hdv2003) 

# the structure of the dataset
str(hdv2003) 

# first six rows of the dataset
head(hdv2003) 

# last six rows of the dataset
tail(hdv2003) 

# summary of the dataset variables
summary(hdv2003)

# usmmary of Age variable
summary(hdv2003$age)

# frequency table
freq(hdv2003$relig)

# plot of missing data
vis_miss(hdv2003)

# desciptive statistics with group_by()
hdv2003 %>%
  group_by(trav.satisf) %>%
  summarise(min    = min(heures.tv, na.rm = T),
            mean   = mean(heures.tv, na.rm = T),
            median = median(heures.tv, na.rm = T),
            max    = max(heures.tv, na.rm = T))

# histogram
ggplot(data = hdv2003) + 
  geom_histogram(aes(x = hdv2003$age))

# multiple histograms
ggplot(data = hdv2003) + 
  geom_histogram(aes(x = hdv2003$age)) + 
  facet_wrap(~ relig)

# boxplot
ggplot(data = hdv2003) + 
  geom_boxplot(aes(x = occup, y = heures.tv, color = occup)) + 
  theme(legend.position = "none")

# scatterplot
ggplot(data = hdv2003) + 
  geom_point(aes(x = age, y = poids, color = sexe)) 

# create a new variable with mutate()
hdv2003 %>%
  mutate(minutes.tv = heures.tv * 60) %>% 
  select(heures.tv, minutes.tv)


