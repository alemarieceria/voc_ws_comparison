# R/02_processing/standardize_location_str.R

clean_location_str <- function(df) {
  df |>
    dplyr::mutate(
      original_location_str = stringr::str_squish(original_location_str),
      original_location_str = stringr::str_replace_all(original_location_str, "\\.", ""),
      original_location_str = stringr::str_to_upper(original_location_str)
    )
}

extract_street_name <- function(df, suffixes) {
  df |>
    dplyr::mutate(
      street_name = stringr::str_remove(
        stringr::str_to_upper(original_location_str),
        stringr::str_c("\\b(", stringr::str_c(suffixes, collapse = "|"), ")\\b.*$")
      ),
      street_name = stringr::str_squish(street_name)
    )
}

extract_and_standardize_suffix <- function(df, suffixes) {
  df |>
    dplyr::mutate(
      street_suffix = stringr::str_extract(
        stringr::str_to_upper(original_location_str),
        stringr::str_c("\\b(", stringr::str_c(suffixes, collapse = "|"), ")\\b")
      ),
      street_suffix = dplyr::case_when(
        street_suffix %in% c("ST", "STREET") ~ "ST",
        street_suffix %in% c("RD", "ROAD") ~ "RD",
        street_suffix %in% c("DR", "DRIVE") ~ "DR",
        street_suffix %in% c("AVE", "AVENUE") ~ "AVE",
        street_suffix %in% c("PL", "PLACE") ~ "PL",
        street_suffix %in% c("HWY", "HIGHWAY") ~ "HWY",
        street_suffix %in% c("CIR", "CIRCLE") ~ "CIR",
        street_suffix %in% c("LN", "LANE") ~ "LN",
        street_suffix %in% c("WAY") ~ "WAY",
        street_suffix %in% c("LOOP") ~ "LOOP",
        TRUE ~ street_suffix
      )
    )
}

standardize_location_str <- function(df, suffixes) {
  df |>
    clean_location_str() |>
    extract_street_name(suffixes) |>
    extract_and_standardize_suffix(suffixes)
}
