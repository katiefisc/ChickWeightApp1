library(ggplot2)
library(shiny)
library(datasets)
data(ChickWeight)

# Define UI for application
shinyUI(pageWithSidebar(
        
        # Application title
        headerPanel("Chick Weight Shiny App"),
        sidebarPanel(
                p("The body weights of the chicks were measured at birth and every 
                  second day thereafter until day 20. They were also measured on day 21. 
                  There were four groups on chicks on different protein diets. In this app,
                  we are looking at the mean weight of chicks on each of the diets over the 
                  total time period."),
                p("Select a Diet below and to the right you will see the calculated 
                  mean for the selected diet automatically update."),
                selectInput("Diet", label = h3("Select box"), 
                            choices = list("Diet 1" = "1",
                                           "Diet 2" = "2",
                                           "Diet 3" = "3",
                                           "Diet 4" = "4"), 
                            selected = 1)
                
        ),
        mainPanel( 
                h3(textOutput("mainpaneltext")),
                tableOutput("meanweight")
                )    
        )
)