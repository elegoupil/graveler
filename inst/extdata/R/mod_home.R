# Module UI Home
#' @title mod_home_ui and mod_home_server
#' @description A shiny module.
#' @import shiny
#' @import shinydashboard
#' @noRd
#' @keywords internal

mod_home_ui <- function(id) {
	ns <- NS(id)
	tabItem(
		tabName = "home",
		absolutePanel(  ## refers to a css class
		  id = "splash_panel", top = 0, left = 0, right = 0, bottom = 0,
		  ### Get the name for your tool
		  p(
		    tags$span("Dashboard ", style = "font-size: 60px"),
		    tags$span("template", style = "font-size: 24px")
		  ),
		  br(),
		  ### Then a short explainer
		  p("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do
		  eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad
		  minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip
		  ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate
		  velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat
		  cupidatat non proident, sunt in culpa qui officia deserunt mollit anim
		  id est laborum.",
		    style = "font-size: 20px"),
		  br(),
		  br(),
		  p(tags$i( class = "fa fa-github"),
		    "App built with ",
		    tags$a(href="https://iom.github.io/graveler/",
		           "{graveler}" ),
		    " -- report ",
		    tags$a(href="https://github.com/iom/graveler/issues/new/choose",
		           "issues here." ,
		    ),
		    style = "font-size: 10px")
		)
	)
}

# Module Server
#' @import shiny
#' @import shinydashboard
#' @noRd
#' @keywords internal

mod_home_server <- function(input, output, session) {
	ns <- session$ns

}

## copy to body.R
# mod_home_ui("home_ui_1")

## copy to app_server.R
# callModule(mod_home_server, "home_ui_1")

## copy to sidebar.R
# menuItem("displayName",tabName = "home",icon = icon("user"))

