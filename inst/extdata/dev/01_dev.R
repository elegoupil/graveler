## Go to function_documentation.Rmd to build your back office functions with Fusen
rstudioapi::navigateToFile("dev/function_documentation.Rmd")
## Get your function and then build your package with 
fusen::inflate(flat_file = "dev/function_documentation.Rmd", vignette_name = "Development")

## Make sure to update imported libraries in the package namespace
attachment::att_amend_desc()


## Build the html package documentation for your utilities functions   
pkgdown::build_site()


## Go to run_dev.R and ensure the empty dashboard loads
rstudioapi::navigateToFile("dev/run_dev.R")
## Alternatively you can run golem::run_dev()

## Now start adding modules from console 
# Modules are like the pipe between your back-office functions and your user
# Name of the module - "my_first_module"
# graveler::level_up(name = "my_first_module") 

## Add manifest for CI/CD 
rsconnect::writeManifest()

