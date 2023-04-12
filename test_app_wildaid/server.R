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

  
  # Leaflet Map ----
  output$MPA_map <- renderLeaflet({
    leaflet(data = map_data) %>%
      addProviderTiles(providers$Stamen.Terrain,
                       options = providerTileOptions(noWrap = TRUE)
      ) %>%
      addMarkers(lng = ~longitude, lat = ~latitude, 
                 popup = paste0("Site: ", map_data$site, "<br>",
                                "Country: ", map_data$country, "<br>",
                                "Partners: ", map_data$partners, "<br>",
                                "Site Manager(s):", map_data$p_ms))
  })
  
  
  
  

}