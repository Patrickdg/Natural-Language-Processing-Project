
url <- "https://d396qusza40orc.cloudfront.net/dsscapstone/dataset/Coursera-SwiftKey.zip"

if(!file.exists("./data/NLPdata.zip")){
      dir.create("./data")
      download.file(url = url, destfile = "./data/NLPdata.zip")
      unzip("./data/NLPdata.zip", exdir = './data')
}

# Subsetting the data
p = 0.01 # percent of each file's # lines to read into subsets

## Reading subset of US twitter file
dir.create("./dataSubsets")

twitcon <- file("./data/final/en_US/en_US.twitter.txt")
twit <- readLines(twitcon)
set.seed(1234)
twitsub <- twit[runif(length(twit),min = 0, max = 1) < p] # create subset of twitter file
write.table(twitsub,file = "./dataSubsets/UStwittersubset.txt", row.names = FALSE, col.names = FALSE)
close(twitcon)
rm(list = c("twit","twitsub"))

## Reading subset of US blogs file
blogcon <- file("./data/final/en_US/en_US.blogs.txt")
blog <- readLines(blogcon)
set.seed(1235)
blogsub <- blog[runif(length(blog),min = 0, max = 1) < p] # create subset of blogs file
write.table(blogsub,file = "./dataSubsets/USblogsubset.txt", row.names = FALSE, col.names = FALSE)
close(blogcon)
rm(list = c("blog","blogsub"))

## Reading subset of US news file
newscon <- file("./data/final/en_US/en_US.news.txt")
news <- readLines(newscon)
set.seed(1236)
newssub <- news[runif(length(news),min = 0, max = 1) < p] # create subset of news file
write.table(newssub,file = "./dataSubsets/USnewssubset.txt", row.names = FALSE, col.names = FALSE)
close(newscon)
rm(list = c("news","newssub"))