sidebar <- function() {
  dashboardSidebar(
    sidebarMenu(
      ## Here the menu item entry to the first module 
      menuItem("About",tabName = "home",icon = icon("bookmark"))
      # - add more - separated by a comma!
    )
  )
}
