setwd("H:/Stats/DWData")
chart <- read.csv("chart.csv")
top5000 <- read.csv("top5000songs-2-6-0013.csv")
songChart <- read.csv("songChart.csv")
wordRanks <- read.csv("songWordCounts.csv")

View(chart)
View(top5000)
View(songChart)
View(wordRanks)


chart$year[which(as.character(chart$year) == "unknown")] <- NA
years <- as.numeric(as.character(chart$year))
chart$year[!is.na(chart$year)] <- years[!is.na(chart$year)]
chart$year <- as.numeric(as.character(chart$year))

chart$type <- sapply(chart$type, as.character)

songChart$name <- sapply(songChart$name, as.character)
songChart$artist <- sapply(songChart$artist, as.character)



# Get decade from year
findDecade <- function(year) {
  after1900 <- year-1900
  if (is.na(year)) {
    decade <- NA # Account for NAs
  } else if (after1900 >= 100) {
    decade <- 2000 # Assign 2000 to anything 21st century
  } else {
    tens <- after1900 %/% 10
    decade <- 1900 + 10*tens
  }
  return(decade)
}

decades <- unlist(lapply(chart$year, findDecade))
chart$decade <- decades

# just take songs
songInd <- grep("song", chart$type)
songChart <- chart[songInd, ]

# remove pointless columns
songChart <- songChart[-c(4, 14, 15, 16, 17)]
songChart <- songChart[-c(1)]

# Add a good unique identifier?
ArtSongYear <- function(index) {
  paste(songChart$artist[index], songChart$name[index], songChart$year[index], sep="_")
}

eyeDs <- ArtSongYear(1:nrow(songChart))
songChart$art_song_year <- eyeDs


# update csv
write.csv(chart, "chart.csv")
write.csv(songChart, "songChart.csv")

years <- unique(songChart$year)

rankings <- function(year) {
  rows <- songChart[which(songChart$year==year), c(1,2,3,4,5)]
}

getYearScore <- function(year) {
  scores <- chart$score[which(chart$year==year)]
  yearScore <- mean(scores)
  return(yearScore)
}

wordInd <- function(word, artists = FALSE) {
  return(grep(word, songChart$name, ignore.case = TRUE))
}

getWordCount <- function(word, artists = FALSE) {
  if (artists) {
    wordInd <- grep(word, songChart$artist, ignore.case=TRUE)
  } else {
    wordInd <- grep(word, songChart$name, ignore.case=TRUE)
  }
  return(length(wordInd))
}

getWordScore <- function(word, artists = FALSE) {
  if (artists) {
    wordInd <- grep(word, songChart$artist, ignore.case=TRUE)
  } else {
    wordInd <- grep(word, songChart$name, ignore.case=TRUE)
  }
  wordScore <- mean(songChart$score[wordInd])
  return(wordScore)
}

aveScores <- sapply(wordRanks$word, getWordScore)
wordRanks$aveScore <- aveScores

# Only words appearing 20 or more times
goodOnes <- wordRanks[1:990, ]

# save wordRanks as the counts csv
write.csv(wordRanks, "songWordCounts.csv")
write.csv(goodOnes, "SongWord20Counts.csv")


##### Trying to get word counts....
someWords <- unique(tolower(unlist(sapply(songChart$name[1:20], strsplit, " "))))

wordInds <- lapply(someWords, wordInd)

top5000$raw_usa[which(top5000$raw_usa==0)] <- NA
top5000$raw_eng[which(top5000$raw_eng==0)] <- NA
top5000$raw_eur[which(top5000$raw_eur==0)] <- NA
top5000$raw_row[which(top5000$raw_row==0)] <- NA

write.csv(top5000, "top5000.csv")

# Take numeric vector, spit out z-scores
zscores <- function(numData) {
  m <- mean(numData, na.rm = TRUE)
  sd <- sd(numData, na.rm = TRUE)
  z <- (numData - m)/sd
  return(z)
}

top5000$z_usa <- zscores(top5000$raw_usa)
top5000$z_eng <- zscores(top5000$raw_eng)
top5000$z_eur <- zscores(top5000$raw_eur)
top5000$z_row <- zscores(top5000$raw_row)












