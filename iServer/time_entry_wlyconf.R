##
# Weekly Conf functions
##
fnl_recs <- reactive({
  ##
  # Collect all daily files
  afs <- list.files(path = input$gloconf_dfl, pattern = "*.csv")
  if(length(afs) == 0){
    recs_fnl <- data.frame(f1 = as.numeric())
  } else {
    afs_content <- lapply(1:length(afs), function(i){
      dataset <- read.csv(paste0(input$gloconf_dfl, afs[i]), header = TRUE, stringsAsFactors = FALSE)
    })
    all_recs <- do.call(rbind.data.frame, afs_content)
    
    ##
    # Delete empty fields
    recs0 <- all_recs[all_recs$Duration != 0,]
    
    ##
    # Merge client, project and job files
    recs1 <- merge(recs0, ref()$cf_client_proj, by = "ClientProject", all = FALSE)
    recs2 <- merge(recs1, ref()$cf_job, by = "Job", all = FALSE)
    
    ##
    # Calculate account number
    recs2$AccountNumber <- ""
    recs2[recs2$ClientProjectNumber != "00000000", "AccountNumber"] <- paste(recs2[recs2$ClientProjectNumber != "00000000", "ClientProjectNumber"], 
                                                                             an_mid, 
                                                                             recs2[recs2$ClientProjectNumber != "00000000", "JobNumber"], 
                                                                             sep = ".")
    
    ##
    # Filter pay type
    recs2[recs2$PayType == 0, "PayType"] <- ""
    recs2$PayTypeDesc <- ""
    
    ##
    # Select required fields
    recs_fnl <- recs2[,wkly_req_fields]
  }
  
  return(recs_fnl)
})


##
# make weekly file
##
observeEvent(input$wlyconf_make, {
  
  dataset <- fnl_recs()
  
  ##
  # display to file preview
  output$dto_wlyf <- DT::renderDataTable({
    DT::datatable(
      dataset, 
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
  # save
  fp <- paste0(input$gloconf_wfl, "time_records", ".csv")
  if(file.exists(fp)) file.remove(fp)
  write.csv(dataset, file = fp, append = FALSE, row.names = FALSE, col.names = TRUE)
  
  if(file.exists(fp)) msg <- "Weekly file saved!" else msg <- "Weekly file not saved!"
  output$wlyconf_msg <- renderText({ msg })
})

##
# Download weekly file
##
output$wlyconf_download <- downloadHandler(
  filename = function() {
    paste0("Import1msi_", format(Sys.Date(), "%Y%m%d"), ".csv")
  },
  content = function(file) {
    dataset <- fnl_recs()
    write.csv(dataset, file, row.names = FALSE)
  }
)
