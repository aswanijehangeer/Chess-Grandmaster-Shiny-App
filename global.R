# install.packages("tidyverse")
# install.packages("shiny")
# install.packages("leaflet")
# install.packages("shinyWidgets")
# install.packages("shinyalert")
# install.packages("shinydisconnect")
# devtools::install_github("aswanijehangeer/ChessGMsdata")


library(tidyverse)
library(shiny)
library(leaflet)
library(shinyWidgets)
library(shinyalert)
library(shinydisconnect)
library(sass)
library(ChessGMsdata)


# Importing data set
gms_data <- chess_grandmasters

# creating pop-up text column
gms_data <- gms_data |> 
  mutate(popup_text = paste0("<center>",
                             "</br><b>", name, "</b>",
                             "</br><b>Date of birth</b>: ", date_of_birth, 
                             "</br><b>Place of birth</b>: ", birthplace,
                             "</br><b>Federation</b>: ", federation,
                             "</br><a href='", links, "' target='_blank'>More info...</a></center>")
  ) 


