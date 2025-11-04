# Maui County Water Samples

## Quick Links

<p>
  <a href="https://alemarieceria.github.io/voc_ws_comparison/index.html">
    <img alt="View Live Report" src="https://img.shields.io/badge/%F0%9F%93%9A%20View%20Live%20Report-black">
  </a>
  <a href="https://github.com/alemarieceria/voc_ws_comparison/issues/new?template=review_feedback.yml">
    <img alt="Give Feedback" src="https://img.shields.io/badge/%F0%9F%93%9D%20Give%20Feedback-blue">
  </a>
  <a href="https://github.com/alemarieceria/voc_ws_comparison/issues/new?template=bug.yml">
    <img alt="Report a Bug" src="https://img.shields.io/badge/%F0%9F%90%9B%20Report%20a%20Bug-red">
  </a>
  <a href="https://github.com/alemarieceria/voc_ws_comparison/issues/new?template=request.yml">
    <img alt="Request an Analysis" src="https://img.shields.io/badge/%F0%9F%93%8A%20Request%20an%20Analysis-purple">
  </a>
  <a href="https://github.com/alemarieceria/voc_ws_comparison/discussions/new?category=q-a">
    <img alt="Ask a Question" src="https://img.shields.io/badge/%F0%9F%93%96%20Ask%20a%20Question-green">
  </a>
  <a href="https://github.com/alemarieceria/voc_ws_comparison/issues/new?template=task.yml">
    <img alt="Create a Task" src="https://img.shields.io/badge/%F0%9F%A7%B9%20Create%20a%20Task-grey">
  </a>
</p>

---

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

---

## Goals
- [x] Get coordinates for each water sampling location  
- [ ] Convert results to long format  
- [ ] Analyze/compare Maui County detections vs. our detections  
- [ ] Summarize detections per location  
- [ ] Create a timeline

---

## How to Review
1. Open the **Live report** (link above).
2. If something looks off or you have suggestions, click **“Give Feedback”** (blue button).
3. Describe the page/section and your feedback in plain language. Screenshots help!
4. For questions, use **“Ask a Question”** (green button).

Labels we use:  
`review` (feedback), `analysis`, `bug`, `improvement`, `data-request`, `question`  
Status: `status:needs-triage` → `status:in-progress` → `status:needs-review` → `status:done`  
Priority: `priority:P1` (must do), `P2` (should do), `P3` (nice to have)

---

## Reproduce Locally

In console:

```{r}
# Restore environment and install exact versions of dependencies
renv::restore()
# Rebuild data pipeline
targets::tar_make()
```

Outputs:

1. `docs/index.html`
2. `data/02_interim/2025_11_03_raw_ws_locations_sfs_list.RData`
3. `data/03_output/standardized_ws_names_and_locations.csv`
4. `data/03_output/standardized_ws_names_and_locations.gpkg`

## Contact

Maintainer: @alemarieceria