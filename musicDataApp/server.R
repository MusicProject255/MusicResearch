library(shiny)
library(ggplot2)
library(tidyr)
library(dplyr)

top5000f <- read.csv("H:/Stats/DWData/top5000final.csv")

source("helpers.R")

shinyServer(function(input, output) {
  
  output$scatter <- renderPlot({
    gen1 <- switch(input$gen1,
                    "All" = "All", "Alternative & Punk" = "Alternative & Punk",
                    "Classical" = "Classical", "Electronica" = "Electronica",
                    "Jazz" = "Jazz", "Pop" = "Pop", "Rock" = "Rock",
                    "Soundtrack" = "Soundtrack", "Traditional" = "Traditional",
                    "Urban" = "Urban", "Other" = "Other")
    
    plotScores(gen1)
  })
  
})