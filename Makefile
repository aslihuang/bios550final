.PHONY: clean

# Build the final report
report.html: report.Rmd output/table1.rds output/figure1.png
	Rscript -e "rmarkdown::render('report.Rmd', output_file = 'report.html')"

# Create Table 1
output/table1.rds: code/make_table.R data/heart.csv
	Rscript code/make_table.R

# Create Figure 1
output/figure1.png: code/make_figure.R data/heart.csv
	Rscript code/make_figure.R

# Clean generated files
clean:
	rm -f output/table1.rds output/figure1.png report.html
