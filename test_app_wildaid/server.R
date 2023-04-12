function(input, output, session) {
  
  # DT datatable: ----
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
  
  # Lollipop Graph: ----
  
  # set up lollipop graph data: 
  lollidat <- reactive({
    
    validate(
      need(length(input$year_input) > 0, "Select at least one year"),
      need(length(input$site_input) > 0, "Select at least one MPA site")
    )
    
    MPS_tracker_data |> 
    filter(year %in% c(input$year_input), 
           country == "Ecuador")
  sub1 <- lollidat |> 
    filter(site == "Reserva Ecológica Manglares Churute") |> 
    group_by(category) |> 
    summarise(score = mean(score, na.rm = TRUE), 
              site = site)
  sub2 <- lollidat |> 
    filter(site == "Galapagos Marine Reserve") |> 
    group_by(category) |> 
    summarise(score = mean(score, na.rm = TRUE), 
              site = site)
  sub3 <- lollidat |> 
    filter(site == "Parque Nacional Machalilla") |> 
    group_by(category) |> 
    summarise(score = mean(score, na.rm = TRUE), 
              site = site)
  sub4 <- lollidat |> 
    filter(site == "Refugio de Vida Silvestre Manglares El Morro") |> 
    group_by(category) |> 
    summarise(score = mean(score, na.rm = TRUE), 
              site = site)
  lolli_cat_score <- bind_rows(sub1, sub2, sub3, sub4)

  })
  
  # make our grouped lollipop plot
  ggloli <- ggplot(lolli_cat_score) +
    geom_segment( aes(x=category, xend=category, y=0, yend=score), color="grey") +
    geom_point( aes(x=category, y=score, color=site), size=3 ) +
    coord_flip()+
    theme_ipsum() +
    theme(
      legend.position = "none",
      panel.border = element_blank(),
      panel.spacing = unit(0.1, "lines"),
      strip.text.x = element_text(size = 8), 
      axis.text.y = element_text(size = 7), 
      plot.title = element_text(size = 12)
    ) +
    labs(title = "Comparing Four Sites in Ecuador in 2022", size = 1) +
    xlab("Scoring Category") +
    ylab("Score") +
    facet_wrap(~site, ncol=1, scale="free_y")

}