##
# Initalize cross reference files
##
ref <- reactive({
  
  ##
  # Read client project reference
  cp <- readxl::read_excel(input$gloconf_ref, sheet = "Client_Project", skip = 2)
  cpdf <- as.data.frame(cp)
  
  ##
  # Read job reference
  job <- readxl::read_excel(input$gloconf_ref, sheet = "Job", skip = 2)
  jobdf <- as.data.frame(job)
  
  ##
  # Render datatable output
  output$dto_cltprj <- DT::renderDataTable({
    DT::datatable(
      cpdf, 
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
  # Render datatable output
  output$dto_job <- DT::renderDataTable({
    DT::datatable(
      jobdf, 
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
  
  res <- list(
    cf_client_proj = cpdf,
    cf_job = jobdf
  )
  
  return(res)
})