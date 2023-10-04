#' @title Launch a small graveler example for response tracking dashboard
#'
#' @description An illustration of graveler applied to a humanitarian response 
#'             tracking dashboard
#'
#' @importFrom shiny shinyAppDir
#' @export
#'
#' @examples
#' if (interactive()) {
#'
#'  example_response()
#'
#' }
example_response <- function() { # nocov start
  if (!requireNamespace(package = "unhcrshiny"))
    message("Package 'unhcrshiny' is required to run this function. \n use install.packages(\"pak\")
\n pak::pkg_install(\"edouard-legoupil/unhcrshiny\")")
  if (!requireNamespace(package = "shinydashboard"))
    message("Package 'shinydashboard' is required to run this function")
  shiny::shinyAppDir(system.file("examples/response", package = "graveler", mustWork = TRUE))
}
# nocov end
