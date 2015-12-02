library(shiny)

shinyUI(fluidPage(
  # Application title
  titlePanel("Vancouver Business Licenses"),

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      sliderInput("employeesInput",
                  "Number of employees:",
                  min = 0,
                  max = 10000,
                  value = c(0,30)),
      radioButtons("licensernInput", "License Revision Number",
                   choices = levels(dat$LicenceRevisionNumber),
                   selected = "00"),
      selectInput("businesstypeInput", "Business Type",
                  choices = levels(dat$BusinessType),
                  selected = "Liquor Retail Store")
    ),

    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("results")
    )
  )
))
