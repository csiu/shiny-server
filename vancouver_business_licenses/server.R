library(shiny)

shinyServer(function(input, output) {
  output$results <- renderPlot({
    x <- dat %>%
      filter(NumberOfEmployees > input$employeesInput[1],
             NumberOfEmployees < input$employeesInput[2],
             LicenceRevisionNumber == input$licensernInput,
             BusinessType == input$businesstypeInput) %>%
      group_by(Status, LocalArea) %>%
      summarise(count = n())

    if (nrow(x) != 0) {
      x %>% ggplot(aes(y = LocalArea, x = Status, fill = count)) +
        geom_tile() +
        ylab("") +
        xlab("") +
        scale_fill_viridis() +
        theme(
          axis.text.x = element_text(angle = 45, hjust = 1)
        )
    } else {
      ggplot(data.frame(x = 0, y = 0),
             aes(x = x, y = y)) +
        geom_blank() +
        xlab("") +
        ylab("") +
        theme(
          axis.text = element_blank()
        ) +
        annotate("text", x = 0, y = 0, label = "No data", size = 10)
    }
  })
})
