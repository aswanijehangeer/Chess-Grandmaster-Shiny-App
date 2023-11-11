
ui <- bootstrapPage(
  # include SCSS file ----
  tags$head(
    tags$style(sass(sass_file("www/style.scss")))
  ),
  
  # welcome popup modal ----
  modalDialog(
    div(
      h4("This app allows you to filter and display grandmasters' birthplaces on the map."),
      br(),
      h4("Hold your pointer on the icons for names and click to see a pop-up with additional information."),
    ),
    br(),
    h4("made by: ", a("aswanijehangeer", href = "https://www.linkedin.com/in/aswanijehangeer/")),
    title = "Chess: Grandmaster App♟️!",
    size = "l",
    easyClose = FALSE,
  ),
  
  # map output ----
  leafletOutput("map", width = "100%", height = "100%"),
  # inputs ----
  absolutePanel(top = 10, right = 10,
                pickerInput("federation", label = "Select a Federation:",
                            choices = list("All Federations", Federations = unique(gms_data$federation)),
                            options = list(`live-search` = TRUE)),
                pickerInput("gender", label = "Select a Gender:",
                            choices = list("All", Genders = unique(gms_data$gender)),
                            options = list(`live-search` = TRUE)),
                sliderInput("birthdate", "Select a Birthdate:",
                               min = as.Date(min(gms_data$date_of_birth)), 
                               max = as.Date(max(gms_data$date_of_birth)), 
                            value = as.Date(c("1865-02-27", "2009-02-05"))),
                tags$div(
                  textOutput("total"),
                  style = "font-weight: bold;"
                )
  ),
  # Disconnect message on disconnection on App ----
  disconnectMessage()
)