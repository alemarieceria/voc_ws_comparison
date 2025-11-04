# R/01_importing/download_arcgis_ws_layers.R

download_single_ws_layer <- function(layer_name, layer_no) {
  base_url <- "https://services3.arcgis.com/fsrDo0QMPlK9CkZD/arcgis/rest/services/SAMPLES/FeatureServer"
  params <- list(where = "1=1", outFields = "*", returnGeometry = "true", f = "geojson")
  query_url <- httr::modify_url(glue("{base_url}/{layer_no}/query"), query = params)

  if (interactive()) message("Downloading ", layer_name)
  sf_obj <- tryCatch(
    {
      sf::st_read(query_url, quiet = TRUE) |>
        janitor::clean_names()
    },
    error = function(e) {
      warning("Failed to read layer: ", layer_name, " (", e$message, ")")
      NULL
    }
  )

  if (interactive()) message("Finished downloading ", layer_name)

  sf_obj
}

