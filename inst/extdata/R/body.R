#' UI Body
#'
#' This function is internally used to manage the body
#'
#' @import shiny
#' @import shinydashboard
#' @importFrom iomshiny theme_shinydashboard_iom
#' @noRd
#' @keywords internal

body <- function() {
  shinydashboard::dashboardBody(
    iomshiny::theme_shinydashboard_iom(),
    golem::activate_js(),
    tags$head(
      tags$script(src = "custom.js")
    ),
    shinydashboard::tabItems(
      #Add ui module here - separated with a coma!
      mod_home_ui("home_ui_1")
    )
  )
}
