### I'm using this script to experiment with our data and get used to using ggplot2
### You're welcome to add stuff, build on stuff, or tell me what I'm doing wrong...
### All the CSVs I use should be on the github; you might have to change some names


### I commented out lines that read big data sets which I'm not using, to save compile time.

# This is my folder for the class; you should obviously set your own directory
setwd("H:/Stats/DWData")
# chart includes songs and albums
# chart <- read.csv("chart.csv")
# top5000 is top 5000 songs
top5000 <- read.csv("top5000.csv")
# songChart is just songs
songChart <- read.csv("songChart.csv")
# wordRanks is big; it has all the words and how many times they appear in song names from songChart.
# wordRanks <- read.csv("songWordCounts.csv")
# Alternatively, goodOnes has only the words appearing 20 times or more (just 990 rows)
goodOnes <- read.csv("songWord20Counts.csv")

# View(chart)
View(top5000)
View(songChart)
# View(wordRanks)
View(goodOnes)

library(ggplot2)

#####################################################################
########## Everything below started as practice with ggplot2 for me,
########## but it might be a plot worth studying for us.
########## I think it's interesting.
#####################################################################
########## Plotting average score of songs with different words in
########## the name against the number of times the word appears.
#####################################################################
# base is just a scatterplot, aveScore versus counts
base <- ggplot(goodOnes, aes(counts, aveScore), na.rm=TRUE) + geom_point(na.rm=TRUE)
# geom_smooth() adds a regression line
base + geom_smooth(na.rm=TRUE)
# We see that with the crazy common words, the average score actually gets closer together
# I wanna compare all these to the average score of all songs.
# This should find the average score of all songs
averything <- mean(songChart$score, na.rm=TRUE)
# geom_hline to make a horizontal line at the average score
base + 
  geom_smooth(na.rm=TRUE) + 
  geom_hline(aes(yintercept = averything, colour="red"), show.legend=FALSE)
# woohoo!

# I'm gonna try something. This should use only words appearing 100 times or more
base %+% subset(goodOnes, counts >= 100) + 
  geom_smooth(na.rm=TRUE) +
  geom_hline(aes(yintercept=averything, colour="red"), show.legend=FALSE)

# But what if we take away the ridiculously common words, too? 
# this also excludes counts over 2000
base %+% subset(goodOnes, counts >= 100 & counts < 2000) + 
  geom_smooth(na.rm=TRUE) +
  geom_hline(aes(yintercept=averything, colour="red"), show.legend=FALSE)

# Since we're interested in the words that make a good song,
# Maybe we should only look at the words with aveScore greater than the global average
# I also added a linear fit in green (default fit is loess)
base %+% subset(goodOnes, counts >= 100 & counts < 2000 & aveScore > averything) +
  geom_smooth(method=loess, na.rm=TRUE, colour='blue') +
  geom_smooth(method=lm, na.rm=TRUE, colour='green') +
  geom_hline(aes(yintercept=averything, colour="red"), show.legend=FALSE)
# Cool.
##################################################################
##################################################################
##################################################################






