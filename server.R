#
# Shiny App for Coursera Developing Data Products


library(shiny)
library(datasets)

shinyServer(function(input, output) {
        
        # Return selected Diet
        x <- reactive({input$Diet})
        
        
        
        # calculate mean weight
        meanweight <- function(x) {
                data <- ChickWeight
                Means <-aggregate(data$weight, list(diet = data$Diet), mean)
                names(Means)[names(Means)=="x"] <- "mean_weight"
                EnteredDiet <- Means[Means$diet == x ,]
                return(EnteredDiet)
        
        }
        
        # output title
        output$mainpaneltext <- renderText({
                paste("Mean weight for Diet ", input$Diet, sep="")
        })  
        # output of mean weight for selected diet
        output$meanweight <- renderTable({
                   
                        meanweight(x())
                
        })       
                
        
})