##
# Daily configuration handling
##

##
# Auto-fill remaining untracked time
##
observeEvent(input$dlyconf_af, {
  
  ##
  # Add up all tracked hours
  fp <- paste0(input$gloconf_dfl, "time_records_", format(input$dlyconf_wd, "%Y%m%d"), ".csv")
  dataset <- read.csv(fp, header = TRUE, stringsAsFactors = FALSE)
  trk_hrs <- sum(dataset$Duration, na.rm = TRUE)
  utrk_hrs <- ft_hrs - trk_hrs
  
  ##
  # Update records
  max_i <- max(input$dlyconf_ntr, na.rm = TRUE)
  updateTextInput(session = session, inputId = paste0("tr_cp", max_i), value = fallback_cliprj)
  updateNumericInput(session = session, inputId = paste0("tr_durt", max_i), value = utrk_hrs)
  updateTextInput(session = session, inputId = paste0("tr_nar", max_i), value = "general admin")
})

##
# Reset all entries
##
observeEvent(input$dlyconf_reset, {
  lapply(1:input$dlyconf_ntr, function(i){
    updateTextInput(session = session, inputId = paste0("tr_cp", i), value = ref()$cf_client_proj$ClientProject[1])
    updateTextInput(session = session, inputId = paste0("tr_job", i), value = ref()$cf_job$Job[1])
    updateTextInput(session = session, inputId = paste0("tr_begt", i), value = "")
    updateTextInput(session = session, inputId = paste0("tr_endt", i), value = "")
    updateNumericInput(session = session, inputId = paste0("tr_durt", i), value = 0)
    updateTextInput(session = session, inputId = paste0("tr_nar", i), value = "")
    updateTextInput(session = session, inputId = paste0("tr_msg", i), value = "")
  })
})