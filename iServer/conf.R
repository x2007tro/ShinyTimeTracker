##
# Global configuration functions
##

##
# Clear daily workbooks
##
observeEvent(input$gloconf_clrd, {
  
  ##
  # Gather all workbooks in daily directory
  afs <- list.files(path = input$gloconf_dfl, pattern = "*.csv")
  if(length(afs) == 0){
    msg <- "No file found!"
  } else {
    lapply(1:length(afs), function(i){
      frm_f <- paste0(input$gloconf_dfl, afs[i])
      to_f <- paste0(input$gloconf_darc, afs[i])
      
      file.copy(frm_f, to_f, overwrite = TRUE)
      
      file.remove(frm_f)
    })
    
    ##
    # Output message
    afs <- list.files(path = input$gloconf_dfl, pattern = "*.csv")
    if(length(afs) == 0){
      msg <- "Daily files successfully removed!"
    } else {
      msg <- "Daily files not removed!"
    }
  }
  
  output$gloconf_clrd_msg <- renderText({
    msg
  })
})

##
# Clear weekly workbooks
##
observeEvent(input$gloconf_clrw, {
  
  ##
  # Gather all workbooks in daily directory
  afs <- list.files(path = input$gloconf_wfl, pattern = "*.csv")
  if(length(afs) == 0){
    msg <- "No file found!"
  } else {
    lapply(1:length(afs), function(i){
      frm_f <- paste0(input$gloconf_wfl, afs[i])
      to_f <- paste0(input$gloconf_warc, format(Sys.Date(), "%Y%m%d"), "-", afs[i])
      
      file.copy(frm_f, to_f, overwrite = TRUE)
      
      file.remove(frm_f)
    })
    
    ##
    # Output message
    afs <- list.files(path = input$gloconf_wfl, pattern = "*.csv")
    if(length(afs) == 0){
      msg <- "Weekly files successfully removed!"
    } else {
      msg <- "Weekly files not removed!"
    }
  }
  
  output$gloconf_clrw_msg <- renderText({
    msg
  })
})

##
# File download and upload
##
observe({
  
  req(input$file_u)
  file.copy(input$file_u$datapath, input$gloconf_ref, overwrite = TRUE)
  updateTextInput(session, "gloconf_ref", value = input$gloconf_ref) # this will trigger client/job list reloading
  
})

##
# This handles template download
output$file_d <- downloadHandler(
  
  # This function returns a string which tells the client
  # browser what name to use when saving the file.
  filename = function() {
    paste0("new_cross_reference", ".xlsx")
  },
  
  content = function(file) {
    ##
    # Extract file from directory
    ##
    file.copy(input$gloconf_ref, file)
  }
)


