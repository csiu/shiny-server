library(shiny)
library(viridis)

function(input, output, session) {
#   output$countryOutput <- renderUI({
#     selectInput("countryInput", "Country",
#                 sort(unique(bcl$Country)),
#                 selected = "CANADA")
#   })
#
#   filtered_old <- reactive({
#     if (is.null(input$countryInput)) {
#       return(NULL)
#     }
#
#     bcl %>%
#       filter(Price >= input$priceInput[1],
#              Price <= input$priceInput[2],
#              Type == input$typeInput,
#              Country == input$countryInput
#       )
#   })

  filtered <- reactive({
    bcl %>%
      filter(Price >= input$priceInput[1],
             Price <= input$priceInput[2]
      )
  })

  output$budgetdrinks <- renderPlot({
    if (is.null(filtered())) {
      return()
    }
    filtered() %>%
      filter(Sweetness > 7) %>%
      group_by(Type, Sweetness) %>%
      dplyr::summarise(count = n()) %>%
      ggplot(aes(x = Type, y = count, fill = Sweetness)) +
      geom_bar(stat = "identity") +
      scale_fill_viridis()
  })

  output$sweetsubtypes <- renderPlot({
    if (is.null(filtered())) {
      return()
    }
    filtered() %>%
      filter(Sweetness > 7,
             Type == "WINE") %>%
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

#   output$coolplot <- renderPlot({
#     if (is.null(filtered())) {
#       return()
#     }
#     g1 <- ggplot(filtered(), aes(x = Alcohol_Content,
#                                  fill = Type)) +
#       geom_histogram(binwidth = 1, origin = 0.5)
#
#     g2 <- filtered() %>%
#       group_by(Type, Alcohol_Content) %>%
#       summarise(count = n()) %>%
#       mutate(Alcohol_Content = round(Alcohol_Content, 1)) %>%
#       ggplot(aes(x = Alcohol_Content, y = count, fill = Type)) +
#       geom_point(subset = .(Type == "WINE"),
#                  pch=21, size=4) +
#       geom_point(subset = .(Type == "SPIRITS"),
#                  pch=21, size=4) +
#       geom_point(subset = .(Type == "BEER"),
#                  pch=21, size=4) +
#       geom_point(subset = .(Type == "REFRESHMENT"),
#                  pch=21, size=4)
#
#     cowplot::plot_grid(g1, g2, ncol = 1, align = "v")
#   })
#
  output$results <- renderDataTable({
    filtered()
  })
}
