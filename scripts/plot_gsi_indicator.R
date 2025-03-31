`%>%` <- magrittr::`%>%`

data <- ecodata::gsi
gsi <- create_gsi(data) %>%
  dplyr::filter(Var == 'gulf stream index') %>%
  dplyr::rename(INDICATOR_NAME = Var,
                YEAR = Year,
                DATA_VALUE = Value) %>%
  dplyr::group_by(YEAR) %>%
  dplyr::mutate(avg = mean(DATA_VALUE))

plt_indicator_gsi(gsi)

plt_indicator_gsi <- function(data) {
  plt <- data |>
    dplyr::group_by(INDICATOR_NAME) |>
    dplyr::mutate(mean = mean(DATA_VALUE, na.rm = TRUE),
                  sd = sd(DATA_VALUE, na.rm = TRUE)) |>
    ggplot2::ggplot(ggplot2::aes(x = YEAR,
                                 y = avg
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
    ggplot2::scale_x_continuous(breaks = c(2000, 2010, 2020),
                                limits = c(1996, 2023)) +
    ggplot2::theme_classic(base_size = 16) +
    ggplot2::theme(strip.text = ggplot2::element_text(size = 16),
                   axis.title = ggplot2::element_blank(),
                   aspect.ratio = 1/4)
  
  return(plt)
}
