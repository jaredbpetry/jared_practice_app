function(input, output, session) {
  
  # DT datatable:
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
  # an idea is to see whether we can make the 'notes' entries expandable ??
  # is the score set to numeric but the year is not? we may have to change that in order to get the filter slider correct 
  # let's try to get drop down menus for the categories and maybe some other things
  # PROBLEM: some search bars aren't side enough to allow you to see what you are typing

}