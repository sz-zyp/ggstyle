#' Custom Scientific Theme
#'
#' A custom theme designed for scientific plots, featuring a clean and professional look suitable for research presentations and publications. It includes white backgrounds, minimal grid lines, and a bold title and axis labels.
#'
#' @param base_size The base font size for the theme. Default is 14.
#'
#' @return A `ggplot2` theme object with custom settings for scientific plots.
#' @export
#'
#' @examples
#' ggplot(mtcars, aes(x = wt, y = mpg,fill=carb)) +
#'   geom_point() +
#'   theme_style1(base_size = 14) +
#'   labs(title = "Car Weight vs MPG")
#'
theme_style1 <- function(base_size=14) {
  # ggthemes::theme_foundation(base_size=base_size)# +
  # theme_bw()+
  ggthemes::theme_base(base_size=base_size) +
    theme(
      # text = element_text(family = "Arial"),
      panel.background  = element_rect(fill = "white"),
      plot.background  = element_rect(fill = "white", colour = NA),
      panel.grid.major  = element_line(colour = "white", linewidth = 0.3),
      panel.grid.minor  = element_blank(),
      legend.position  = "bottom",
      legend.key.size  = unit(0.8, "cm"),
      plot.title  = element_text(face = "bold", hjust = 0.5, size = rel(1.2)),
      axis.title  = element_text(face = "bold")
    )
}
