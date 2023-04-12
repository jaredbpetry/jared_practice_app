library(leaflet) 
library(dplyr) 
library(tidyverse) 
library(janitor)

# get data 
url_map <- "https://docs.google.com/spreadsheets/d/1945sRz1BzspN4hCT5VOTuiNpwSSaWKxfoxZeozrn1_M/edit#gid=1669338265"
map_data <- read_sheet(url_map) |> janitor::clean_names()


leaflet(data = map_data) %>%
  addProviderTiles(providers$Stamen.Terrain,
                   options = providerTileOptions(noWrap = TRUE)
  ) %>%
  addMarkers(lng = ~longitude, lat = ~latitude, 
             popup = paste0("Site: ", map_data$site, "<br>",
                            "Country: ", map_data$country, "<br>",
                            "Partners: ", map_data$partners, "<br>",
                            "Site Manager(s):", map_data$p_ms))
