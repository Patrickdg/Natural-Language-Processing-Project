########################################################################################
# KEY PARAMETERS: 

sample_size <- 0.03158 # sample size to extract from data, w/ 5% reserved for testing (therefore, 2.5% remaining in final dictionary)

testing_portion <- 0.05 # portion of total sample_size to use as testing set

frequency_threshold <- c(4,4,4,4) # Frequency threshold for pruning of bi-, tri-, quad-, and quint-gram files

# Load source functions
source('./0 - FUNCTIONS.R')

# Load required libraries
library(qdap)
library(data.table)
library(ngram)
library(stringi)

########################################################################################
# LOADING THE DATA

url <- "https://d396qusza40orc.cloudfront.net/dsscapstone/dataset/Coursera-SwiftKey.zip"

## Initialize data folder
if(!file.exists("./data")){
      dir.create("./data")} 

## Download the data and delete (unlink) all non-english files
if(!file.exists("./data/Original/NLPdata.zip")){
      dir.create("./data/Original")
      download.file(url = url, destfile = "./data/Original/NLPdata.zip")
      unzip("./data/Original/NLPdata.zip", exdir = './data/Original')}

unlink(c('./data/Original/final/de_DE/de_DE.blogs.txt',
         './data/Original/final/de_DE/de_DE.news.txt',
         './data/Original/final/de_DE/de_DE.twitter.txt',
         './data/Original/final/fi_FI/fi_FI.blogs.txt',
         './data/Original/final/fi_FI/fi_FI.news.txt',
         './data/Original/final/fi_FI/fi_FI.twitter.txt',
         './data/Original/final/ru_RU/ru_RU.blogs.txt',
         './data/Original/final/ru_RU/ru_RU.news.txt',
         './data/Original/final/ru_RU/ru_RU.twitter.txt',
         './data/Original/final/de_DE',
         './data/Original/final/fi_FI',
         './data/Original/final/ru_RU'), recursive = TRUE)

## Create folder to store sampled subsets (training & test) data.
if(!file.exists('./data/Subsets')){
      dir.create("./data/Subsets")}

########################################################################################
# SUBSETTING THE DATA (TRAINING & TESTING SET)

if(!(file.exists('./data/Subsets/training') & file.exists('./data/Subsets/testing'))){
      dir.create('./data/Subsets/training')
      dir.create('./data/Subsets/testing')
}

## Build subsets for US blogs, news, and twitter files

read_and_write_subset('blogs', './data/Original/final/en_US/en_US.blogs.txt', sample_size)
read_and_write_subset('news', './data/Original/final/en_US/en_US.news.txt', sample_size)
read_and_write_subset('twitter', './data/Original/final/en_US/en_US.twitter.txt', sample_size)

########################################################################################
# BUILDING N-GRAM FILES (FOR TRAINING & TEST SETS)

## Initialize ngrams folder 
if(!file.exists('./data/ngrams')){
      dir.create('./data/ngrams')
      dir.create('./data/ngrams/training')
      dir.create('./data/ngrams/testing')
}


## Run for loop to build 1-5 gram files for training & test sets

for(i in c('training','testing')){
      
      set <- i # identify training or testing set
      path <- paste0('./data/Subsets/',set)
      # Read in blogs, news, and twitter file based on 'set' above, concatenate, lower, and remove punctuation.
      data <- preprocess(
            paste(
                  rbind(
                        read_file(paste0(path,'/blogs-',set,'.txt')),
                        read_file(paste0(path,'/news-',set,'.txt')),
                        read_file(paste0(path,'/twitter-',set,'.txt'))
                  ),
                  collapse = " "
            ),
            case = 'lower',
            remove.punct = TRUE,
            remove.numbers = FALSE
      )
      
      # Set for loop to build 1-5 grams from training or testing data set above
      for(n in 2:5){
            build_ngram_table(data = data, type = set, n = n, freqthreshold = frequency_threshold[n-1])
      }
}


