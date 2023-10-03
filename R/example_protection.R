#' @title Launch a small graveler example  for protection dashboard
#'
#' @description A gallery of widgets available in the package.
#'
#' @importFrom shiny shinyAppDir
#' @export
#'
#' @examples
#' if (interactive()) {
#'
#'  example_protection()
#'
#' }
example_protection <- function() { # nocov start
  if (!requireNamespace(package = "unhcrshiny"))
    message("Package 'unhcrshiny' is required to run this function. \n use install.packages(\"pak\")
\n pak::pkg_install(\"edouard-legoupil/unhcrshiny\")")
  if (!requireNamespace(package = "shinydashboard"))
    message("Package 'shinydashboard' is required to run this function")
  shiny::shinyAppDir(system.file("examples/protection", package = "graveler", mustWork = TRUE))
}
# nocov end
