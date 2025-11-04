# R/03_exporting/export_ws_layer.R

export_ws_sf <- function(sf_obj, out_path) {
  dir.create(dirname(out_path), showWarnings = FALSE, recursive = TRUE)
  sf::st_write(sf_obj, dsn = here::here(out_path), driver = "GPKG", delete_dsn = TRUE)
  if (interactive()) message("Exported to: ", out_path)
  out_path
}