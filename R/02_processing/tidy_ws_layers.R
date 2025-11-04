# R/02_processing/tidy_ws_layers.R

# ------------------------------------------------------------------
# Function: tidy_hydrant_ws_df()
# Purpose:
# ------------------------------------------------------------------
tidy_hydrant_ws_df <- function(df, suffixes) {
  df |> 
    dplyr::select(
    object_id = objectid,
    original_location_str = location,
    site = fh_number,
    no_samples,
    results = results_fh,
    geometry
  ) |>
  dplyr::filter(!is.na(original_location_str)) |>
  standardize_location_str(suffixes) |>
  dplyr::mutate(
    notes = dplyr::if_else(
      street_name == "TMK 4-6-015:003",
      "Near Ulupalakua, not sure if it's the same site",
      NA_character_
    ),
    no_samples = as.integer(no_samples)
  )
}

# ------------------------------------------------------------------
# Function: tidy_property_ws_df()
# Purpose:
# ------------------------------------------------------------------
tidy_property_ws_df <- function(df, suffixes) {
  df |> 
    dplyr::select(
    object_id = objectid,
    original_location_str = location,
    site = property,
    no_samples = no_of_samples,
    results = results_property,
    geometry
  ) |> 
  standardize_location_str(suffixes) |>
  dplyr::mutate(
    no_samples = as.integer(no_samples)
  )
}

# ------------------------------------------------------------------
# Function: tidy_wtp_tk_ws_df()
# Purpose:
# ------------------------------------------------------------------
tidy_wtp_tk_ws_df <- function(df, suffixes) {
  df |> 
    dplyr::select(
    object_id = objectid,
    original_location_str = location,
    site = wtp_tank,
    no_samples = number_samples,
    results = result_wtp_tk,
    geometry
  ) |> 
  standardize_location_str(suffixes) |>
  dplyr::mutate(
    no_samples = as.integer(no_samples)
  )
}

tidy_single_ws_layer <- function(raw_layer, suffixes) {
  # Identify layer type by the presence of signature columns
  nms <- names(raw_layer)

  if (any(grepl("^fh_number$", nms, ignore.case = TRUE))) {
    out <- tidy_hydrant_ws_df(raw_layer, suffixes)
  } else if (any(grepl("^property$", nms, ignore.case = TRUE))) {
    out <- tidy_property_ws_df(raw_layer, suffixes)
  } else if (any(grepl("wtp|tank", nms, ignore.case = TRUE))) {
    out <- tidy_wtp_tk_ws_df(raw_layer, suffixes)
  } else {
    stop(
      "Unknown layer type; cannot match expected columns in: ",
      paste(nms, collapse = ", ")
    )
  }

  if (interactive()) message("Finished tidying layer.")
  out
}