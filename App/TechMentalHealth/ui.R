library(shiny)
library(ggplot2)
library(tidyverse)
library(dplyr)

# set up data


intro_page <- tabPanel(
    # page name
    "Introduction",

    # page content
    mainPanel(
        ui <- fluidPage(
            tags$h1("Introduction"),
            tags$img(src="https://ahahealthtech.org/wp-content/uploads/2020/04/Mental-Health-Technology.jpg",
                     height=350,
                     width=800
            ),
            tags$br(),
            tags$p("The goal of this project is to explore how technology usage influences mental health across a wide variety of demographics, as well as
                    look into the state of mental health and mental health treatments in the tech industry. Some of the questions I hope to answer while
                    exploring this domain include:"),
            tags$ul(
                tags$li("How common is it for companies to provide mental health assistance/treatments?"),
                tags$li("Are certain groups of people more prone to unhealthy social media usage, and how much does this vary?"),
                tags$li("What are some possible factors that might affect whether or not employees in the tech industry are willing to seek out mental health treatments?")
            ),
            tags$p("These questions are motivated by a desire to understand the role of technology in addressing our everyday mental health,
                    especially with its increasing prevalence in society over time. Answering these questions is important because it would give
                    more insight as to how technology might have different impacts on mental health across different demographics, as well as
                    ultimately guiding healthcare providers, researchers, and other individuals to promoting positive mental health and well-being."
            ),
            tags$p(
                tags$a(href="https://www.kaggle.com/datasets/osmi/mental-health-in-tech-survey", "My first dataset"),
                       " is from a survey conducted in 2014 that measures different attitudes towards mental health from employees in the tech industry."
            ),
            tags$p(
                tags$a(href="https://www.kaggle.com/datasets/souvikahmed071/social-media-and-mental-health/data", "My second dataset"),
                       " is from a 2023 survey conducted as part of a data science and machine learning project for a statistics course. The survey was conducted by university students
                       in Dhaka, Bangladesh, and collected data regarding participants' mental health state and experience with social media."
            )
        )    
    )
)


ui <- navbarPage(
    "Technological Impact On Mental Health",
    intro_page
)
