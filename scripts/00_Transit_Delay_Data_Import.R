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

#### Save data ####
write_csv(all_data_combined, "inputs/data/raw_data.csv")