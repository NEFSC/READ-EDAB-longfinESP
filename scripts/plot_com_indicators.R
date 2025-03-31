# Metadata ----

### Project name: Longfin ESP Report Card
### Code purpose: Plot Commercial Indicators

### Author: Stephanie Owen
### Date started: 3/31/25

### Code reviewer:
### Date reviewed:

# Libraries & functions ----
`%>%` <- magrittr::`%>%`

# Data ----

### read data and modify df for landings, vessels, and revenue
data <- read.csv(here::here('SOCIEOECONOMIC_COMMERCIAL_INDICATORS_LONGFINSQUID_FINAL.csv'))

landings <- data %>%
  dplyr::filter (INDICATOR_NAME == 'Commercial_LONGFINSQUID_Landings_LBS') %>%
  dplyr::mutate(DATA_VALUE = DATA_VALUE/10^6) %>% #scales from millions/lbs 
  dplyr::arrange(YEAR)

vessels <- data %>%
  dplyr::filter (INDICATOR_NAME == 'N_Commercial_Vessels_Landing_LONGFINSQUID') %>%
  dplyr::arrange(YEAR)

revenue <- data %>%
  dplyr::filter(INDICATOR_NAME == 'TOTALANNUALREV_LONGFINSQUID_2023Dols') %>%
  dplyr::mutate(DATA_VALUE = DATA_VALUE/10^6) #scales from millions/lbs

# Analyses ----

###plot
plt_indicator(landings)
plt_indicator(vessels)
plt_indicator(revenue)
