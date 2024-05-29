library("shiny")
source("server.R")
source("ui.R")
print(shinyApp(ui = ui, server = server))