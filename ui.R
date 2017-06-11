#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(datasets)
library(leaflet)
library(dplyr)

# Define UI for application that draws the output
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Analysis of Earthquakes Data"),
  
  
  # Sidebar with a slider input for number of depth and magnitude 
  sidebarLayout(
    sidebarPanel(
       sliderInput("range",
                   "Depth of Earthquake:",
                   min = 40,
                   max = 680,
                   value = c(100,300)),
       sliderInput("decimal",
                   "Magnitude of Earthquake:",
                   min = 4,
                   max = 7,
                   value = 4.5,
                   step = 0.2),
       checkboxInput("station","Include Measuring Station:", FALSE),
       conditionalPanel(
         condition = "input.station == true",
         uiOutput("selectstation")
       )
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
       leafletOutput("distPlot"),
       tableOutput("results") 
    )
  )
))
