#### Preamble ####
# Purpose: Use opendatatoronto to get transit delay data
# Author: Michael Do
# Contact: micheal.do@mail.utoronto.ca
# Date: 20 January 2021
# Pre-requisites: none
# TODOs:

#### Workspace set-up ####
library(opendatatoronto)
library(tidyverse)

#### Get data ####
all_data <-
  opendatatoronto::search_packages("Streetcar Delays Data") %>%
  opendatatoronto::list_package_resources() %>%
  filter(name == "ttc-streetcar-delay-data-2018") %>%
  select(id) %>%  
  opendatatoronto::get_resource()


#### Combine all data into one data frame ####  
all_data_combined <- full_join(all_data$`Jan 2018`,all_data$`Feb 2018 `)
all_data_combined <- full_join(all_data_combined,all_data$`Mar 2018`)
all_data_combined <- full_join(all_data_combined,all_data$`Apr 2018 `)
all_data_combined <- full_join(all_data_combined,all_data$`May 2018 `)
all_data_combined <- full_join(all_data_combined,all_data$`June 2018 `)
all_data_combined <- full_join(all_data_combined,all_data$`July 2018`)
all_data_combined <- full_join(all_data_combined,all_data$`Aug 2018 `)
all_data_combined <- full_join(all_data_combined,all_data$`Sept 2018 `)
all_data_combined <- full_join(all_data_combined,all_data$`Oct 2018 `)
all_data_combined <- full_join(all_data_combined,all_data$`Nov 2018 `)
all_data_combined <- full_join(all_data_combined,all_data$`Dec 2018 `)


#### Clean the data ####
toronto_delay <- all_data_combined #changed variable name from all_data_combined to toronto_delay
toronto_delay$Route <- as.character((toronto_delay$Route)) #changed route variable type from factor to character
toronto_delay$`Report Date`<- as.character((toronto_delay$`Report Date`)) #changed report date variable type from factor to character

toronto_delay <-
  toronto_delay %>% #mutated values to show only the month instead of full dates
  mutate(`Report Date` = case_when(
    str_detect(`Report Date`, "2018-01") ~ "01",
    str_detect(`Report Date`, "2018-02") ~ "02",
    str_detect(`Report Date`, "2018-03") ~ "03",
    str_detect(`Report Date`, "2018-04") ~ "04",
    str_detect(`Report Date`, "2018-05") ~ "05",
    str_detect(`Report Date`, "2018-06") ~ "06",
    str_detect(`Report Date`, "2018-07") ~ "07",
    str_detect(`Report Date`, "2018-08") ~ "08",
    str_detect(`Report Date`, "2018-09") ~ "09",
    str_detect(`Report Date`, "2018-10") ~ "10",
    str_detect(`Report Date`, "2018-11") ~ "11",
    str_detect(`Report Date`, "2018-12") ~ "12",
    TRUE ~ `Report Date`
  ))

#### Save data ####
write_csv(all_data_combined, "inputs/data/raw_data.csv")