#### Preamble ####
# Purpose: Prepare and clean the survey data downloaded from GSS data
# Author: Ruoning Guo
# Data: 19 December 2020
# Contact: ruoning.guo@mail.utoronto.ca

poststrat <- read_csv("gss.csv")

 
# removing NA 
poststrat[poststrat=="n/a"] <- NA
poststrat[!is.na(poststrat$sex),]
poststrat[!is.na(poststrat$province),]
poststrat[!is.na(poststrat$age),]
poststrat[!is.na(poststrat$income_family),]
poststrat[!is.na(poststrat$education),]

# limiting age at above 18
poststrat[which(poststrat[,3]>=18),]

#sample 10000 observation
set.seed(1004)
poststrat <-poststrat[sample(1:nrow(poststrat) , 10000),]

#### Workspace setup ####
library(plyr)
library(broom) 
library(here)
library(skimr) 
library(foreign)
# Read in the raw data.
setwd("C:/Users/Alienware/Desktop/STA304 Final")


# Add the labels
poststrat <- labelled::to_factor(poststrat)

# Just keep some variables that may be of interest (change 
# this depending on your interests)
poststrat <-poststrat %>% mutate(age_group = case_when(age >=60 ~ "ages60plus",
                                                       age >= 45  & age <= 59 ~ "ages45to59",
                                                       age >= 30  & age <= 44 ~ "ages30to44",
                                                       age >= 18  & age <= 29 ~ "ages18to29"))


poststrat <- poststrat %>% select(sex, province, age, income_family, education, age_group)

# Saving the census data as a csv file in my
# working directory

write_csv(poststrat, "C:/Users/Alienware/Desktop/STA304 Final/poststrat.csv")



         