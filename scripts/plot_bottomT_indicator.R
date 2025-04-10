
### Project name: Longfin ESP Report Card
### Code purpose: Create and plot bottom temperature indicator

### Author: Stephanie Owen
### Date started: 4/10/25

### Code reviewer:
### Date reviewed:

# Libraries & functions ----
`%>%` <- magrittr::`%>%`

# Data ----
bottomT <- read.csv(here::here("inputs/GLORYS_monthly_BottomT_ECOMON6_1993_2024.csv"))

# Analyses ----

## Filter area to MAB and SNE, months to Apr-Jun and Oct-Dec ----
bottomT_subset <- bottomT %>%
  dplyr::filter(area %in% c('MIDDLE_ATLANTIC_BIGHT','SOUTHERN_NEW_ENGLAND'))  %>%
  dplyr::filter(month %in% c('April','May','June','October','November','December')) %>%
  dplyr::filter(statistic == 'mean')

## Create 'Spring' and 'Fall' seasons ----

bottomT_season <- bottomT_subset %>%
  dplyr::mutate(season = dplyr::case_when(month %in% c("April","May","June") ~ "Spring",
                                          month %in% c("October","November","December") ~ "Fall")) %>%
  dplyr::select(-month)

## Group by year+season, calculate mean for each season per year ----

temp_indicator <- bottomT_season %>%
  dplyr::group_by(year, season) %>%
  dplyr::mutate(mean = mean(value)) %>%
  dplyr::select(-c(area,statistic,value)) %>%
  dplyr::rename(DATA_VALUE = mean,
                INDICATOR_NAME = var.name,
                YEAR = year) %>%
  dplyr::distinct()

## Plot facet by season ----

plt_bt <- function(data) {
  plt <- data |>
    dplyr::group_by(INDICATOR_NAME, season) |>
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
    # ggplot2::xlim(c(1989, 2024)) +
    ggplot2::scale_x_continuous(breaks = c(1996, 2000, 2010, 2020, 2024),
                                limits = c(1996, 2024)) +
    ggplot2::scale_y_continuous(labels = scales::comma) +
    ggplot2::theme_classic(base_size = 16) +
    ggplot2::theme(strip.text = ggplot2::element_text(size = 16),
                   axis.title = ggplot2::element_blank(),
                   axis.text.x = ggplot2::element_text(angle = 30,
                                                       hjust = 1),
                   aspect.ratio = 1/4) +
    ggplot2::facet_grid('season')
  
  return(plt)
}

all_indicators <- dplyr::bind_rows(
  temp_indicator)

plt_bt(temp_indicator)

all_indicators <- dplyr::bind_rows(gsi)

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
  fig <- plt_bt(this_dat)
  
  ggplot2::ggsave(fname,
                  width = 6,
                  height = 4)
  
}
