########################################################################################
# LOADING LIBRARIES
library(qdap)
library(data.table)
library(ngram)

########################################################################################
# PREDICTIVE MODEL

## Function to return a subset of an n-gram file where the string is found
search_ngram <- function(searchstring){
      words <- unlist(strsplit(searchstring," "))
      num <- length(words)
      
      for(i in min(4,num):1){
            substring <- paste0(tail(words,i), sep = " ", collapse = "")
            
            if(nrow(subset(fread(paste0("./data/ngrams/training/", i+1, "-gram.csv")), ngrams == substring)) > 0){
                  searchtable <- subset(fread(paste0("./data/ngrams/training/", i+1, "-gram.csv")), ngrams == substring)
                  stop <- 1
            } else {
                  next
            }
            
      }
      if(exists('searchtable')){
            searchtable = searchtable
      } else {
            searchtable = data.frame('ngrams' = NA, 'freq' = NA, 'last' = NA)
      }
      
      searchtable
}

# Building Prediction Function 
predict_next <- function(string){
      processed_string <- preprocess(string, 
                                     case = 'lower', 
                                     remove.punct = TRUE, 
                                     fix.spacing = TRUE)
      
      search <- search_ngram(processed_string)
      
      ## Top method: Top word + list of possible other words
      return(search[1:6, 3])
}


