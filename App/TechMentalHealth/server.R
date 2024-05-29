library(shiny)
library(ggplot2)
library(tidyverse)
library(dplyr)

# do all data processing

# handle server
server <- function(input, output, session) {

# page 2
    output$distPlot <- renderPlot({

        x    <- faithful[, 2]
        bins <- seq(min(x), max(x), length.out = input$bins + 1)

        hist(x, breaks = bins, col = 'darkgray', border = 'white',
             xlab = 'Waiting time to next eruption (in mins)',
             main = 'Histogram of waiting times')

    })

# page 3

# page 4
}
