########################################################################################
# SOURCE
source('./3 - Predictive Text App - Model.R')

########################################################################################

if(!file.exists('./data/Results')){
      dir.create('./data/Results')
}

# ACCURACY TESTING

accuracy_testing <- function(size){
      
      for(ngram_file in list.files('./data/ngrams/testing')){
            
            gram_results <- data.frame()
            
            set.seed(1111)
            data <- fread(paste0('./data/ngrams/testing/',ngram_file))
            data <- data[runif(nrow(data), min = 0, max = 1) < size]
            
            for(i in 1:nrow(data)){
                  ngram <- toString(data$ngrams[i])
                  target <- data$last[i]
                  
                  predictions <- predict_next(ngram)
                  top <- toString(predictions[1])
                  possible <- predictions[2:3]
                  possible <- c(possible)[[1]]
                  
                  # time <- system.time(predict_next(ngram))
                  
                  accuracy <- if(top == target){
                        1 } else if(is.element(target, possible)){
                              match(target, possible) + 1
                        } else {
                              NA
                        }
                  
                  gram_results <- rbind(gram_results, cbind(ngram,
                                                        target,
                                                        top,
                                                        # possible[1],
                                                        # possible[2],
                                                        # possible[3],
                                                        # possible[4],
                                                        # possible[5],
                                                        # time[1],
                                                        # time[2],
                                                        accuracy))
                  # names(gram_results) <- c('ngram',
                  #                          'prediction',
                  #                          'possible_1',
                  #                          'possible_2',
                  #                          'possible_3',
                  #                          'possible_4',
                  #                          'possible_5',
                  #                          'user_time',
                  #                          'sys_time',
                  #                          'accuracy')
                  # 
                  
            }
            
            write.table(gram_results, paste0('./data/Results/',ngram_file,'-acc.csv'), sep = ",", row.names = FALSE)
      }
}

# TIME TESTING

time_testing <- function(size){
      
      for(ngram_file in list.files('./data/ngrams/testing')){
            
            set.seed(1112)
            data <- fread(paste0('./data/ngrams/testing/',ngram_file))
            data <- data[runif(nrow(data),min = 0, max = 1) < size]
            
            times <- data.frame()
            for(i in 1:nrow(data)){
                  time <- system.time(predict_next(data$ngrams[i]))
                  
                  times <- rbind(times, cbind(data$ngrams[i],
                                            time[1],
                                            time[2]))
            }
            
            write.table(times, paste0('./data/Results/',ngram_file,'-time.csv'), sep = ",", row.names = FALSE)
      }
}


acc_results <- accuracy_testing(0.05)
# time_results <- time_testing(0.1)
