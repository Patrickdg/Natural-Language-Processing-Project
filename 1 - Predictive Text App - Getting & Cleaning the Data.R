########################################################################################
# KEY PARAMETERS: 


sample_size <- 0.025 # sample size to extract from data (to include in final model dictionary)

frequency_threshold <- c(12,9,6,4) # Frequency threshold for pruning of bi-, tri-, quad-, and quint-gram files



########################################################################################
# LOADING THE DATA

url <- "https://d396qusza40orc.cloudfront.net/dsscapstone/dataset/Coursera-SwiftKey.zip"

if(!file.exists("./data/NLPdata.zip")){
      dir.create("./data")
      download.file(url = url, destfile = "./data/NLPdata.zip")
      unzip("./data/NLPdata.zip", exdir = './data')
}

# Create folder to store sampled subsets of data.
if(!file.exists('./dataSubsets')){
      dir.create("./dataSubsets")
}
