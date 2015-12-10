library(shiny)

fluidPage(
  titlePanel("BC Liquor Store prices"),

  sidebarLayout(
    sidebarPanel(
      #helpText("Hello world"),
      sliderInput("priceInput", "Price",
                  0, 100, c(0, 15), pre = "$"),
      sliderInput("sweetnessInput", "Sweetness",
                  0, 10, c(8, 10)),
      radioButtons("typeInput", "Product type",
                    choices = c("BEER", "REFRESHMENT", "SPIRITS", "WINE"),
                    selected = "WINE"),
      hr(),
      h3("Specific plot options"),
      h4("Budget Drinks"),
      selectInput("viridisInput", 'Viridis Theme',
                  choices = c("A", "B", "C", "D"),
                  selected = "D"),
      br(),
      h4("Cost of Subtypes"),
      numericInput("minPriceInput", "Min Cost ($)", value = 0),
      numericInput("maxPriceInput", "Max Cost ($)", value = 30250)

#       checkboxGroupInput("typeInput", "Product type",
#                    choices = c("BEER", "REFRESHMENT", "SPIRITS", "WINE"),
#                    selected = "WINE"),
#       uiOutput("countryOutput"),
#       #submitButton("Submit"),
#       checkboxInput("sweetnessNAInput", 'Show "NA"',
#                     value = TRUE),
#       hr(),
#       radioButtons("colorInput", "Color",
#                    choices = c("A", "B", "C"),
#                    selected = "A")
    ),

    mainPanel(
      tabsetPanel(
        tabPanel("Budget Drinks", plotOutput("budgetdrinks")),
        tabPanel("Sweetness of Subtypes", plotOutput("sweetsubtypes")),
        tabPanel("Cost of Subtypes", plotOutput("costsubtypes")),
        tabPanel("Alcohol content and Sweetness", plotOutput("alcoholpersweetness"))
      ),
      br(), br(),
      dataTableOutput("results")
    )
  )
)
