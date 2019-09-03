
library(shiny)
library(shinythemes)

# Define UI for application that draws a histogram
shinyUI(fluidPage(theme = shinytheme("darkly"),
  # Application title
      titlePanel("Next Word Predictive Text App"),
      mainPanel(
            tabsetPanel(type = 'tabs',
                        tabPanel("Prediction App", br(),
                                 textInput(inputId = 'sentence', label = 'Begin a sentence here:'),
                                 h4("Predicted Next Word: "),
                                 em(textOutput('prediction')),
                                 h4("Other Possible Words: "),
                                 em(textOutput('possible'))),
                        tabPanel("Methodology", br(),
                                 h3("Analysis Code: "),
                                 p(strong("Project Repository: "), a("GitHub: Patrickdg", href = "https://github.com/Patrickdg/Predictive-Text-Application---Natural-Language-Processing")),
                                 p(a("Data Acquisition, Cleaning, and Sampling", href = "https://github.com/Patrickdg/Predictive-Text-Application---Natural-Language-Processing/blob/master/1%20-%20Predictive%20Text%20App%20-%20Getting%20%26%20Cleaning%20the%20Data.R")),
                                 p(a("Exploratory Analysis and Testing Results", href = "http://rpubs.com/patrickdg/PredictiveTextApp")),
                                 p(a("Predictive Algorithm - 5-gram Stupid Backoff Model", href = "https://github.com/Patrickdg/Predictive-Text-Application---Natural-Language-Processing/blob/master/3%20-%20Predictive%20Text%20App%20-%20Model.R"))
                                 ),
                        tabPanel("About", br(),
                                 h3("Description"), 
                                 p("This application was developed as submission for the Data Science Specialization Capstone Course within the Data Science Specialization program (taught by Johns Hopkins University via Coursera). "),
                                 p("More information regarding the certificate program can be found", 
                                   a("here", href = "https://www.coursera.org/specializations/jhu-data-science")),
                                 br(),
                                 h3("Additional Information"),
                                 p(strong("Developer: "), "Patrick de Guzman"),
                                 p(strong("Date: "), "September 2, 2019"), 
                                 p(strong("Data Sources: "), a("Swiftkey via Coursera", href = "https://d396qusza40orc.cloudfront.net/dsscapstone/dataset/Coursera-SwiftKey.zip"))
                                 )
                        )
      )
  
  
)
)
  