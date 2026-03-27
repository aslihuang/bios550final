.PHONY: clean install docker_build docker_run

# Install R packages using renv
install:
	Rscript -e "renv::restore(prompt = FALSE)"

# Build the final report
report.html: report.Rmd output/table1.rds output/figure1.png
	Rscript -e "rmarkdown::render('report.Rmd', output_file = 'report.html')"

# Create Table 1
output/table1.rds: code/make_table.R data/heart.csv
	Rscript code/make_table.R

# Create Figure 1
output/figure1.png: code/make_figure.R data/heart.csv
	Rscript code/make_figure.R

# Build Docker image
docker_build:
	docker build -t aslihuang/bios550final .

# Run Docker container and output report to local report/ folder
docker_run:
	mkdir -p report && \
	docker run --rm \
	  -v "$$(pwd)/report":/project/report \
	  aslihuang/bios550final

# Clean generated files
clean:
	rm -f output/table1.rds output/figure1.png report.html
