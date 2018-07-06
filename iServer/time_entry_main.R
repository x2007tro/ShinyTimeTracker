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
                                               choices = ref()$cf_client_proj$ClientProject,
                                               multiple = FALSE, selectize = TRUE, width = entry_wid_l)),
        # Job
        tags$div(class = "tr_div", selectInput(paste0("tr_job", i), "Job",
                                               choices = ref()$cf_job$Job,
                                               multiple = FALSE, selectize = TRUE, width = entry_wid_m)),
        
        # Time handling
        tags$div(class = "tr_div", textInput(paste0("tr_begt", i), "Begin", width = entry_wid_s)),   # button controlled
        tags$div(class = "tr_div", textInput(paste0("tr_endt", i), "End", width = entry_wid_s)),   # button controlled
        tags$div(class = "tr_div", textInput(paste0("tr_durt", i), "Duration", value = 0, width = entry_wid_s)),   # auto calc
        
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

##
# End time field
observe(
  lapply(1:input$dlyconf_ntr, function(i){
    observeEvent(input[[paste0("tr_endt", i)]], {
      ##
      # Entry duration
      updateTextInput(session = session, inputId = paste0("tr_durt", i), 
                      value = CalcDuration(input[[paste0("tr_begt", i)]], input[[paste0("tr_endt", i)]]))
      
    })
  })
)

##
# Save records
observe(
  lapply(1:input$dlyconf_ntr, function(i){
    observeEvent(input[[paste0("tr_save", i)]], {
      ##
      # file name
      fp <- paste0(input$gloconf_dfl, "time_records_", format(input$dlyconf_wd, "%Y%m%d"), ".csv")
      
      ##
      # Initialize data.frame
      res_df <- data.frame(
        WorkDate = as.character(0),
        ClientProject = as.character(0),
        Job = as.character(0),
        Begin = as.character(0),
        End = as.character(0),
        Duration = as.numeric(0),
        Narrative = as.character(0),
        stringsAsFactors = FALSE
      )
      
      ##
      # loop through all records and add data to data frame
      for(j in 1:input$dlyconf_ntr){
        res_df[j, "WorkDate"] <- format(input$dlyconf_wd, "%m/%d/%Y")
        res_df[j, "ClientProject"] <- input[[paste0("tr_cp", j)]]
        res_df[j, "Job"] <- input[[paste0("tr_job", j)]]
        res_df[j, "Begin"] <- input[[paste0("tr_begt", j)]]
        res_df[j, "End"] <- input[[paste0("tr_endt", j)]]
        res_df[j, "Duration"] <- input[[paste0("tr_durt", j)]]
        res_df[j, "Narrative"] <- input[[paste0("tr_nar", j)]]
      }
      
      ##
      # display to file preview
      output$dto_dlyf <- DT::renderDataTable({
        DT::datatable(
          res_df, 
          options = list(
            pageLength = 10,
            orderClasses = TRUE,
            searching = TRUE,
            paging = TRUE,
            scrollX = 400,
            scrollY = 400,
            scrollCollapse = TRUE),
          rownames = TRUE
        )
      })
      
      ##
      # save to CSV file
      if(file.exists(fp)) file.remove(fp)
      write.csv(res_df, file = fp, row.names = FALSE)
      
      ##
      # output message
      if(file.exists(fp)) msg <- "File saved!" else msg <- "File not saved!"
      updateTextInput(session = session, inputId = paste0("tr_msg", i), value = msg)
      
    })
  })
)