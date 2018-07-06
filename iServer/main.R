#
# Shiny server
#
mainServer <- function(input, output, session) {

  ##
  # Data initialization
  ##
  source("./iServer/data_init.R", local = TRUE)
  
  ##
  # Time entry
  ##
  source("./iServer/time_entry.R", local = TRUE)
}
