
server <- function(input, output, session) {
  
  filtered_data <- reactive({
    
    data <- gms_data
    
    # filter by federations
    if (input$federation != "All Federations") {
      data <- filter(data, federation == input$federation)
    }
    # filter by gender
    if (input$gender != "All") {
      data <- filter(data, gender == input$gender)
    }
    
    # filter by birth date range
    data <- filter(data, date_of_birth >= input$birthdate[1] & date_of_birth <= input$birthdate[2])
    
    data
  })
  # shiny alert ----
  observe({
    data <- filtered_data()

    if (nrow(data) == 0) {
      shinyalert(
        title = "Data Not Avaiable",
        text = paste(input$federation, "don't have any", input$gender, "Grandmaster."),
        size = "m",
        closeOnEsc = TRUE,
        closeOnClickOutside = FALSE,
        html = FALSE,
        type = "error",
        showConfirmButton = TRUE,
        showCancelButton = FALSE,
        confirmButtonText = "Back",
        confirmButtonCol = "#FF0400",
        timer = 0,
        imageUrl = "",
        animation = TRUE
      )
    }
  })
  
  
  # map ----
  output$map <- renderLeaflet({
    data <- filtered_data()
    
    profileIcons <- makeIcon(
      iconUrl = case_when(
        data$gender == "Male" ~ "www/Male.png",
        data$gender == "Female" ~ "www/Female.png"),
      iconWidth = 20,
      iconHeight = 20)
    
    data |> 
      leaflet() %>%
      addTiles() %>%  
      addMarkers(
        lng = ~longitude, 
        lat = ~latitude, 
        label = ~name,
        icon = profileIcons,
        popup = ~popup_text,
        labelOptions = labelOptions(textsize = "15px")
      )
  })
  # Total Grand masters text ----
  output$total <- renderText({
    data <- filtered_data()
    grandmaster_count <- if (nrow(data) > 0) {
      nrow(data)
    } else {
      0
    }
    paste("Total Grandmasters: ", grandmaster_count, sep = "")
  })
  
}