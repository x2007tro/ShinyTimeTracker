##
# Time entry tabPanel
##
tp_time_entry <- tabPanel(
  "Time Entry",
  fluidRow(
    column(
      width = 12,
      
      ##
      # Daily and weekly conf panel
      fluidRow(
        column(
          width = 6,
          tags$div(
            class = "block_outter_frame",
            tags$h3(
              class = "block_title",
              "Daily Conf."
            ),
            tags$div(
              class = "block_inner_frame",
              
              ##
              # Real content starts here
              tags$div(class = "dlyconf_div", dateInput("dlyconf_wd", "Work Date", value = format(Sys.Date(), "%Y-%m-%d"), 
                                                        format = "yyyy-mm-dd", width = entry_wid_m)),
              tags$div(class = "dlyconf_div", numericInput("dlyconf_ntr", "Time Entry Slots", value = ini_num_time_entry, width = entry_wid_m)),
              tags$div(class = "dlyconf_div", actionButton(class = "btn-primary", "dlyconf_af", "Auto-fill Untracked Time", width = entry_wid_l)),
              tags$div(class = "dlyconf_div", actionButton(class = "btn-primary", "dlyconf_reset", "Reset All Time Entries", width = entry_wid_l))
            )
          )
        ),
        column(
          width = 6,
          tags$div(
            class = "block_outter_frame",
            tags$h3(
              class = "block_title",
              "Weekly Conf."
            ),
            tags$div(
              class = "block_inner_frame",
              
              ##
              # Real content starts here
              tags$div(class = "wlyconf_div", actionButton(class = "btn-primary", "wlyconf_make", "Make Final Entry File", width = entry_wid_l)),
              tags$div(class = "wlyconf_div", textOutput("wlyconf_msg")),
              tags$div(class = "wlyconf_div", downloadButton(class = "btn-primary", "wlyconf_download", "Download Final Entry File", width = entry_wid_l))
            )
          )
        )
      ),
      
      ##
      # Time entry panel
      fluidRow(
        column(
          width = 12,
          tags$div(
            class = "block_outter_frame",
            tags$h3(
              class = "block_title",
              "Time Entry"
            ),
            tags$div(
              class = "block_inner_frame",
              
              ##
              # Dynamically create output
              uiOutput("time_entry_block")
            )
          )
        )
      )
      
    )
  )
)
