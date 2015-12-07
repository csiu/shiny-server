library(shiny)
shinyServer(function(input, output) {

  df <- reactive({
    input$Submit

    s <- isolate(input$searchString)
    n <- isolate(input$maxTweets)

    get_tweets(s,n)
  })

  output$wordcloudpt <- renderPlot({
    myDtm <- process_tweets2docMatrix(df())
    build_wordcloud(myDtm,
                    colors=brewer.pal(8, input$colPalette),
                    random.order=input$randomOrder)
  })

  output$tweettable <- renderDataTable({
    df <- df()
    data.frame(User=df$screenName,
               Tweet=iconv(df$text, to='UTF-8-MAC', sub='byte')
    )
  })

  output$sourcehistogram <- renderPlot({
    df <- df()
    dat <- unlist(lapply(df$statusSource,function(x){gsub('.*>(.*)<.*',"\\1",x)}))
    build_histogram(dat)
  })

})
