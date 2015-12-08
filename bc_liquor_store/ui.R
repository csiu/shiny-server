library(shiny)

fluidPage(
  titlePanel("BC Liquor Store prices"),

  sidebarLayout(
    sidebarPanel(
      helpText("Hello world"),
      sliderInput("priceInput", "Price",
                  0, 100, c(25, 40), pre = "$"),
      checkboxGroupInput("typeInput", "Product type",
                   choices = c("BEER", "REFRESHMENT", "SPIRITS", "WINE"),
                   selected = "WINE"),
      uiOutput("countryOutput"),
      #submitButton("Submit"),
      hr(),
      sliderInput("sweetnessInput", "Sweetness",
                  0, 10, c(0, 10)),
      checkboxInput("sweetnessNAInput", 'Show "NA"',
                    value = TRUE),
      hr(),
      radioButtons("colorInput", "Color",
                   choices = c("A", "B", "C"),
                   selected = "A")
    ),

    mainPanel(
      plotOutput("coolplot"),
      br(), br(),
      dataTableOutput("results")
    )
  )
)
