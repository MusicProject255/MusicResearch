top5000f <- read.csv("data/top5000final.csv")

plotScores <- function(genre = "All", mood = "All") {
  data <- top5000f
  if (genre != "All") data <- filter(data, genre1 == genre)
  if (mood != "All") data <- filter(data, mood1 == mood)
  
  data %>% ggplot(aes(year, finalscore, xmin = 1900, xmax = 2016, ymin = 0, ymax = 40), na.rm = TRUE) +
    geom_point() + 
    stat_density2d(aes(fill = ..level..), geom = "polygon", alpha = 0.3) +
    labs(list(y = "Score", x = "Year", title = paste(genre, "Songs with", mood, "Moods"))) +
    theme(plot.title = element_text(hjust = 0.5))
  
}

countsOf <- function(genre = "All") {
  data <- top5000f
  if (genre != "All") data <- filter(data, genre1 == genre)
  
  ggplot(data) +
    geom_bar(aes(x = as.character(decade), fill = mood1, colour = "black")) +
    scale_fill_manual(values = colorRampPalette(brewer.pal(12, "Paired"))(30)) +
    guides(colour = FALSE, fill = guide_legend(title = NULL)) +
    labs(list(y = "Count", x = "Decade", title = paste("Moods of", genre, "Songs Through the Years"))) +
    theme(plot.title = element_text(hjust = 0.5), 
          axis.text.x = element_text(angle = 90, hjust = 1))
}