header <- function() {
	 dashboardHeader(
	 	 title = tagList(
	 	 	 span(class = 'logo-lg', 
	 	 	      a("Dashboard", style="color:white !important", href='https://rstudio.unhcr.org')
	 	 	      ) #,
	 	 	  # a(style = "margin: -15px", 
	 	 	  #   href='https://www.unhcr.org', 
	 	 	  #   img(src = "www/graveler_sprite.svg", width="225%")
	 	 	  #   )
	 	 ),
	 	 controlbarIcon = "gear",
	 	 disable = FALSE
	 )
}
