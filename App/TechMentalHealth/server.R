library(shiny)
library(ggplot2)
library(tidyverse)
library(dplyr)

# do all data processing
social_media <- read.csv('https://raw.githubusercontent.com/info-201b-sp24/final-project-jimngu000/main/Data/smmh.csv')
industry <- read.csv('https://raw.githubusercontent.com/info-201b-sp24/final-project-jimngu000/main/Data/survey.csv')

# clean industry data gender submissions
industry <- industry %>% filter(grepl('2014', industry$Timestamp))
industry$Gender <- toupper(industry$Gender)
industry$Gender[grep("\\bM\\b",industry$Gender)] <- 'MALE'
industry$Gender[grep("\\bF\\b",industry$Gender)] <- 'FEMALE'
industry$Gender[grep("\\bWOMAN\\b",industry$Gender)] <- 'FEMALE'

genders <- c("MALE", "FEMALE")
industry <- industry[industry$Gender %in% genders, ]

# page 2 data
industry_2 <- industry %>%
  select(state, no_employees, benefits, work_interfere) %>%
  filter(work_interfere != "NA") %>%
  group_by(state, no_employees) %>%
  na.omit() %>%
  mutate(count_benefits = sum(benefits == "Yes")) %>%
  distinct()

# page 3 data
social_media2 <- social_media %>%
  select(X4..Occupation.Status, X8..What.is.the.average.time.you.spend.on.social.media.every.day.) %>%
  group_by(X4..Occupation.Status, X8..What.is.the.average.time.you.spend.on.social.media.every.day.) %>%
  na.omit() %>%
  mutate(count_usage = n()) %>%
  distinct()

# page 4 data
industry_3 <- industry %>%
  select(state, no_employees, Age, treatment, work_interfere) %>%
  filter(work_interfere != "NA") %>%
  filter(Age <= 100) %>%
  group_by(state, no_employees)
industry_3 <- na.omit(industry_3)

# handle server
server <- function(input, output, session) {

# page 2
    filter_state <- reactive({
        industry_2 %>%
          filter(state == input$state, na.rm = TRUE)
    })
    
    output$page_2_chart <- renderPlot({
        ggplot(filter_state()) +
        geom_bar(aes(x = no_employees, y = count_benefits), stat = "identity") +
        labs(
            x = "Number of employees",
            y = "# of companies that provide mental health benefits"
        ) +
        ggtitle("Company Mental Health Benefits Per Company Size (2014)") +
        theme(plot.title = element_text(size = 20, face = "bold"))
    })

# page 3
    filter_occupation <- reactive({
        social_media2 %>%
        filter(X4..Occupation.Status == input$occupation, na.rm = TRUE)
    })

    output$page_3_chart <- renderPlot({
        ggplot(filter_occupation()) +
        geom_bar(aes(x = X8..What.is.the.average.time.you.spend.on.social.media.every.day., y = count_usage), stat = "identity") +
        labs(
            x = "Average time spent on social media daily",
            y = "# of users"
        ) +
        ggtitle("Average Time Spent On Social Media Daily By Occupation (Dhaka, Bangladesh, 2023)") +
        theme(plot.title = element_text(size = 15, face = "bold"))
    })

# page 4
    filter_treatment <- reactive({
        industry_3 %>%
          filter(treatment == input$treatment, na.rm = TRUE)
    })

    filter_size <- reactive({
        filter_treatment() %>%
          filter(no_employees == input$no_employees, na.rm = TRUE)
    })

    output$page_4_chart <- renderPlot({
        ggplot(filter_size()) +
        geom_boxplot(aes(x = state, y = Age, color = state)) +
        labs(x = "State", y = "Age") +
        ggtitle("Age Distribution Of Mental Health Conditions By State (2014)") +
        theme(plot.title = element_text(size = 20, face = "bold"))
    })
}
