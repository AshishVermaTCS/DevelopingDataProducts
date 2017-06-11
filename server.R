#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(datasets)
library(leaflet)
library(dplyr)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  output$selectstation <- renderUI ({
    selectInput("stationid", "Select Station Id:" , as.list(unique(quakes[,5])))
  }) 
  
  output$distPlot <- renderLeaflet({
    if(input$station == TRUE)
    {  
      filtered <- reactive({
        quakes %>%
          filter (mag <= input$decimal,
                  depth >= input$range[[1]],
                  depth <= input$range[[2]],
                  stations == input$stationid)
      })
    }
    
    if(input$station == FALSE)
    {  
      filtered <- reactive({
        quakes %>%
          filter (mag <= input$decimal,
                  depth >= input$range[[1]],
                  depth <= input$range[[2]])  
      })
    }
    
    leaflet(data = filtered()) %>%
      addTiles() %>%
      ## Add Markers
      addMarkers(~long, ~lat, label = paste("earthquake of magnitude:", as.character(filtered()[,4]), "recorded at station: ", as.character(filtered()[,5])))
      
    
    output$results <- renderTable({  
      filtered()
    })
  })
})
