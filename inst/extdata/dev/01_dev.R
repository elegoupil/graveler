## Add basic dependencies
pkgs <- c(
  "unhcrshiny",
  "devtools",
  "dplyr",
  "lubridate",
  "golem",
  "pins",
  "shiny",
  "shinyjs",
  "shinyWidgets",
  "shinydashboard",
  "shinydashboardPlus"
)

for (i in pkgs) {
  usethis::use_package(i)
}

## Add manifest for CI/CD
rsconnect::writeManifest()

## Go to run_dev.R and ensure the empty dashboard loads
rstudioapi::navigateToFile("dev/run_dev.R")

## Alternatively you can run golem::run_dev()

## Now start adding modules from console
# Name of the module - "my_first_module"
# graveler::level_up(name = "my_first_module") 


## Make sure to update imported libraries in the package namespace
attachment::att_amend_desc()