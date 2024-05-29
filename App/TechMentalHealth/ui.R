library(shiny)
library(ggplot2)
library(tidyverse)
library(dplyr)

intro_page <- tabPanel(

    # Title
    "Testing",
    
    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            sliderInput("bins",
                        "Number of bins:",
                        min = 1,
                        max = 50,
                        value = 30)
        ),       
        # Show a plot of the generated distribution
        mainPanel(
            ui <- fluidPage(
            plotOutput("distPlot")
            )
        )
    )
)

ui <- navbarPage(
    "Technological Impact On Mental Health",
    intro_page
)

