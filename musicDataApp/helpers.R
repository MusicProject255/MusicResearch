

plotScores <- function(genre = "All") {
  if (genre == "All") {
    top5000f %>% ggplot(aes(year, finalscore, xmin = 1900, xmax = 2016, ymin = 0, ymax = 40), na.rm = TRUE) +
      geom_point() + 
      stat_density2d(aes(fill = ..level..), geom = "polygon", alpha = 0.5) +
      labs(list(y = "Score", x = "Year", title = "Score over Time (All Genres)")) +
      theme(plot.title = element_text(hjust = 0.5))
  } else {
    top5000f %>% filter(genre1 == genre) %>%
      ggplot(aes(year, finalscore, xmin = 1900, xmax = 2016, ymin = 0, ymax = 40), na.rm = TRUE) +
      geom_point() + 
      stat_density2d(aes(fill = ..level..), geom = "polygon", alpha = 0.5) +
      labs(list(y = "Score", x = "Year", 
                title = paste("Score over Time (", genre, ")", sep = ""))) +
      theme(plot.title = element_text(hjust = 0.5))
  }
}