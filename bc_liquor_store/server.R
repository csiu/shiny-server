library(shiny)
library(viridis)

function(input, output, session) {
  viridisColor <- reactive({input$viridisInput})

  filtered <- reactive({
    bcl %>%
      filter(Price >= input$priceInput[1],
             Price <= input$priceInput[2],
             Sweetness >= input$sweetnessInput[1],
             Sweetness <= input$sweetnessInput[2]
      )
  })

  filtered_withTypes <- reactive({
    filtered() %>%
      filter(Type == input$typeInput)
  })

  filtered_withMultiTypes <- reactive({
    filtered() %>%
      filter(Type %in% input$multitypeInput)
  })

  filtered_subtype_price_count <- reactive({
    dat.sweet <- bcl %>%
      filter(Type == input$typeInput,
             Sweetness >= input$sweetnessInput[1],
             Sweetness <= input$sweetnessInput[2],
             Price >= input$minPriceInput,
             Price <= input$maxPriceInput) %>%
      group_by(Subtype, Price) %>%
      dplyr::summarise(count = n())

    ## Reorder factor
    dat.sweet$Subtype <- with(dat.sweet, reorder(Subtype, Price, function(x){-max(x)}))

    dat.sweet
  })

  output$budgetdrinks <- renderPlot({
    if (is.null(filtered())) {
      return()
    }
    filtered() %>%
      group_by(Type, Sweetness) %>%
      dplyr::summarise(count = n()) %>%
      ggplot(aes(x = Type, y = count, fill = Sweetness)) +
      geom_bar(stat = "identity") +
      scale_fill_viridis(option = viridisColor())
  })

  output$sweetsubtypes <- renderPlot({
    if (is.null(filtered())) {
      return()
    }
    filtered_withTypes() %>%
      group_by(Sweetness, Subtype) %>%
      dplyr::summarise(count = n()) %>%
      ggplot(aes(x = Sweetness,
                 y = reorder(Subtype, Sweetness),
                 label = count,
                 size = count)) +
      geom_point(alpha = 0.5, color = "orange") +
      geom_text(color = "black") +
      scale_size(range = c(3,8)) +
      ylab("") +
      theme(legend.position = "none")
  })

  output$costsubtypes <- renderPlot({
    filtered_subtype_price_count() %>%
      ggplot(aes(x = Price, y = 1, size = count)) +
      geom_point(colour="black", fill="blue", pch=21, alpha = 0.3) +
      ylab("") +
      facet_grid(Subtype~.) +
      theme(
        axis.text.y = element_blank(),
        axis.ticks.y = element_blank(),
        strip.text.y = element_text(size = 7, angle = 360),
        legend.position = "top"
      )
  })

  output$alcoholpersweetness <- renderPlot({
    filtered_withMultiTypes() %>%
      ggplot(aes(x = as.factor(Sweetness),
                 y = Alcohol_Content,
                 group = Sweetness)) +
      geom_violin(alpha = 0.3) +
      geom_jitter(
        aes(color = Type),
        alpha = 0.6,
        size = 3,
        position = position_jitter(width = .1,
                                   height = 0)) +
      scale_size(range = c(3,8)) +
      scale_colour_discrete(drop=TRUE, limits = levels(filtered_withMultiTypes()$Type)) +
      xlab("Sweetness") +
      ylab("Alcohol content")
  })

  output$results <- renderDataTable({
    filtered_withMultiTypes() %>%
      arrange(desc(Sweetness),
              Price)
  }, options = list(pageLength = 10))
}
