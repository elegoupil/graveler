#' UI
#'
#' This function is internally used to manage the UI entry point
#'
#' @import shiny
#' @import shinydashboard
#' @noRd
#' @keywords internal
app_ui <- function() {
  tagList(
    golem_add_external_resources()
  )
  dashboardPage(
    header(),
    sidebar(),
    body(  )
  )
}
