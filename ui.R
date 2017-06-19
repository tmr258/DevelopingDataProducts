#
# This app is the final assignment for the course Developing
# Data Products

library(shiny)
library(utils)
library(caret)
library(MASS)
library(ggplot2)

# Define UI for application that calculates median house value
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Predict your House Price in Boston"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      submitButton("Submit Now!"),
      sliderInput("CRIM", "Per capita crime rate by town",
                   min = 0,
                   max = 100,
                   value = 3.6),
       sliderInput("ZN", "Proportion of residential land zoned for lots over 
25,000 sq.ft",
                   min = 0,
                   max = 100,
                   value = 11.4),
       sliderInput("INDUS", "Proportion of non-retail business acres per town",
                   min = 0,
                   max = 50,
                   value = 11.1),
       sliderInput("CHAS", "Position towards Charles River, (= 1 if tract bounds river, otherwise 0)",
                   min=0,
                   max=1,
                   value=0.5),
       sliderInput("NOX", "Nitric oxides concentration (parts per 10 million)",
                   min = 0,
                   max = 1,
                   value = 0.55),
       sliderInput("RM", "Average number of rooms per dwelling",
                   min = 1,
                   max = 12,
                   value = 6.3),
       sliderInput("AGE", "Proportion of owner-occupied units built prior to 1940",
                   min = 0,
                   max = 100,
                   value = 68.6),
       sliderInput("DIS", "Weighted distances to five Boston employment centres",
                   min = 0,
                   max = 20,
                   value = 3.8),
       sliderInput("RAD", "Index of accessibility to radial highways",
                   min = 0,
                   max = 25,
                   value = 9.5),
       sliderInput("TAX", "Full-value property-tax rate per $10,000",
                   min = 0,
                   max = 1000,
                   value = 408.2),
       sliderInput("PRATIO", "Pupil-teacher ratio by town",
                   min = 1,
                   max = 50,
                   value = 18.5),
       sliderInput("B", "1000(Bk - 0.63)^2 where Bk is the proportion of blacks 
by town",
                   min = 136,
                   max = 397,
                   value = 356,7)       ,
       sliderInput("LSTAT", "Percentage lower status of the population",
                   min = 0,
                   max = 50,
                   value = 12.7)
       
       
    ),
    
    # Show a plot of the predicted value of home property in Boston area
    mainPanel(
       plotOutput("predPlot"),
       
      h4("Predicted Median Value of your Property according to the PLS Model fit"),
      textOutput("pred_pls"),
      h4("Predicted Median Value of your Property according to the GBM Model fit"),
      textOutput("pred_gbm"),
      h4("Difference between the PLS Model fit and GBM Model fit"),
      textOutput("pred_difference") 
       
    )
  )
))


