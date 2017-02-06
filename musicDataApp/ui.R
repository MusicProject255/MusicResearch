library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  titlePanel("Score vs. Year for different genres"),
  
  sidebarLayout(
    sidebarPanel(
      helpText("Create cool stuff and things."),
      
      selectInput("gen1",
                  label = "Choose a genre of interest",
                  choice = c("All", "Alternative & Punk", "Classical", "Electronica",
                             "Jazz", "Pop", "Rock", "Soundtrack", "Traditional",
                             "Urban", "Other"),
                  selected = "All")
      
    ),
    mainPanel(
      mainPanel(plotOutput("scatter"))
    )
  )
))