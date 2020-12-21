#### Preamble ####
# Purpose: Prepare and clean the survey data downloaded from GSS
# Author: Ruoning Guo
# Data: 19 December 2020
# Contact: ruoning.guo@mail.utoronto.ca

survey <- read_csv("CES2019.csv")

#### Workspace setup ####
library(haven)
library(broom) 
library(here)
library(skimr) 
setwd("C:/Users/Alienware/Desktop/STA304 Final")

# Add the labels
survey <- labelled::to_factor(survey)


# Just keep some variables
survey <- survey%>%select(cps19_gender, cps19_yob, cps19_province, cps19_income_number, cps19_education, 
                          cps19_votechoice, cps19_fed_id, cps19_lead_int_113)

survey <- survey %>% mutate(agesurvey = 2019-survey$cps19_yob)
agesurvey <- 2019-survey$cps19_yob 

survey <-survey %>% mutate(age_group = case_when(agesurvey >=60 ~ "ages60plus",
                                                 agesurvey >= 45  & agesurvey <= 59 ~ "ages45to59",
                                                 agesurvey >= 30  & agesurvey <= 44 ~ "ages30to44",
                                                 agesurvey >= 18  & agesurvey <= 29 ~ "ages18to29"))


#### What else???? ####
# Maybe make some age-groups?
# Maybe check the values?
# Is vote a binary? If not, what are you going to do?

survey<-survey %>%
  mutate(Trudeau = ifelse(!is.na (cps19_lead_int_113=="Justin Trudeau"), 1, 0))

attach(survey)
survey <- survey[!is.na(cps19_gender), ]
survey <- survey[!is.na(cps19_yob),]
survey <- survey[!is.na(cps19_province),]
survey <- survey[!is.na(cps19_income_number),]
survey <- survey[!is.na(cps19_education),]
survey <- survey[!is.na(cps19_votechoice),]
survey <- survey[!is.na(cps19_fed_id),]
survey <- survey[!is.na(Trudeau),]


survey %>%
  summarise(raw_prop=sum(survey$Trudeau,na.rm=TRUE)/nrow(survey))



# Saving the survey/sample data as a csv file in my
# working directory
getwd()

write_csv(survey, "C:/Users/Alienware/Desktop/STA304 Final/survey.csv")







