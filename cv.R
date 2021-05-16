datadrivencv::use_datadriven_cv(
  full_name = "Dennis Wollersheim",
  data_location = "https://docs.google.com/spreadsheets/d/1HPZjdhRq8xLfsWQI2AJXZ_ytuWiEktI93Rg_qz_85a4/edit?usp=sharing",
  pdf_location = "https://github.com/dewoller/cv/raw/master/docs/cv.pdf",
  html_location = "https://dewoller.github.io/cv/cv.html",
  source_location = "https://github.com/dewoller/cv",
  open_files=FALSE
)

devtools::install_github("nstrayer/datadrivencv")

params = list(pdf_mode = FALSE)


# Knit the HTML version
rmarkdown::render("cv.Rmd",
                  params = list(pdf_mode = FALSE),
                  output_file = "docs/cv.html")

# Knit the PDF version to temporary html location
tmp_html_cv_loc <- fs::file_temp(ext = ".html")
rmarkdown::render("cv.Rmd",
                  params = list(pdf_mode = TRUE),
                  output_file = tmp_html_cv_loc)

# Convert to PDF using Pagedown
pagedown::chrome_print(input = tmp_html_cv_loc,
                       output = "docs/cv.pdf")
system('evince docs/cv.pdf', wait=FALSE)
