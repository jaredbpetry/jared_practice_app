# load required dependencies ----
library(dplyr) 
library(tidyverse) 
library(leaflet) 
library(plotly) 
library(ggplot2) 
library(googledrive) 
library(googlesheets4)
library(radiant.data)
library(DT)
library(janitor)
library(shinycssloaders)
library(hrbrthemes)
library(shinyWidgets)

# Read in our data: ---- 

# All MPS data frame: 
url_MPS_data <- "https://docs.google.com/spreadsheets/d/1cUz4WZ1CRHFicuVUt82kJ_mL9Ur861Dn1c0BYu3NmRY/edit#gid=0"
MPS_tracker_data <- read_sheet(url_MPS_data)

# Map data with locations and sites:
url_map <- "https://docs.google.com/spreadsheets/d/1945sRz1BzspN4hCT5VOTuiNpwSSaWKxfoxZeozrn1_M/edit#gid=1669338265"
map_data <- read_sheet(url_map) |> janitor::clean_names()

# Manipulate MPS_tracker_data: ----
datatable(MPS_tracker_data)

# make the year column numeric to make the filtering better
MPS_tracker_data <- MPS_tracker_data |> 
  mutate(year = as.factor(year),  # make sure changing these to factor doesn't harm any graphs
         category = as.factor(category), 
         country = as.factor(country)) |> 
  select(-indicator_type) # take out indicator type because obsolete 


###### WHERE IM AT:
###### i have added stuff in for the lollipop graph, but it doesn't do anything. might not have put it in the right place.  haven't added any reactivity but the app runs without it showing up ... loook at the two file app for how to make some dropdowns... might have to play with the code I made a little bit 


