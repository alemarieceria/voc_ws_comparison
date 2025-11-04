# _targets.R

# Created by use_targets().
# Follow the comments below to fill in this target script.
# Then follow the manual to check and run the pipeline:
#   https://books.ropensci.org/targets/walkthrough.html#inspect-the-pipeline

# Load packages required to define the pipeline:
suppressWarnings(suppressMessages(library(targets)))
suppressWarnings(suppressMessages(library(tarchetypes)))

# Set target options:
tar_option_set(
  packages = c(
    "dplyr", "purrr", "sf", "glue", "janitor", "stringr", "jsonlite", "httr", 
    "here", "quarto", "readr"
  )
)

# Run the R scripts in the R/ folder with your custom functions:
tar_source()
# purrr::walk(list.files("R/functions", recursive = TRUE, full.names = TRUE), source)

list(
  # Configuration targets
  tar_target(
    feature_layers,
    list(
      "Hydrant Water Samples" = 0,
      "Property Water Samples" = 1,
      "WTP/Tank Water Samples" = 2
    )
  ),
  tar_target(
    suffixes,
    get_suffixes()
  ),

  # Metadata target
  tar_target(
    layer_counts,
    fetch_all_layer_counts(feature_layers)
  ),

  # Data acquisition targets
  tar_target(
    raw_layers,
    purrr::imap(
      feature_layers,
      ~ download_single_ws_layer(layer_name = .y, layer_no = .x)
    )
  ),

  # Processing target
  tar_target(
    tidied_layers,
    purrr::map(raw_layers, ~ tidy_single_ws_layer(.x, suffixes))
  ),

  # # Merging and transforming target
  tar_target(
    merged_ws_sf,
    merge_and_transform_ws_layers(tidied_layers)
  ),

  # Export targets
  tar_target(
    exported_ws_as_gpkg,
    export_ws_sf(
      sf_obj = merged_ws_sf,
      out_path = "data/03_output/standardized_ws_names_and_locations.gpkg"
    ),
    format = "file"
  ),
  tar_target(
    exported_ws_as_csv,
    write.csv(
      merged_ws_sf,
      here::here("data/03_output/standardized_ws_names_and_locations.csv"),
      row.names = FALSE
    ),
    format = "file"
  ),

  # Report Target
  tar_quarto(report, "report.qmd")
)
