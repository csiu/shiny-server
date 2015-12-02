library(shiny)
suppressPackageStartupMessages(library(dplyr))
library(readr)
library(ggplot2)
library(viridis)

dat <- read_csv("data/business_licences.csv")
dat <- dat %>%
  #filter(grepl("vancouver", City, ignore.case = TRUE)) %>%
  mutate(
    LicenceRevisionNumber = as.factor(LicenceRevisionNumber),
    Status = as.factor(Status),
    BusinessType = as.factor(BusinessType),
    BusinessSubType = as.factor(BusinessSubType),
    UnitType = as.factor(UnitType),
    City = toupper(City),
    City = as.factor(City),
    Province = toupper(Province),
    Province = as.factor(Province),
    Country = as.factor(Country),
    LocalArea = as.factor(LocalArea),
    NumberOfEmployees = as.double(NumberOfEmployees)
  )

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
