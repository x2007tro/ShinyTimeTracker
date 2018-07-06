##
# Data upload tabPanel
##
tp_configuration <- tabPanel(
  "Configuration",
  fluidRow(
    column(
      width = 12,
      
      tags$div(
        class = "block_outter_frame",
        tags$h3(
          class = "block_title",
          "Global"
        ),
        tags$div(
          class = "block_inner_frame",
          
          ##
          # Real content starts here
          tags$div(class = "gloconf_div", textInput("gloconf_dfl", "Daily File Location", value = dly_file_loc, width = entry_wid_l)),
          tags$div(class = "gloconf_div", textInput("gloconf_darc", "Daily Archive Location", value = dly_arc_file_loc, width = entry_wid_l)),
          tags$div(class = "gloconf_div", textInput("gloconf_wfl", "Weekly File Location", value = wly_file_loc, width = entry_wid_l)),
          tags$div(class = "gloconf_div", textInput("gloconf_warc", "Weekly Archive Location", value = wly_arc_file_loc, width = entry_wid_l)),
          tags$div(class = "gloconf_div", textInput("gloconf_ref", "Reference File Path", value = cf_file_path, width = entry_wid_l)),
          
          tags$div(class = "gloconf_div", actionButton("gloconf_clrd", "Archive Daily Files", width = entry_wid_l)),
          tags$div(class = "gloconf_div", textOutput("gloconf_clrd_msg")),
          tags$div(class = "gloconf_div", actionButton("gloconf_clrw", "Archive Weekly Files", width = entry_wid_l)),
          tags$div(class = "gloconf_div", textOutput("gloconf_clrw_msg"))
        )
      )
      
    )
  )
)
