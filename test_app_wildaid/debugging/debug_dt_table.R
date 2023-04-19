shinyApp(
  ui = fluidPage(
    DTOutput("dt_table")
  ),
  server = function(input, output, session) {
    
    url <- "https://docs.google.com/spreadsheets/d/1cUz4WZ1CRHFicuVUt82kJ_mL9Ur861Dn1c0BYu3NmRY/edit#gid=0"
    MPS_tracker_data <- read_sheet(url)
    
    
    output$dt_table <- DT::renderDataTable(
      DT::datatable(MPS_tracker_data, 
                    escape=TRUE, # don't understand what this does could be important
                    caption = "Here is a filter-able compilation of all of our data", 
                    filter = 'top',
                    options = list(
                      pageLength = 10, autoWidth = TRUE,
                      columnDefs = list(list(targets = 6, width = '80px'), 
                                        list(targets = 7, width = '500px'), 
                                        list(targets = 4, width = '10px')), # play with column widths
                      scrollX = TRUE
                    )))
  }
)
