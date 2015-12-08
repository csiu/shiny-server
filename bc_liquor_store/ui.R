library(shiny)

fluidPage(
  titlePanel("BC Liquor Store prices"),

  sidebarLayout(
    sidebarPanel(
      sliderInput("priceInput", "Price",
                  0, 100, c(25, 40), pre = "$"),
      radioButtons("typeInput", "Product type",
                   choices = c("BEER", "REFRESHMENT", "SPIRITS", "WINE"),
                   selected = "WINE"),
      uiOutput("countryOutput")
    ),

    mainPanel(
      plotOutput("coolplot"),
      br(), br(),
      dataTableOutput("results")
    )
  )
)
