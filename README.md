# Water Sample ETL Pipeline

## Goals

1. Get coordinates for each water sampling location                  [X]
2. Convert results to long format                                    [ ]
3. Analyze/compare what Maui County detected vs. what we detected    [ ]
4. Summarize detections per location                                 [ ]
3. Create a timeline                                                 [ ]

## Project Structure

voc_ws_comparison/
├─ _targets/
├─ assets/
├─ data/
│  ├─ 01_raw/                                              # Immutable, view only
│  ├─ 02_interim/                                          # Staged/cleaned data used in later steps, ok to overwrite
│  └─ 03_output/                                           # Final deliverables
├─ R/                                                      # Modular functions for target pipeline
│  ├─ _utils/
│  │  ├─ string_helpers.R
│  │  └─ suffixes.R
│  ├─ 01_importing/
│  │  ├─ download_arcgis_ws_layers.R
│  │  └─ fetch_layer_counts.R
│  ├─ 02_processing/
│  │  ├─ merge_and_transform_ws_layers.R
│  │  ├─ standardize_location_str.R
│  │  └─ tidy_ws_layers.R
│  └─ 03_exporting/
│     └─ export_ws_layer.R
├─ renv/
├─ report_files/
├─ _targets.R                                               # Main targets pipeline; outputs final datasets and report
├─ _targets.yaml
├─ .gitignore
├─ .Rprofile
├─ README.md
├─ renv.lock                                                # Dependencies tracked by `{renv}`
├─ report.html                                              # Shareable worflow doc
└─ report.qmd                                               # Workflow outputted by ETL pipeline