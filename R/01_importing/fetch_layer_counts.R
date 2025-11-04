# R/01_importing/fetch_layer_counts.R

fetch_single_layer_count <- function(layer_name, layer_no) {
  url <- glue::glue("https://services3.arcgis.com/fsrDo0QMPlK9CkZD/arcgis/rest/services/SAMPLES/FeatureServer/{layer_no}/query")
  params <- list(where = "1=1", returnCountOnly = "true", f = "json")

  response <- httr::GET(url, query = params)
  response_json <- jsonlite::fromJSON(httr::content(response, "text", encoding = "UTF-8"))

  tibble::tibble(layer_name, layer_no, total_records = response_json$count)
}

fetch_all_layer_counts <- function(feature_layers) {
  layer_counts <- purrr::imap_dfr(
    feature_layers,
    ~ fetch_single_layer_count(layer_name = .y, layer_no = .x)
  )

  if (interactive()) {
    message("There are ", sum(layer_counts$total_records),
            " records to pull across ", nrow(layer_counts), " layers.")
  }

  layer_counts
}
