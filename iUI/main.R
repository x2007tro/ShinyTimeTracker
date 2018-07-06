##
# Source all ui files
##
ui_files <- c("time_entry", "file_preview", "conf")
lapply(ui_files, function(f){
  source(paste0("./iUI/", f, ".R"), local = FALSE)
})

##
# Shiny ui
##
mainUI <- fluidPage(theme = shinythemes::shinytheme("simplex"),
  
  # css style
  tags$head(
    includeCSS("stt_style.css")
  ),
  
  navbarPage(
    "1MSI Time Tracker",
    ##
    # Time entry tab
    ##
    tabPanel(
      "Time entry",
      tp_time_entry
    ),
    ##
    # File Preview
    ##
    tabPanel(
      "File Preview",
      tp_file_preview
    ),
    ##
    # Configuration
    ##
    tabPanel(
      "Configuration",
      tp_configuration
    )
  )
  # End of navbarpage
)
