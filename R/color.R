#' Choose a color palette to get colors
#'
#' This function takes a color palette name as input and returns a corresponding list of colors.
#'
#' @param palette A character string specifying the name of the color palette.
#'
#' @return A vector of color hex codes corresponding to the chosen palette.
#' @export
#'
#' @examples
#' palette2color(palette = "color1")
#' palette2color(palette = "color2")
#' palette2color(palette = c("red","blue")) # This will return to the original state
palette2color = function(palette,n=NULL,modeColor=1){
  # paletteList
  # n=10
  # modeColor=1

  if(length(palette) == 1){
    colors = paletteList[[palette]]
    if(is.null(n)){
      n=length(colors)
    }
    if (n > length(colors)){
      warning("Insufficient number of colors, interpolation will be applied")
      colorRampPalette(colors)(n)
    } else{
      if(modeColor == "auto"){
        colorRampPalette(colors)(n)
      }else if(modeColor == "1"){
        colorRampPalette(colors[1:n])(n)
      }else{
        # Do nothing for other cases
      }
    }
  } else {
    return(palette)
  }
}




#' Automated Color Setting
#'
#' Select a color palette to apply to ggplot2 plots. If the number of colors in the palette is smaller than required, it will automatically be extended.
#'
#' @param ... Additional arguments passed to the scale functions.
#' @param palette A vector of colors for the palette.
#' @param type Specifies the type of scale: either "discrete" or "continuous".
#' @param modeColor Mode of color selection; default is "auto". If "1", colors are applied one by one.
#' @param na.value The color used for missing (NA) values; default is "grey50".
#' @param aesthetics The aesthetic to map the color scale to, usually "colour".
#' @param direction The direction of the color scale; -1 means no change, 1 means reversed.
#'
#' @return A scale function for the color aesthetic.
#' @export
#'
#' @examples
#'
#' # Discrete data application
#'  ggplot(mtcars, aes(x = wt, y = mpg, color = factor(cyl))) +
#'    geom_point(size = 4) +
#'    scale_color_sci(
#'      palette = "color1",
#'      type = "discrete",
#'      modeColor = "auto",
#'      name = "Cylinders",
#'      direction = 1
#'    )
#'
#'  # Continuous data application
#'  ggplot(faithfuld, aes(waiting, eruptions, fill = density)) +
#'    geom_tile() +
#'    scale_fill_sci(
#'      palette = "color1",
#'      type = "continuous"
#'    ) +
#'    labs(title = "Custom Continuous Color Scale Application")
#'
#'
#'
scale_color_sci <- function(...,
                            palette,
                            type = c("discrete", "continuous"),
                            # discrete
                            modeColor = "auto", # 1:one by one
                            # continuous

                            na.value  = "grey50",
                            aesthetics = "colour",
                            direction = -1  # direction of the scale (reverse if 1)
) {

  colors = palette2color(palette)

  # Parameter validation and preprocessing
  type <- match.arg(type)
  if (missing(colors)) stop("A vector of colors must be provided")
  if (!is.atomic(colors))  stop("The color parameter must be an atomic vector")
  valid_colors <- tryCatch(col2rgb(colors),
                           error = function(e) stop("Contains invalid color values"))

  if (type == "continuous" && length(colors) < 2) {
    stop("A continuous palette requires at least 2 base colors")
  }

  # Handle direction (reverse if 1)
  if(direction == -1){
    colors = colors
  }else if(direction == 1){
    colors = rev(colors)
  }else{
    # do nothing for other cases
  }

  if(type == "discrete"){
    generate_palette = function(n) {
      if (n > length(colors)){
        warning("Insufficient number of colors, interpolation will be applied")
        colorRampPalette(colors)(n)
      } else{
        if(modeColor == "auto"){
          colorRampPalette(colors)(n)
        }else if(modeColor == "1"){
          colorRampPalette(colors[1:n])(n)
        }else{
          # Do nothing for other cases
        }
      }
    }

  }else if(type == "continuous"){
    generate_palette = scales::gradient_n_pal(colours = colors)
  }else{
    stop("type must be 'discrete' or 'continuous'")
  }

  # Build the scale function
  switch(type,
         discrete = discrete_scale(
           aesthetics,
           "sci_palette",
           palette = generate_palette,
           na.value  = na.value,
           ...
         ),
         continuous = continuous_scale(
           aesthetics,
           "sci_palette",
           palette = generate_palette,
           na.value  = na.value,
           guide = "colorbar",
           ...
         )
  )
}


# Companion function extension
scale_fill_sci <- function(...) {
  scale_color_sci(..., aesthetics = "fill")
}

