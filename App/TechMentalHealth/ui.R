library(shiny)
library(ggplot2)
library(tidyverse)
library(dplyr)
library(shinythemes)

# set up data for any widgets
social_media <- read.csv('https://raw.githubusercontent.com/info-201b-sp24/final-project-jimngu000/main/Data/smmh.csv')
industry <- read.csv('https://raw.githubusercontent.com/info-201b-sp24/final-project-jimngu000/main/Data/survey.csv')
no_na_states <- industry %>%
  filter(state != "NA")
# intro page
intro_page <- tabPanel(
    "Introduction",

    # page content
    mainPanel(
        ui <- fluidPage(
            theme = shinytheme("flatly"),
            tags$h1("Introduction"),
            tags$img(src="https://ahahealthtech.org/wp-content/uploads/2020/04/Mental-Health-Technology.jpg",
                     height=350,
                     width=800
            ),
            tags$br(),
            tags$br(),
            tags$h2("Problem & Motivation"),
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
            tags$br(),
            tags$h2("Datasets"),
            tags$p(
                tags$a(href="https://www.kaggle.com/datasets/osmi/mental-health-in-tech-survey", "My first dataset"),
                       " is from a survey conducted in 2014 that measures different attitudes towards mental health from employees in the tech industry."
            ),
            tags$p("Some ethical questions that need to be considered when working with a dataset like this include:"
            ),
            tags$ul(
                tags$li("Are there any potential risks to employees participating in the survey (i.e., potential negative consequences for employees who respond negatively/express negative feelings about mental health)?"),
                tags$li("Were there certain groups of employees that may have been under/overrepresented in the dataset (different skill levels/positions)?"),
                tags$li("Were any cultural sensitivities taken into account when collecting the data that may have directly influenced any of the responses?")
            ),
            tags$p("One possible limitation with this dataset may be the accuracy with which the responses accurately portray opinions on mental health in the modern-day tech field, as the data collected was from 2014."
            ),
            tags$p(
                tags$a(href="https://www.kaggle.com/datasets/souvikahmed071/social-media-and-mental-health/data", "My second dataset"),
                       " is from a 2023 survey conducted as part of a data science and machine learning project for a statistics course. The survey was conducted by university students
                       in Dhaka, Bangladesh, and collected data regarding participants' mental health state and experience with social media."
            ),
            tags$p("Some ethical questions that need to be considered when working with a dataset like this include:"
            ),
            tags$ul(
                tags$li("Was the survey conducted in a way that avoids bias in order to accurately capture how technology might affect the participants' everyday life?"),
                tags$li("Were there any groups that might have been underrepresented in the survey, and how would this affect the overall interpretation of the data?"),
                tags$li("What are some different ways that this data can be utilized after its collection, and how can it be ensured that this data is used responsibly?")
            ),
            tags$p("One possible limitation with this dataset would be the location in which the survey was conducted. Since it only involved participants in Dhaka, Bangladesh, it only gives insight into the specific mental health/technology intersectionality of that one country as opposed to a broader view. Another possible limitation with the dataset might be underrepresentation; since the survey was conducted by college students for a course, it's possible that other college-student participants make up a majority of the data, which means other demographics (graduates, industry workers) might be underrepresented."
            )
        )    
    )
)

# page 2
page_two <- tabPanel(
    "Companies Providing Mental Health Benefits",

    sidebarLayout(
        sidebarPanel(
            # state selector
            selectInput(
                inputId = "state",
                label = "Select state: ",
                choices = sort(unique(no_na_states$state))
            )
        ),

        # display chart
        mainPanel(
            ui <- fluidPage(
                theme = shinytheme("flatly"),
                plotOutput(outputId = "page_2_chart"),
                tags$h3("Description"),
                tags$p("This chart represents the number of companies (separated by company size) that provide some sort of mental health treatment, including therapy, screenings, workshops, or other benefits. It divides these results up by state according to the states that were included in the survey respondents’ submissions. This chart is important because it allows us to see how companies of different sizes provide different levels of care for those suffering from mental health conditions, and can help us analyze these trends across states.")
            )
        )
    )
)

# page 3
page_three <- tabPanel(
    "Social Media Usage By Occupation",

    sidebarLayout(
        sidebarPanel(
            # occupation selector
            selectInput(
                inputId = "occupation",
                label = "Select occupation: ",
                choices = unique(social_media$X4..Occupation.Status)
            )
        ),

        mainPanel(
            ui <- fluidPage(
                theme = shinytheme("flatly"),
                plotOutput(outputId = "page_3_chart"),
                tags$h3("Description"),
                tags$p("This chart represents the number of users that utilize social media for various amounts of time on a daily basis. The chart also incorporates organization by four different occupations, allowing us to see trends across different demographics (presumably different age groups across the occupations). This chart is important because it lets us analyze both high and low social media usage by certain groups. Since the recommended amount of social media usage per day is roughly 2 hours, this might indicate a higher likelihood of certain groups being negatively affected by social media due to high usage.")
            )
        )
    )
)

# page 4
page_four <- tabPanel(
    "Mental Health Treatment Age Distribution",

    sidebarLayout(
        sidebarPanel(
            # treatment selector
            radioButtons(
                inputId = "treatment",
                label = "Did the survey respondent seek mental health treatment?",
                choices = list("Yes" = "Yes", "No" = "No"),
                selected = "Yes"
            ),

            # company size selector
            selectInput(
                inputId = "no_employees",
                label = "Select company size (number of employees): ",
                choices = unique(industry$no_employees),
                selected = "1-5"
            )
        ),

        # display chart
        mainPanel(
            ui <- fluidPage(
                theme = shinytheme("flatly"),
                plotOutput(outputId = "page_4_chart"),
                tags$h3("Description"),
                tags$p("This chart represents the age distribution of employees in the tech industry who reported mental health conditions, separated by U.S. states. The chart also incorporates whether or not the respondents sought out mental health treatment or not, as well as the size of the company in terms of the number of employees. The states included in the chart are those which were reported in the survey that each respondent filled out. This chart is important because it allows us to see the different age groups that are the most prone to mental health conditions across differing locations within the U.S., as well as assess the likelihood of certain age groups seeking out mental health treatment (and whether or not company size factors into this likelihood).")
            )
        )
    )
)

# takeaways page
takeaways <- tabPanel(
    "Conclusions & Takeaways",

    ui <- fluidPage(
            theme = shinytheme("flatly"),
            tags$h1("Conclusions & Takeaways"),
            tags$p("As a result of my research, I noticed some trends that helped me lean towards certain answers for my initial response questions. For example, I noticed that it is becoming relatively more common that larger-size companies are providing mental health benefits, according to responses given in the tech survey I analyzed. Washington, one of the states with the highest number of respondents, had over 75 employees from companies with more than 1000 people responding that their company provided mental health care benefits. California also had over 300 employees from companies with over 1000 people indicating that their company provided mental health benefits, and over 50 employees from companies with 100-500 people indicating the same."),
            tags$p("Another trend I noticed was that university and school students are more likely to utilize social media for an unhealthy amount of time. According to the chart on social media usage by occupation, over 75 respondents who selected “University Student” as their occupation claim they use social media for more than 5 hours per day. Whereas only roughly 40 respondents reported using social media for between 1-2 hours or less than an hour per day. Experts generally recommend only between 30 minutes to 2 hours of social media per day for it to be considered a healthy level of usage, so it was interesting to see how the level of healthy social media usage differed across occupations and even within the same ones."),
            tags$p("Finally, after analyzing my chart on age distribution of mental health conditions by state, I found that there tended to be more data for employees suffering from mental health conditions who sought out mental health treatment compared to those who did not seek out treatment. Of those who sought out treatment and were in mid-level companies (26-100 people), the average range of ages was 25-40 years old, with the exception of employees from the state of Massachusetts (roughly 25-45). I thought this was interesting because it showed how those who are generally earlier on in their career might be more likely to treat their mental health conditions. I also thought it was interesting that the ranges varied so much across different states, which might indicate different socioeconomic dynamics that influence the likelihood of someone seeking out mental health care."),
            tags$p("Overall, the most important insight I achieved from my analysis was discovering how there are so many factors besides technological usage that come into play when determining the likelihood of someone treating their mental health conditions, assuming they are suffering from any. This calls back to my original motivation for the project, as I believe experimenting more with these aforementioned factors and determining how heavily they can impact mental health care will ultimately allow healthcare providers and other individuals to promote and pursue positive mental health and well-being.")
    )

)
# construct ui
ui <- navbarPage(
    "Technological Impact On Mental Health",
    intro_page,
    page_two,
    page_three,
    page_four,
    takeaways
)
