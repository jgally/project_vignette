"# project_vignette" 

#Below is what I copied from GitHub to set up the proper connection
echo "# project_vignette" >> README.md
git init
git add README.md
git commit -m "first commit"
git branch -M main
git remote add origin https://github.com/jgally/project_vignette.git
git push -u origin main  

#This is what the instructions said to do which, appears to me, that it did nothing
rmarkdown::render("Project 2.Rmd", output_format = "github_document", output_file = "README.md")  