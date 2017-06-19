#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(utils)
library(caret)
library(MASS)
library(ggplot2)
library(gbm)
library(pls)

# Define server logic

shinyServer(function(input, output) {
 
  Boston_data <- Boston
  colnames(Boston_data) <- c("CRIM", "ZN", "INDUS", "CHAS", "NOX", "RM", "AGE", 
                             "DIS", "RAD", "TAX", "PRATIO", "B", "LSTAT", "MEDV")
  
  model_gbm <- train(MEDV ~ ., method="gbm", data = Boston_data, verbose=FALSE)
  model_pls <- train(MEDV ~ ., method ="pls", data= Boston_data, verbose=FALSE)
   
  model_pls_predict <- reactive({
      input_values <- data.frame(input$CRIM, input$ZN,input$INDUS, input$CHAS, input$NOX, 
                      input$RM, input$AGE, input$DIS, input$RAD, input$TAX,
                      input$PRATIO, input$B, input$LSTAT)
      colnames(input_values) <- c("CRIM", "ZN", "INDUS", "CHAS", "NOX", "RM", "AGE", 
                                  "DIS", "RAD", "TAX", "PRATIO", "B", "LSTAT")
      predict(model_pls, newdata = input_values)
  })
   
  model_gbm_predict <- reactive({
    input_values <- data.frame(input$CRIM, input$ZN,input$INDUS, input$CHAS, input$NOX, 
                      input$RM, input$AGE, input$DIS, input$RAD, input$TAX,
                      input$PRATIO, input$B, input$LSTAT)
    colnames(input_values) <- c("CRIM", "ZN", "INDUS", "CHAS", "NOX", "RM", "AGE", 
                                "DIS", "RAD", "TAX", "PRATIO", "B", "LSTAT")
    predict(model_gbm, newdata = input_values)
  })
  
  
  output$predPlot <- renderPlot({
    
    plot_input <- matrix(c(model_pls_predict(), model_gbm_predict()), nrow = 1, ncol = 2)
    barplot(plot_input, names.arg = c("PLS Model Prediction", "GBM Model Prediction"), 
            main="Predicted House Price in US$ with two models",
            xlab="Fitting Method", ylab="Median Value in $", col=plot_input) 
    
  })
  
  output$pred_pls <- renderText({
  
    c("$ ", round(1000*model_pls_predict(),0))
      
  })
  output$pred_gbm <- renderText({
    
    c("$ ", round(1000*model_gbm_predict(),0))
    
  })
  output$pred_difference <- renderText({
    
    c("$ ", round(1000*abs(model_pls_predict() - model_gbm_predict()),0), " or ", 
      abs(round(100*(model_gbm_predict()-model_pls_predict())/model_pls_predict(),1)), " %") 
    
  })
  
})
