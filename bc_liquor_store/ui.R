library(shiny)

fluidPage(
  titlePanel(HTML("<span style='font-weight: 400'>Prices at the </span><span style='font-weight: 900'>BC LIQUOR</span><span style='font-weight: 200'>STORE</span> &mdash; Discover Sweetness")),

  sidebarLayout(
    sidebarPanel(
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
      numericInput("maxPriceInput", "Max Cost ($)", value = 30250),
      br(),
      h4("Alcohol Content and Sweetness"),
      p("Note: These changes are also reflected in the recommendation list."),
      checkboxGroupInput("multitypeInput", "Products selected",
                   choices = c("BEER", "REFRESHMENT", "SPIRITS", "WINE"),
                   selected = c("BEER", "REFRESHMENT", "SPIRITS", "WINE"))
    ),

    mainPanel(
      tabsetPanel(
        tabPanel("Budget Drinks",
                 br(),
                 h4(textOutput("summaryfiltered")),
                 plotOutput("budgetdrinks")),
        tabPanel("Sweetness of Subtypes",
                 br(),
                 h4(textOutput("summaryfiltered_withTypes")),
                 plotOutput("sweetsubtypes")),
        tabPanel("Cost of Subtypes",
                 br(),
                 h4(textOutput("summaryfiltered_subtype_price_count")),
                 plotOutput("costsubtypes")),
        tabPanel("Alcohol content and Sweetness",
                 br(),
                 h4(textOutput("summaryfiltered_withMultiTypes")),
                 plotOutput("alcoholpersweetness"))
      ),
      br(),
      br(),
      dataTableOutput("results")
    )
  )
)
