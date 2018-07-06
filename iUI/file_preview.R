##
# File preview tabPanel
##
tp_file_preview <- tabPanel(
  "File Preview",
  fluidRow(
    column(
      width = 12,
      
      ##
      # Cross reference table
      fluidRow(
        column(
          width = 6,
          tags$div(
            class = "block_outter_frame",
            tags$h3(
              class = "block_title",
              "Client & Project"
            ),
            tags$div(
              class = "block_inner_frame",
              
              ##
              # Client and project cross ref table
              DT::dataTableOutput("dto_cltprj")
            )
          )
        ),
        column(
          width = 6,
          tags$div(
            class = "block_outter_frame",
            tags$h3(
              class = "block_title",
              "Job"
            ),
            tags$div(
              class = "block_inner_frame",
              
              ##
              # Job cross ref table
              DT::dataTableOutput("dto_job")
            )
          )
        )
      ),
      
      ##
      # Time entry table
      fluidRow(
        column(
          width = 6,
          tags$div(
            class = "block_outter_frame",
            tags$h3(
              class = "block_title",
              "Daily Time Entry"
            ),
            tags$div(
              class = "block_inner_frame",
              
              ##
              # Daily time entry
              DT::dataTableOutput("dto_dlyf")
            )
          )
        ),
        column(
          width = 6,
          tags$div(
            class = "block_outter_frame",
            tags$h3(
              class = "block_title",
              "Weekly Time Entry"
            ),
            tags$div(
              class = "block_inner_frame",
              
              ##
              # Weekly time entry
              DT::dataTableOutput("dto_wlyf")
            )
          )
        )
      )
      
    )
  )
)