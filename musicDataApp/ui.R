library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  titlePanel("Score vs. Year for different genres"),
  
  fluidRow(
    column(6,
      helpText("See how genres have changed throughout the years."),
      
      selectInput("gen1",
                  label = "First, pick a genre.",
                  choice = c("All", "Alternative & Punk", "Classical", "Electronica",
                             "Jazz", "Pop", "Rock", "Soundtrack", "Traditional",
                             "Urban", "Other"),
                  selected = "All"),
      
      selectInput("moo1",
                  label = "Then, pick a mood (check the bar chart first).",
                  choice = c("All", "Aggressive", "Brooding", "Cool", "Defiant", "Easygoing",
                             "Empowering", "Energizing", "Excited", "Fiery", "Gritty", "Lively",
                             "Melancholy", "Peaceful", "Romantic", "Rowdy", "Sensual", "Sentimental",
                             "Serious", "Somber", "Sophisticated", "Stirring", "Tender", "Upbeat",
                             "Urgent", "Yearning", "Other"),
                  selected = "All"),
      plotOutput("bar")
      
    ),
    column(6,
      plotOutput("scatter")
    )
  )
))