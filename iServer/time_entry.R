##
# handle time entry functions 
##

##
# Dynamically create time entries
output$time_entry_block <- renderUI({
  
  lapply(1:input$dlyconf_ntr, function(i){
    
    fluidRow(
      column(
        width = 12,
        
        ##
        # Meat here
        
        # id
        tags$div(class = "tr_div", textInput(paste0("tr_id", i), "ID", value = i, width = entry_wid_s)), 
        
        # Client and project
        tags$div(class = "tr_div", selectInput(paste0("tr_cp", i), "Client & Project",
                                               choices = ref()$cf_client_proj$Description,
                                               multiple = FALSE, selectize = TRUE, width = entry_wid_l)),
        # Job
        tags$div(class = "tr_div", selectInput(paste0("tr_job", i), "Job",
                                               choices = ref()$cf_job$Description,
                                               multiple = FALSE, selectize = TRUE, width = entry_wid_m)),
        
        # Time handling
        tags$div(class = "tr_div", textInput(paste0("tr_begt", i), "Begin", width = entry_wid_s)),   # button controlled
        tags$div(class = "tr_div", textInput(paste0("tr_endt", i), "End", width = entry_wid_s)),   # button controlled
        tags$div(class = "tr_div", textInput(paste0("tr_durt", i), "Duration", width = entry_wid_s)),   # auto calc
        
        # Narrivate
        tags$div(class = "tr_div", textInput(paste0("tr_nar", i), "Narrative", value = "comments", width = entry_wid_l)),
        
        # Action buttons
        tags$div(class = "tr_div", actionButton(paste0("tr_begb", i), "Begin", width = entry_wid_s)),
        tags$div(class = "tr_div", actionButton(paste0("tr_endb", i), "End", width = entry_wid_s)),
        tags$div(class = "tr_div", actionButton(paste0("tr_save", i), "Save", width = entry_wid_s)),
        
        # Message for saving action
        tags$div(class = "tr_div", textInput(paste0("tr_msg", i), "Message", width = entry_wid_l))
      )
    )
    
  })
  
})

##
# Begin action button
observe(
  lapply(1:input$dlyconf_ntr, function(i){
    observeEvent(input[[paste0("tr_begb", i)]], {
      ##
      # Entry current time into 'begin' box
      updateTextInput(session = session, inputId = paste0("tr_begt", i), 
                      value = format(Sys.time(), "%H:%M"))
    })
  }) 
)

##
# End action button
observe(
  lapply(1:input$dlyconf_ntr, function(i){
    observeEvent(input[[paste0("tr_endb", i)]], {
      ##
      # Entry current time into 'begin' box
      updateTextInput(session = session, inputId = paste0("tr_endt", i), 
                      value = format(Sys.time(), "%H:%M"))
      
      ##
      # Entry duration
      updateTextInput(session = session, inputId = paste0("tr_durt", i), 
                      value = CalcDuration(input[[paste0("tr_begt", i)]], input[[paste0("tr_endt", i)]]))
      
    })
  })
)