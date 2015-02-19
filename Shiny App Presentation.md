Chick Weight Shiny App Presentation
========================================================
author: Katie F
date: Thu Feb 19 12:48:10 2015

Background
========================================================
The dataset ChickWeight in R contains the body weights of the chicks were measured at birth and every second day thereafter until day 20. They were also measured on day 21. There were four groups of chicks on different protein diets.

This app looks at the mean weight for the different diets fed to the chicks in the experiment. In this presentation, we will review the basic functionality of the app and the code used to create it.

Process
========================================================
In this very simple app, we created a function which calculates the means of all the diets and returns 
the mean of the diet selected in the input field in the app. 

You can check it out [**here**](http://127.0.0.1:4285)

ui.R code
========================================================


```r
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
                h3(textOutput("mainpaneltex")),
                tableOutput("meanweight")
                )    
        )
)
```

<!--html_preserve--><div class="container-fluid">
<div class="row">
<div class="col-sm-12">
<h1>Chick Weight Shiny App</h1>
</div>
</div>
<div class="row">
<div class="col-sm-4">
<form class="well">
<p>The body weights of the chicks were measured at birth and every 
                  second day thereafter until day 20. They were also measured on day 21. 
                  There were four groups on chicks on different protein diets. In this app,
                  we are looking at the mean weight of chicks on each of the diets over the 
                  total time period.</p>
<p>Select a Diet below and to the right you will see the calculated 
                  mean for the selected diet automatically update.</p>
<div class="form-group shiny-input-container">
<label class="control-label" for="Diet">
<h3>Select box</h3>
</label>
<div>
<select id="Diet"><option value="1" selected>Diet 1</option>
<option value="2">Diet 2</option>
<option value="3">Diet 3</option>
<option value="4">Diet 4</option></select>
<script type="application/json" data-for="Diet" data-nonempty="">{}</script>
</div>
</div>
</form>
</div>
<div class="col-sm-8">
<h3>
<div id="mainpaneltex" class="shiny-text-output"></div>
</h3>
<div id="meanweight" class="shiny-html-output"></div>
</div>
</div>
</div><!--/html_preserve-->

server.R code
========================================================


```r
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
        
        # output text
        output$mainpaneltext <- renderText({
                paste("Mean weight for Diet ", input$Diet, sep="")
        })  
        # output of mean weight for selected diet
        output$meanweight <- renderTable({
                   
                        meanweight(x())
                
        })       
                
        
})
```

