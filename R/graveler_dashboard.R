#' Golem dashboard backend
#'
#' Creates golem directory and header from template info
#'
#' @export
graveler_dashboard <- function(path,...) {
  # ensure path exists
  dir.create(path, recursive = TRUE, showWarnings = FALSE)

  file.copy( # copies graveler folder
    system.file("extdata/.", package = "graveler", mustWork = TRUE),
    path,
    recursive = TRUE
  )

  dots <- list(...)

  text_list <- list()

  for (i in seq_along(dots)) {
    text_list[[i]] <- dots[[i]]
  }

  names(text_list) <- names(dots)
 
  ## Write the DESCRIPTION FILE
  contents <- c(
    paste("Package:", text_list$pkg_name),
    paste("Title:", text_list$title),
    "Description: Fill a longer description of your package here.",
    "Version: 0.0.900",
    paste0("Authors@R: c( person(\"", text_list$firstname,
                            "\", \"", text_list$lastname, 
                            "\", , \"", text_list$email, 
                            "\", role = c(\"aut\", \"cre\")))"),
    paste0("Maintainer:", text_list$firstname, " ", text_list$lastname, " <", text_list$email,">"),
    paste0("URL: https://github.com/", text_list$githuborg, "/", text_list$pkg_name ),  
    "License: MIT + file LICENSE",
    "Encoding: UTF-8",
    "LazyData: true"
  )

  writeLines(contents, con = file.path(path, "DESCRIPTION"))

  ## File to connect to github

  gitinst   <- c( "## Use git ----",
                  "usethis::use_git()",
                  "## Now associate your local project with the online repo your created ----",
                  paste0("usethis::use_git_remote( \"origin\", url = \"https://github.com/",
                    text_list$githuborg, "/", text_list$pkg_name, ".git\", overwrite = TRUE )")
                 )
  
  writeLines(gitinst, con = file.path(paste0(path, "/dev"), "githublink.R"))
  
  ## Prewrite tool header...
  url <- paste0("https://rstudio.unhcr.org/", text_list$pkg_name)
  header <- c(
    "header <- function() {",
    "\t shinydashboard::dashboardHeader(",
    "\t\t title = tagList(",
    paste0("\t\t\tspan(class = 'logo-lg',a(\"", text_list$title, "\",style=\"color:white !important\",href='", url, "')),") ,
    #paste0("\t\t\ta(style = \"margin: -15px\", href='", url ,"', img(src = \"www/graveler_sprite.svg\", width=\"225%\"))"),
    #"\t\t),",
    #"\t\tcontrolbarIcon = \"gear\"",
    "\t) )",
    "}"
  )

  writeLines(header, con = file.path(paste0(path, "/R"), "header.R"))

}
