#library(cli)
#file_not_exist <- Negate(file.exists)

#' @title copy_me 
#' @importFrom utils write.table
#' @noRd
#' @keywords internal
copy_me <- function(x){
  write.table(x, "clipboard", sep="\t", row.names=FALSE)
  }

#' @title create_dir_if_needed
#' @importFrom yesno yesno
#' @noRd
#' @keywords internal
create_dir_if_needed <- function(  path,
                                   auto_create){
  # TRUE if path doesn't exist
  dir_not_exist <- Negate(dir.exists)
  dir_not_there <- dir_not_exist(path)
  go_create <- TRUE
  # If not exists, maybe create it
  if (dir_not_there){
    # Auto create if needed
    if (auto_create){
      go_create <- TRUE
    } else {
      # Ask for creation
      go_create <- yesno::yesno(sprintf("The %s does not exists, create?", path))
    }
    # Will create if autocreate or if yes to interactive
    if (go_create) {
      dir.create(path, recursive = TRUE)
      cat_green_tick(
        sprintf(
          "Created folder %s to receive the file",
          path
        )
      )
    }
  }
  return(go_create)
}

#' @title create_dir_if_needed
#' @importFrom yesno yesno
#' @noRd
#' @keywords internal
check_file_exist <- function(file){
  res <- TRUE
  if (file.exists(file)){
    res <- yesno::yesno("This file already exists, override?")
  }
  return(res)
}

#' @title check_dir_exist
#' @importFrom yesno yesno
#' @noRd
#' @keywords internal
check_dir_exist <- function(dir){
  res <- TRUE
  if (!dir.exists(dir)){
    res <- yesno::yesno(sprintf("The %s does not exists, create?", dir))
  }
  return(res)
}

#' @title replace_word
#' @noRd
#' @keywords internal
replace_word <- function(file,pattern, replace){
  suppressWarnings( tx  <- readLines(file) )
  tx2  <- gsub(pattern = pattern, 
               replacement = replace, 
               x = tx)
  writeLines(tx2, con=file)
}

#' @title cat_green_tick
#' @importFrom cli cat_bullet
#' @noRd
#' @keywords internal
cat_green_tick <- function(...){
  cli::cat_bullet(
    ...,
    bullet = "tick",
    bullet_col = "green"
  )
}

#' @title cat_red_bullet
#' @importFrom cli cat_bullet
#' @noRd
#' @keywords internal
cat_red_bullet <- function(...){
  cli::cat_bullet(
    ...,
    bullet = "bullet",
    bullet_col = "red"
  )
}
