#Creating README.md  
library(rmarkdown)
rmarkdown::render("C:/Users/nowat/OneDrive/Documents/ST558 Work/project_vignette/Project2.Rmd",  
                  output_format = "github_document",
                  output_file = "README.md"
)  

#checking that the file pathway actually exists
file.exists("C:/Users/nowat/OneDrive/Documents/ST558 Work/project_vignette/Project2.Rmd")

