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

plt_indicator <- function(data) {
  plt <- data |>
    dplyr::group_by(INDICATOR_NAME) |>
    dplyr::mutate(mean = mean(DATA_VALUE, na.rm = TRUE),
                  sd = sd(DATA_VALUE, na.rm = TRUE)) |>
    ggplot2::ggplot(ggplot2::aes(x = YEAR,
                                 y = DATA_VALUE
    )) +
    ggplot2::geom_hline(ggplot2::aes(
      yintercept = .data$mean + .data$sd
    ),
    color = "darkgreen",
    linetype = "solid"
    ) +
    ggplot2::geom_hline(ggplot2::aes(
      yintercept = .data$mean - .data$sd
    ),
    color = "darkgreen",
    linetype = "solid"
    ) +
    ggplot2::geom_hline(ggplot2::aes(
      yintercept = .data$mean
    ),
    color = "darkgreen",
    linetype = "dotted"
    ) +
    ggplot2::geom_point() +
    ggplot2::geom_path() +
    ggplot2::xlim(c(1996, 2023)) +
    ggplot2::scale_y_continuous(labels = scales::comma) +
    ggplot2::scale_x_continuous(breaks = c(2000, 2010, 2020, 2023),
                                limits = c(1996, 2023)) +
    ggplot2::theme_classic(base_size = 16) +
    ggplot2::theme(strip.text = ggplot2::element_text(size = 16),
                   axis.title = ggplot2::element_blank(),
                   aspect.ratio = 1/4) 
  
  return(plt)
}

###plot
plt_indicator(landings)
plt_indicator(vessels)
plt_indicator(revenue)


all_indicators <- dplyr::bind_rows(landings,
                                   vessels,
                                   revenue)

for(i in unique(all_indicators$INDICATOR_NAME)) {
  this_dat <- all_indicators |>
    dplyr::filter(INDICATOR_NAME == i) |>
    dplyr::arrange(YEAR)
  
  fname <- here::here("images", paste0(i, "_", Sys.Date(), ".png"))
  if(max(this_dat$DATA_VALUE, na.rm = TRUE) > 10^6) {
    this_dat <- this_dat |>
      dplyr::mutate(DATA_VALUE = ifelse(!is.na(DATA_VALUE), DATA_VALUE/10^6, DATA_VALUE),
                    INDICATOR_NAME = paste(INDICATOR_NAME, "millions"))
    fname <-  here::here("images", paste0(i, "_millions_", Sys.Date(), ".png"))
  }
  
  print(fname)
  fig <- plt_indicator(this_dat)
  
  ggplot2::ggsave(fname,
                  width = 6,
                  height = 2)
  
}
