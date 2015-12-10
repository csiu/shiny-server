library(shiny)

fluidPage(
  titlePanel("BC Liquor Store prices"),

  sidebarLayout(
    sidebarPanel(
      #helpText("Hello world"),
      sliderInput("priceInput", "Price",
                  0, 100, c(0, 15), pre = "$")
#       checkboxGroupInput("typeInput", "Product type",
#                    choices = c("BEER", "REFRESHMENT", "SPIRITS", "WINE"),
#                    selected = "WINE"),
#       uiOutput("countryOutput"),
#       #submitButton("Submit"),
#       hr(),
#       sliderInput("sweetnessInput", "Sweetness",
#                   0, 10, c(0, 10)),
#       checkboxInput("sweetnessNAInput", 'Show "NA"',
#                     value = TRUE),
#       hr(),
#       radioButtons("colorInput", "Color",
#                    choices = c("A", "B", "C"),
#                    selected = "A")
    ),

    mainPanel(
      tabsetPanel(
#         tabPanel("Coolplot", plotOutput("coolplot")),
#         tabPanel("TODO")
        tabPanel("Budget Drinks", plotOutput("budgetdrinks")),
        tabPanel("Sweetness of Subtypes", plotOutput("sweetsubtypes")),
        tabPanel("Cost of Subtypes", plotOutput("costsubtypes"))
      ),
      br(), br(),
      dataTableOutput("results")
    )
  )
)
