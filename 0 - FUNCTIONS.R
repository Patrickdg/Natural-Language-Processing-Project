## Read txt files (for ease of use and cleanliness)
read_file <- function(filepath){
      connection <- file(filepath)
      return(readLines(connection))
      close(connection)}

## Read & write sample subsets and split data into train + test sets
read_and_write_subset <- function(filename, filepath, subset_size, seed = 1234){
      
      # Read in the file
      file <- read_file(filepath); file <- gsub("â|€","", file)
      
      set.seed(seed) # set seed (for reproducibility)
      file_sample <- file[runif(length(file), min = 0, max = 1) < subset_size]; rm(ls = 'file') # Sample the data
      
      train_index <- sample(1:length(file_sample), size = round((1-testing_portion) * length(file_sample))) # Create index of training rows
      training <- file_sample[train_index] # Create training set
      testing <- file_sample[-train_index] # Create testing set
      
      # Write training & test set to table
      write.table(training, 
                  file = paste0("./data/Subsets/training/",filename,'-training.txt'), 
                  row.names = FALSE,
                  col.names = FALSE)
      write.table(testing, 
                  file = paste0("./data/Subsets/testing/",filename,'-testing.txt'), 
                  row.names = FALSE,
                  col.names = FALSE)
}

## Build ngram files 
build_ngram_table <- function(data, type, n, freqthreshold){
      
      
      # Use ngram function to convert corpus into n-grams based on 'n' provided in function
      ngrams <- ngram(data, n = n)
      
      # Create data table of ngrams and frequencies
      table <- data.table(get.phrasetable(ngrams))[,1:2]; rm(ls = 'ngrams')
      # Remove words below frequency threshold
      table <- table[table$freq > freqthreshold] 
      # Create column 'last' in data table to reflect last word of n-grams
      table[,last:= stri_extract_last_words(table$ngrams)]
      # Remove last word from the $ngrams column 
      table$ngrams <- substr(table$ngrams, 1, (stri_length(table$ngrams) - (stri_length(table$last)+1)))
      
      # Write table to csv
      write.table(table,
                  file = paste0('./data/ngrams/',type,'/',n,'-gram.csv'),
                  row.names = FALSE,
                  sep = ",")
      rm(ls = 'table')
}