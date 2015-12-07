library(shiny)
shinyUI(fluidPage(

  titlePanel("twitExploR"),

  sidebarLayout(
    sidebarPanel(
      h3("Retrieval options"),
      textInput('searchString', label="Enter twitter search seed:",
                value="twitter"),
      numericInput('maxTweets', label="Enter maximum number of tweets retrieved:",
                   value=50),
      actionButton("Submit", label="Submit"),
      hr(),

      h3("Wordcloud options"),
      selectInput('colPalette', label="Color palette:",
                  choices=c("Dark2",
                            "Set2",
                            "Set1",
                            "YlGnBu",
                            "BuPu"),
                  selected="Dark2"),
      radioButtons('randomOrder', label="Word Layout:",
                   choices=list("Random"=TRUE,
                                "Not random"=FALSE),
                   selected=TRUE)
    ),
    mainPanel(
      tabsetPanel(
        tabPanel("Wordcloud", plotOutput('wordcloudpt')),
        tabPanel("Tweets", dataTableOutput('tweettable')),
        tabPanel("Source", plotOutput('sourcehistogram'))
      )
    )

  )
))
