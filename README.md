# Maui County Water Samples

## Project Description

This project compiles and standardizes post-fire volatile organic compound (VOC) water sampling data from Maui County to enable comparison with our lab’s independent tap water sampling conducted following the August 2023 Lahaina fires. Each dataset contains results for a suite of VOCs (e.g., benzene, toluene, ethylbenzene, xylene) analyzed across multiple sample locations and dates.

## Project Structure

```text
voc_ws_comparison/
├─ _targets/                         # {targets} cache (auto-generated)
├─ assets/                           # Figures/images used in the report
├─ data/
│  ├─ 01_raw/                        # Immutable, view-only inputs
│  ├─ 02_interim/                    # Staged/cleaned artifacts (ok to overwrite)
│  └─ 03_output/                     # Final deliverables (GPKG/CSV/GeoJSON previews)
├─ R/                                # Modular functions for {targets} pipeline
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
├─ docs/                             # Published report output (GitHub Pages)
├─ renv/                             # renv project library (auto-managed)
├─ _quarto.yml                       # Quarto project config (outputs to docs/)
├─ _targets.R                        # {targets} pipeline (builds data + report)
├─ _targets.yaml
├─ .gitignore
├─ .Rprofile                         # renv activation
├─ README.md
├─ renv.lock                         # Locked package versions
└─ report.qmd                        # Report source (rendered by pipeline)
```

## Tasks

- [x] Extract sample coordinates from Maui County’s Water Advisory Area Address Locator web app  
- [ ] Clean, standardize, and parse VOC results into long format  
- [ ] Compare spatial and temporal patterns between County and lab samples  
- [ ] Visualize detections and summarize findings for communication (maps, timeline plots, poster graphics)

## Quick Links

<p>
  <a href="https://alemarieceria.github.io/voc_ws_comparison/index.html">
    <img alt="View Live Report" src="https://img.shields.io/badge/%F0%9F%93%9A%20View%20Live%20Report-yellow">
  </a>
  <a href="https://github.com/alemarieceria/voc_ws_comparison/issues/new?template=review_feedback.yml">
    <img alt="Give Feedback" src="https://img.shields.io/badge/%F0%9F%93%9D%20Give%20Feedback-blue">
  </a>
  <a href="https://github.com/alemarieceria/voc_ws_comparison/issues/new?template=request.yml">
    <img alt="Request an Analysis" src="https://img.shields.io/badge/%F0%9F%93%8A%20Request%20an%20Analysis-purple">
  </a>  
  <a href="https://github.com/alemarieceria/voc_ws_comparison/discussions/new?category=q-a">
    <img alt="Ask a Question" src="https://img.shields.io/badge/%F0%9F%93%96%20Ask%20a%20Question-green">
  </a>  
  <a href="https://github.com/alemarieceria/voc_ws_comparison/issues/new?template=task.yml">
    <img alt="Create a Task" src="https://img.shields.io/badge/%F0%9F%A7%B9%20Create%20a%20Task-orange">
  </a>  
  <a href="https://github.com/alemarieceria/voc_ws_comparison/issues/new?template=bug.yml">
    <img alt="Report a Bug" src="https://img.shields.io/badge/%F0%9F%90%9B%20Report%20a%20Bug-red">
  </a>  
</p>

## Reproduce Locally

### 1) Clone the repository
> Pick **one** method.

**HTTPS (easiest)**

```bash
git clone https://github.com/alemarieceria/voc_ws_comparison.git
cd voc_ws_comparison
```

**SSH (if you’ve set up SSH keys)**

```bash
git clone git@github.com:alemarieceria/voc_ws_comparison.git
cd voc_ws_comparison
```

### 2) Set up R environment

In R / RStudio / Positron:

```{r}
renv::restore()
```

### 3) Build the pipeline and report

```{r}
targets::tar_make()
```

Outputs:

1. `docs/index.html` (Website)
2. `data/02_interim/2025_11_03_raw_ws_locations_sfs_list.RData` (Queried data)
3. `data/03_output/2025_11_03_standardized_ws_names_and_locations.csv` (Processed dataset)
4. `data/03_output/2025_11_03_standardized_ws_names_and_locations.gpkg` (Processed spatial layer)

## Contact

Maintainer: @alemarieceria
