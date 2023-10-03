## Use git ----
usethis::use_git()
## Now associate your local project with the online repo your created ----
usethis::use_git_remote( "origin", url = "https://github.com/unhcr-americas/response.git", overwrite = TRUE )
