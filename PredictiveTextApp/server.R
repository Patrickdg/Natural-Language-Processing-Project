source('./3 - Predictive Text App - Model.R')

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
      
  output$prediction <- renderText({
      if(input$sentence != ""){
            predict_next(input$sentence)[[1]][1]    
      }
  })
  
  output$possible <- renderText({
        if(input$sentence != ""){
              paste(gsub("NA", "", predict_next(input$sentence)[[1]][2:6]), 
                        sep = "  ", 
                        collapse = " | ")
        }
  })
})
