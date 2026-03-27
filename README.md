# Heart Failure Prediction Dataset Analysis

This repository contains a reproducible analysis of the [Heart Failure Prediction Dataset](https://www.kaggle.com/datasets/fedesoriano/heart-failure-prediction) from Kaggle. The report summarizes clinical characteristics of 918 patients by heart disease status and visualizes how maximum heart rate varies across chest pain types.

## Generating the Final Report

First, synchronize the R package environment used in this project:
```
make install
```

This runs `renv::restore()` to install the exact package versions recorded in `renv.lock`.

Then, build the final report:
```
make
```

This will:

1. Run `code/make_table.R` to create the summary table (`output/table1.rds`)
2. Run `code/make_figure.R` to create the boxplot figure (`output/figure1.png`)
3. Render `report.Rmd` into `report.html`

To clean all generated files and start fresh:
```
make clean
```

## Repository Contents

| File/Folder | Description |
|---|---|
| `data/heart.csv` | Heart failure prediction dataset (918 observations, 12 variables) |
| `code/make_table.R` | **Creates Table 1** — clinical characteristics by heart disease status, saved to `output/table1.rds` |
| `code/make_figure.R` | **Creates Figure 1** — boxplot of maximum heart rate by chest pain type and heart disease status, saved to `output/figure1.png` |
| `report.Rmd` | Main R Markdown report that reads pre-built table and figure from `output/` |
| `output/` | Directory for generated table and figure (created by `make`) |
| `Makefile` | Build rules including `install` for package restoration and rules for generating the report |
| `renv.lock` | Lock file capturing exact R package versions used in this project |
| `renv/` | renv library and settings |

## Report Overview

The report includes:

- **Table 1**: A descriptive summary comparing age, sex, resting BP, cholesterol, fasting blood sugar, max heart rate, exercise angina, and oldpeak between patients with and without heart disease.
- **Figure 1**: A boxplot showing maximum heart rate distributions across four chest pain types (Typical Angina, Atypical Angina, Non-Anginal Pain, Asymptomatic), stratified by heart disease status.
