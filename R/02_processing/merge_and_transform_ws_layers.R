# R/02_processing/merge_and_transform_ws_layers.R

merge_and_transform_ws_layers <- function(tidied_layers) {
  merged <- dplyr::bind_rows(tidied_layers, .id = "source") |>
    sf::st_as_sf() |>
    sf::st_make_valid() |>
    sf::st_transform(4326)
  if (interactive()) message("Merged and transformed ", length(tidied_layers), " layers into one sf object.")
  merged
}
