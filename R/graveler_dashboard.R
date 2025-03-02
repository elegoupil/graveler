#' Golem dashboard backend
#'
#' Creates golem directory and header from template info
#' 
#' @param path path to file
#' @param ... other parameters
#'
#' @export
graveler_dashboard <- function(path, ...) {
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
 
  ## Write the DESCRIPTION FILE --------------
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
  
  
  
  ## File to load the font --------------
 fontconfig   <- c("### This is done once to register the font from the package when it gets loaded!!",
                   "  .onLoad <- function(libname, pkgname) {",
                   paste0("    font_dir <- system.file(\"fonts\", package = \"", text_list$pkg_name,"\")"),
                   "    sysfonts::font_paths(font_dir)",
                   "    ## For showtext",
                   "    sysfonts::font_add(",
                   "      family = \"Lato\",",
                   "      regular = \"Lato-Regular.ttf\",",
                   "      bold = \"Lato-Bold.ttf\",",
                   "      italic = \"Lato-Italic.ttf\",",
                   "      bolditalic = \"Lato-BoldItalic.ttf\"",
                   "    )",
                   " ",
                   "    sysfonts::font_add(",
                   "      family = \"Font Awesome 6 Free Solid\",",
                   "      regular = \"fa-solid-900.ttf\"",
                   "    )",
                   " ",
                   "    showtext::showtext_auto(TRUE)",
                   " ",
                   "    ## For ragg",
                   "    sys_fonts <- systemfonts::system_fonts()",
                   " ",
                   "    if (!any(grepl(\"lato\", sys_fonts$family, ignore.case = TRUE)))",
                   "      systemfonts::register_font(name = \"Lato\",",
                   "                                 plain = file.path(font_dir, \"Lato-Regular.ttf\"),",
                   "                                 italic = file.path(font_dir, \"Lato-Italic.ttf\"),",
                   "                                 bold = file.path(font_dir, \"Lato-Bold.ttf\"),",
                   "                                 bolditalic = file.path(font_dir,",
                   "                                                        \"Lato-BoldItalic.ttf\"))",
                   "    if (!any(grepl(\"wesome\", sys_fonts$family, ignore.case = TRUE)))",
                   "      systemfonts::register_font(name = \"Font Awesome 6 Free Solid\",",
                   "                                 plain = file.path(font_dir, \"fa-solid-900.ttf\") )",
                   "  }",
                   " ",
                   "  .onUnload <- function(libpath) {",
                   "    showtext::showtext_auto(FALSE)",
                   "  }")
  writeLines(fontconfig, con = file.path(paste0(path, "/R"), "load_font.R"))
  
  ## File to connect to github --------------
  gitinst   <- c( "## Use git ----",
                  "usethis::use_git()",
                  "## Now associate your local project with the online repo your created ----",
                  paste0("usethis::use_git_remote( \"origin\", url = \"https://github.com/",
                    text_list$githuborg, "/", text_list$pkg_name, ".git\", overwrite = TRUE )")
                 )
  
  writeLines(gitinst, con = file.path(paste0(path, "/dev"), "githublink.R"))
  
  
  ## File for app config --------------
  appconfig   <- c( " ## Prewrite the app config ----------",
                    " #' Access files in the current app",
                    " #'",
                    "#' NOTE: If you manually change your package name in the DESCRIPTION,",
                    "#' don't forget to change it here too, and in the config file.",
                    "#' For a safer name change mechanism, use the `golem::set_golem_name()` function.",
                    "#'",
                    "#' @param ... character vectors, specifying subdirectory and file(s)",
                    "#' within your package. The default, none, returns the root of the app.",
                    " #'",
                    " #' @noRd",
                    "app_sys <- function(...) {",
                    paste0("system.file(..., package = \"", text_list$pkg_name,"\")") ,
                    "}",
                    "#' Read App Config",
                    " #'",
                    "#' @param value Value to retrieve from the config file.",
                    "#' @param config GOLEM_CONFIG_ACTIVE value. If unset, R_CONFIG_ACTIVE.",
                    "#' If unset, \"default\".",
                    "#' @param use_parent Logical, scan the parent directory for config file.",
                    " #' @param file Location of the config file",
                    "#'",
                    "#' @noRd",
                    "get_golem_config <- function(",
                    "value,",
                    "config = Sys.getenv(",
                    "\"GOLEM_CONFIG_ACTIVE\",",
                    "Sys.getenv(",
                    "\"R_CONFIG_ACTIVE\",",
                    "\"default\"",
                    " )",
                    " ),",
                    "use_parent = TRUE,",
                    "# Modify this if your config file is somewhere else",
                    " file = app_sys(\"golem-config.yml\")",
                    ") {",
                    "  config::get(",
                    "   value = value,",
                    "   config = config,",
                    "    file = file,",
                    "   use_parent = use_parent",
                    "  )",
                    " }"
                   )
                    
  writeLines(appconfig, con = file.path(paste0(path, "/R"), "app_config.R"))
  
  ## Prewrite tool header ------------
  url <- paste0("https://www.iom.int/", text_list$pkg_name)
  header <- c(
    "header <- function() {",
    "\t shinydashboard::dashboardHeader( title =  '", paste0(  text_list$title),  "') ", 
    "}"
  )
    
    # "\t\t title = tagList(",
    # paste0("\t\t\tspan(class = 'logo-lg',a(\"", text_list$title, "\",style=\"color:white !important\",href='", url, "')),") ,
    #paste0("\t\t\ta(style = \"margin: -15px\", href='", url ,"', img(src = \"www/graveler_sprite.svg\", width=\"225%\"))"),
    #"\t\t),",
    #"\t\tcontrolbarIcon = \"gear\"",
   # "\t) )",
  #  "}"
  
  writeLines(header, con = file.path(paste0(path, "/R"), "header.R"))
  
  ## File to deploy to rstudio --------------
  appfile   <- c( "# Launch the ShinyApp (Do not remove this comment)",
                  "# To deploy, generate a docker image",
                  "pkgload::load_all(export_all = FALSE,helpers = FALSE,attach_testthat = FALSE)",
                  "options( \"golem.app.prod\" = TRUE)",
                  paste0( text_list$pkg_name,"::run_app() # add parameters here (if any)" )
  )
  
  writeLines(appfile, con = file.path(paste0(path, ""), "app.R"))

}
