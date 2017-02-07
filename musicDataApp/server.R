library(shiny)
library(ggplot2)
library(tidyr)
library(dplyr)

top5000f <- read.csv("data/top5000final.csv")

source("helpers.R")

shinyServer(function(input, output) {
  
  output$scatter <- renderPlot({
    genr <- switch(input$gen1,
                    "All" = "All", "Alternative & Punk" = "Alternative & Punk",
                    "Classical" = "Classical", "Electronica" = "Electronica",
                    "Jazz" = "Jazz", "Pop" = "Pop", "Rock" = "Rock",
                    "Soundtrack" = "Soundtrack", "Traditional" = "Traditional",
                    "Urban" = "Urban", "Other" = "Other")
    
    moo <- switch(input$moo1,
                   "All"="All", "Aggressive"="Aggressive", "Brooding"="Brooding",
                   "Cool"="Cool", "Defiant"="Defiant", "Easygoing"="Easygoing",
                   "Empowering"="Empowering", "Energizing"="Energizing", "Excited"="Excited",
                   "Fiery"="Fiery", "Gritty"="Gritty", "Lively"="Lively", "Melancholy"="Melancholy",
                   "Peaceful"="Peaceful", "Romantic"="Romantic", "Rowdy"="Rowdy", "Sensual"="Sensual",
                   "Sentimental"="Sentimental", "Serious"="Serious", "Somber"="Somber",
                   "Sophisticated"="Sophisticated", "Stirring"="Stirring", "Tender"="Tender",
                   "Upbeat"="Upbeat", "Urgent"="Urgent", "Yearning"="Yearning", "Other"="Other")
    
    plotScores(genre = genr, mood = moo)
  })
  
  output$bar <- renderPlot({
    genr <- switch(input$gen1,
                   "All" = "All", "Alternative & Punk" = "Alternative & Punk",
                   "Classical" = "Classical", "Electronica" = "Electronica",
                   "Jazz" = "Jazz", "Pop" = "Pop", "Rock" = "Rock",
                   "Soundtrack" = "Soundtrack", "Traditional" = "Traditional",
                   "Urban" = "Urban", "Other" = "Other")
    
    countsOf(genre = genr)
  })
  
})