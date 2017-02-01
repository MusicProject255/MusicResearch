library(jsonlite)


json = fromJSON(paste("[",paste(readLines("https://raw.githubusercontent.com/MusicProject255/MusicResearch/master/Databases/meta.json"),
                                collapse=","),"]"))

gracenote <- data.frame(json)
write.csv(gracenote, "metadata5000.csv")
