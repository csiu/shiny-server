library(twitteR)
library(wordcloud)
library(tm)
library(SnowballC)
library(ggplot2)

source('setup_twitter_oauth.R')

# twitteR OAuth authentication
setup_twitter_oauth(consumer_key, consumer_secret,
                    access_token, access_secret)

get_tweets <- function(searchString, maxTweets=50){
  # Retrieve text from twitter
  tweets <- searchTwitter(searchString, lang="en", n=maxTweets)

  df <- do.call("rbind", lapply(tweets, as.data.frame))
  return(df)
}

process_tweets2docMatrix <- function(df){
  # build a corpus (collection of text docs)
  myCorpus <- Corpus(VectorSource(df$text))

  # Transform text
  myCorpus <- tm_map(myCorpus,
                     content_transformer(function(x){
                       iconv(x, to='UTF-8-MAC', sub='byte')
                     }))
  myCorpus <- tm_map(myCorpus, mc.cores=1,
                     content_transformer(tolower))
  myCorpus <- tm_map(myCorpus, mc.cores=1,
                     content_transformer(removePunctuation))
  myCorpus <- tm_map(myCorpus, mc.cores=1,
                     content_transformer(removeNumbers))
  # remove stopwords
  myStopwords <- c(stopwords('english'), "available", "via")
  myCorpus <- tm_map(myCorpus, removeWords, myStopwords, mc.cores=1)

  #   # Stemming words
  #   dictCorpus <- myCorpus
  #   # stem words in a text document with the snowball stemmers,
  #   # which requires packages Snowball, RWeka, rJava, RWekajars
  #   myCorpus <- tm_map(myCorpus, mc.cores=1,
  #                      content_transformer(stemDocument))
  #   # stem completion (e.g. to their original form)
  #   myCorpus <- tm_map(myCorpus, mc.cores=1,
  #                      content_transformer(stemCompletion), dictionary=dictCorpus)

  # Build a document-term matrix
  myDtm <- TermDocumentMatrix(myCorpus, control=list(minWordLength=1))
  return(myDtm)
}

build_wordcloud <- function(myDtm, ...){
  # Word cloud
  m <- as.matrix(myDtm)
  # calculate the frequency of words
  v <- sort(rowSums(m), decreasing=TRUE)
  myNames <- names(v)
  d <- data.frame(word=myNames, freq=v)
  wordcloud(d$word, d$freq, min.freq=2, ...)
}

build_histogram <- function(myDat, ...){
  qplot(myDat, geom="histogram", xlab="", ylab="") +
    theme(axis.text.x = element_text(angle=45, hjust=1))
}
