library(shiny)
library(readr)
library(ggplot2)
library(dplyr)
library(sf)
library(leaflet)
library(tidyverse)


# Load and preprocess data
data <- read_csv("PrixCarburants_annuel_2022.csv")
instantanee <- read_delim("prix-des-carburants-en-france-flux-instantane-v2.csv", delim = ";", col_types = cols()) %>%
  separate(geom, into = c("latitude", "longitude"), sep = ",") %>%
  mutate(
    latitude = as.numeric(latitude),
    longitude = as.numeric(longitude),
    Dept_code = as.integer(substr(`Code postal`, 1, 2))
  )
departements <- st_read('departements.geojson', quiet = TRUE) %>%
  mutate(code = as.integer(replace(code, code %in% c('2A', '2B'), '20')))
gas_station_density <- instantanee %>% count(Dept_code) %>% rename(count = n)
merged <- left_join(departements, gas_station_density, by = c("code" = "Dept_code"))

# Define UI
ui <- fluidPage(
  titlePanel("Gas Prices Over Time"),
  
  # First Row for Price Plot
  fluidRow(
    column(4,
           selectInput("gasType", "Select Gas Type:", choices = NULL)
    ),
    column(8,
           plotOutput("pricePlot")
    )
  ),
  
  # Second Row for Map and Fuel Type Selection
  fluidRow(
    column(4,
           selectInput("fuel_type", "Choose Fuel Type", choices = c("All", "Gazole", "SP95", "E10", "SP98", "E85")),
           selectInput("department", "Choose Department", choices = c("All", unique(instantanee$Département)))
    ),
    column(8,
           leafletOutput("map"),
           plotOutput("histogram")
    )
  ),
  
  # Fourth Row for Density Map
  fluidRow(
    column(8,
           leafletOutput("densityMap")
    )
  )
)


# Define server logic
server <- function(input, output, session) {
  
  # Update choices for selectInput based on available gas types
  observe({
    updateSelectInput(session, "gasType", choices = unique(data$Gas_Type))
  })
  
  # Reactive expression for processed data
  processedData <- reactive({
    req(input$gasType)
    data %>%
      filter(Gas_Type == input$gasType) %>%
      group_by(Date) %>%
      summarize(Mean_Price = mean(Price))
  })
  
  # Render the price plot
  output$pricePlot <- renderPlot({
    ggplot(processedData(), aes(x = Date, y = Mean_Price)) +
      geom_line() +
      labs(title = paste("Average Price of", input$gasType, "over Time"),
           x = "Date", y = "Average Price") +
      theme_minimal()
  })
  
  # Reactive expression for filtered data
  filteredData <- reactive({
    data <- instantanee
    if (input$fuel_type != "All") {
      fuel_price_column <- paste0(input$fuel_type, "_prix")
      data <- data %>% filter(!is.na(data[[fuel_price_column]]))
    }
    if (input$department != "All") {
      data <- data %>% filter(Département == input$department)
    }
    data
  })
  
  # Render the leaflet map for gas stations
  output$map <- renderLeaflet({
    leaflet(data = filteredData()) %>%
      addTiles() %>%
      addCircleMarkers(~longitude, ~latitude, radius = 4, color = "blue", stroke = FALSE, fillOpacity = 0.7)
  })
  
  # Render the histogram for fuel prices
  output$histogram <- renderPlot({
    filteredData() %>%
      select(Gazole_prix, SP95_prix, E10_prix, SP98_prix, E85_prix) %>%
      pivot_longer(everything(), names_to = "Fuel Type", values_to = "Price") %>%
      filter(Price != "") %>%
      mutate(Price = as.numeric(Price)) %>%
      ggplot(aes(x = Price, fill = `Fuel Type`)) +
      geom_histogram(bins = 30, position = "identity", alpha = 0.7) +
      labs(title = "Fuel Prices Distribution", x = "Price", y = "Count") +
      theme_minimal()
  })
  
  # Render the choropleth map for gas station density
  output$densityMap <- renderLeaflet({
    pal <- colorNumeric(palette = "YlGn", domain = merged$count)
    leaflet(data = merged) %>%
      addTiles() %>%
      setView(lng = 1.888334, lat = 46.603354, zoom = 6) %>%
      addPolygons(fillColor = ~pal(count), weight = 2, opacity = 1, color = "white", dashArray = "3", fillOpacity = 0.7)
  })
}

# Run the application
shinyApp(ui = ui, server = server)
