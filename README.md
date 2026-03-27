# Heart Failure Prediction Dataset Analysis

This repository contains a reproducible analysis of the [Heart Failure Prediction Dataset](https://www.kaggle.com/datasets/fedesoriano/heart-failure-prediction) from Kaggle. The report summarizes clinical characteristics of 918 patients by heart disease status and visualizes how maximum heart rate varies across chest pain types.

## Docker Instructions

### Building the Docker Image

To build the Docker image locally:
```
docker build -t aslihuang/bios550final .
```

Or pull the pre-built image from DockerHub:
```
docker pull aslihuang/bios550final
```

The image is publicly available at: [https://hub.docker.com/r/aslihuang/bios550final](https://hub.docker.com/r/aslihuang/bios550final)

### Generating the Report via Docker

To generate the report using Docker, run:
```
make docker_run
```

This mounts a local `report/` directory into the container. When the command finishes, the compiled report will be available at `report/report.html`.

**Note for Windows users (Git Bash):** You may need to run the docker command manually with an extra `/` at the start of the path:
```
mkdir -p report
docker run --rm -v "/$(pwd)/report":/project/report aslihuang/bios550final
```

## Local Build Instructions (without Docker)

### Synchronize Package Environment
```
make install
```

This runs `renv::restore()` to install the exact package versions recorded in `renv.lock`.

### Build the Report
```
make
```

This will:

1. Run `code/make_table.R` to create the summary table (`output/table1.rds`)
2. Run `code/make_figure.R` to create the boxplot figure (`output/figure1.png`)
3. Render `report.Rmd` into `report.html`

To clean all generated files:
```
make clean
```

## Repository Contents

| File/Folder | Description |
|---|---|
| `Dockerfile` | Builds a Docker image with all dependencies for reproducible report generation |
| `data/heart.csv` | Heart failure prediction dataset (918 observations, 12 variables) |
| `code/make_table.R` | **Creates Table 1** — clinical characteristics by heart disease status, saved to `output/table1.rds` |
| `code/make_figure.R` | **Creates Figure 1** — boxplot of maximum heart rate by chest pain type and heart disease status, saved to `output/figure1.png` |
| `report.Rmd` | Main R Markdown report that reads pre-built table and figure from `output/` |
| `output/` | Directory for generated table and figure (created by `make`) |
| `Makefile` | Build rules including `install`, `docker_build`, `docker_run`, and report generation |
| `renv.lock` | Lock file capturing exact R package versions |
| `renv/` | renv library and settings |

## Report Overview

The report includes:

- **Table 1**: A descriptive summary comparing age, sex, resting BP, cholesterol, fasting blood sugar, max heart rate, exercise angina, and oldpeak between patients with and without heart disease.
- **Figure 1**: A boxplot showing maximum heart rate distributions across four chest pain types (Typical Angina, Atypical Angina, Non-Anginal Pain, Asymptomatic), stratified by heart disease status.
