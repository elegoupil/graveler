body <- function() {
  dashboardBody(
    unhcrshiny::theme_shinydashboard_unhcr(),
    tags$head(
      tags$script(src = "custom.js")
    ),
    tabItems(
      #Add ui module here - separated with a coma!
      mod_home_ui("home_ui_1")
    )
  )
}
