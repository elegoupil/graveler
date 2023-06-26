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

  contents <- c(
    paste("Package:", text_list$pkg_name),
    paste("Title:", text_list$title),
    "Version: 0.0.900",
    paste("Author:", text_list$username),
    "Maintainer: Name FirstName <unhcrid@unhcr.org>",
    "Description: Your Description Here.",
    "Encoding: UTF-8",
    "License: MIT + file LICENSE"
  )

  writeLines(contents, con = file.path(path, "DESCRIPTION"))

  url <- "https://rstudio.unhcr.org/"

  header <- c(
    "header <- function() {",
    "\tdashboardHeader(",
    "\t\ttitle = tagList(",
    paste0("\t\t\tspan(class = 'logo-lg',a(\"", text_list$title, "\",style=\"color:white !important\",href='", url, "')),") ,
    #paste0("\t\t\ta(style = \"margin: -15px\", href='", url ,"', img(src = \"www/graveler_sprite.svg\", width=\"225%\"))"),
    #"\t\t),",
    #"\t\tcontrolbarIcon = \"gear\"",
    "\t) )",
    "}"
  )

  writeLines(header, con = file.path(paste0(path, "/R"), "header.R"))

}
