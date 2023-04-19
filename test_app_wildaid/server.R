function(input, output, session) {
  
  # DT datatable:
  output$dt_table <- DT::renderDataTable(
    DT::datatable(data = select(MPS_tracker_data, -visualization_include), # take out a column
                  rownames = FALSE,
                  escape=TRUE, # don't understand what this does could be important
                  caption = "Here is a filter-able compilation of all of our data", 
                  filter = 'top',
                  options = list(
                    pageLength = 10, autoWidth = TRUE,
                    columnDefs = list(list(targets = 5, width = '80px'), 
                                      list(targets = 6, width = '400px'), 
                                      list(targets = 3, width = '10px')), # play with column widths
                    scrollX = TRUE
                  )))
#browser()
  
  # Leaflet Map ----
  
  # Define your scoring scale and associated colors
  score_scale <- c(1, 2, 3, 4, 5)  # Example scoring scale
  color_palette <- colorRampPalette(c("#00A6A6", "#7FB069", "#094074", "#F4D067", "#E17000"))(n = length(score_scale) - 1)
  
  # Create a function to map scores to colors
  score_to_color <- function(score) {
    color_idx <- findInterval(score, score_scale, all.inside = TRUE)
    return(color_palette[color_idx])
  }
  
  # map output
  output$MPA_map <- renderLeaflet({
    leaflet(data = map_data) %>%
      addProviderTiles(providers$Stamen.Terrain,
                       options = providerTileOptions(noWrap = TRUE)
      ) %>%
      addCircleMarkers(lng = ~longitude, 
                       lat = ~latitude,
                       radius = 10,
                       color = ~score_to_color(score_scale),
                       fillOpacity = 0.8,
                 popup = paste0("Site: ", map_data$site, "<br>",
                                "Country: ", map_data$country, "<br>",
                                "Partners: ", map_data$partners, "<br>",
                                "Site Manager(s):", map_data$p_ms))
  })
  
  
  
  

}