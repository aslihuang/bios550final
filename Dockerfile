FROM --platform=linux/amd64 rocker/tidyverse:4.4.3

# Install additional system dependencies
RUN apt-get update && apt-get install -y \
    libxml2-dev \
    libfontconfig1-dev \
    && rm -rf /var/lib/apt/lists/*

# Install renv
RUN R -e "install.packages('renv', repos = 'https://cloud.r-project.org')"

# Copy project files
RUN mkdir /project
COPY . /project
WORKDIR /project

# Restore R packages from renv.lock
RUN R -e "renv::restore(prompt = FALSE)"

# Create output directory
RUN mkdir -p report output

# Default command: build table, figure, report, then copy to mounted folder
CMD Rscript code/make_table.R && \
    Rscript code/make_figure.R && \
    Rscript -e "rmarkdown::render('report.Rmd', output_file = 'report.html')" && \
    cp report.html report/
