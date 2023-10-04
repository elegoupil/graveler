#' Graveler Module
#'
#' Creates module of the specified name
#' 
#' @param name name 
#' @param pkg package name 
#' @param open boolean
#' @param dir_create boolean
#' @import golem
#' @import cli
#' @import glue
#' @import rstudioapi
#'
#' @export

level_up <- function(name,
                     pkg = get_graveler_wd(),
                     open = TRUE,
                     dir_create = TRUE) {
  library(golem)
  library(cli)
  
  old <- setwd(normalizePath(pkg))
  on.exit(setwd(old))
  
  dir_created <- create_dir_if_needed("R", dir_create)
  
  if (!dir_created) {
    cat_red_bullet("File not added (needs a valid directory)")
    return(invisible(FALSE))
  }
  
  where <- file.path("R", paste0("mod_", name, ".R"))
  
  if (!check_file_exist(where)) {
    return(invisible(FALSE))
  }
  
  file.create(where)
  
  write_there <- function(...) {
    write(..., file = where, append = TRUE)
  }
  
  glue <- function(...) {
    glue::glue(..., .open = "%", .close = "%")
  }
  
  write_there("#' Module UI")
  write_there(" ")
  write_there(glue("#' @title mod_%name%_ui and mod_%name%_server"))
  write_there("#' @description A shiny module.")
  write_there("#' @description A shiny module.")
  write_there("#' @param id,input,output,session Internal parameters for {shiny}.")
  write_there("#'")
  write_there("#' @noRd ")
  write_there("#' @import shiny ")
  write_there("#' @import shinydashboard ")
  write_there("#' @keywords internal")
  write_there(" ")
  write_there(glue("mod_%name%_ui <- function(id) {"))
  write_there("\tns <- NS(id)")
  write_there("\ttabItem(")
  write_there(glue("\t\ttabName = \"%name%\","))
  write_there("\t\tfluidRow(")
  
  
  write_there("\t\t\t\t column(")
  write_there("\t\t\t\t width = 12,")
  write_there("\t\t\t\t\t\t h2('Recall the name of the module'),")
  write_there("\t\t\t\t\t\t p(\"Explain what the module is about...\")")
  write_there("\t\t\t\t\t )")
  write_there("\t\t\t\t ),")
  write_there("\t\t\t\t \t\t")
  write_there("\t\t\t\t fluidRow(")
  write_there("\t\t\t\t shinydashboard::box(")
  write_there("\t\t\t\t  title = \"Module Step\",")
  write_there("\t\t\t\t  #  status = \"primary\",")
  write_there("\t\t\t\t  status = \"info\",")
  write_there("\t\t\t\t  solidHeader = FALSE,")
  write_there("\t\t\t\t  collapsible = TRUE,")
  write_there("\t\t\t\t  width = 12,")
  write_there("\t\t\t\t  \"Content\"")
  
  write_there("## do not forget that all elements ID of the GUI needs to be called with ns(\"ID\")....")
  write_there("\t\t\t\t  )")
  
  write_there("\t\t\t")
  write_there("\t\t)")
  write_there("\t)")
  write_there("}")
  write_there(" ")
  write_there("#' Module Server")
  write_there("#' @noRd ")
  write_there("#' @import shiny ")
  write_there("#' @import tidyverse ")
  write_there("#' @keywords internal")
  write_there(" ")
  write_there(glue("mod_%name%_server <- function(input, output, session, AppReactiveValue) {"))
  write_there("\tns <- session$ns")
  write_there("## add here the server logic part of your module....")
  write_there("}")
  write_there(" ")
  write_there("## copy to body.R")
  write_there(glue("# mod_%name%_ui(\"%name%_ui_1\")"))
  write_there(" ")
  write_there("## copy to sidebar.R")
  write_there(glue(
    "# shinydashboard::menuItem(\"displayName\",tabName = \"%name%\",icon = icon(\"user\"))"
  ))
  write_there(" ")
  write_there("## and copy to app_server.R")
  write_there(glue("# callModule(mod_%name%_server, \"%name%_ui_1\", AppReactiveValue)"))
  write_there(" ")
  
  # golem::add_fct("display", module = name)
  
  cat_green_tick(glue("Files created at %where%"))
  
  if (rstudioapi::isAvailable() & open) {
    rstudioapi::navigateToFile(where)
  } else {
    cat_bullet(glue("Go to %where%"),
               bullet = "square_small_filled",
               bullet_col = "red")
  }
}
