
setwd("C:/Users/Payal Soneja/Documents/GitHub/Air-Polluton-and-Sentiment")

### Extracting twitter sentiments to match with pollution data##

install.packages("rtweet")
install.packages("twitteR")
install.packages("SnowballC")
install.packages("tm")
install.packages("syuzhet")
install.packages("sentimentr")

# loading libraries
library(twitteR)
library(rtweet)
library(tidyverse)
library(broom)
library("SnowballC")
library("tm")
library("syuzhet")
library(sentimentr)

set.seed(1234)
theme_set(theme_minimal())

##using twitteR package to extract tweets
#load credentials
consumer_key <- "vfJAdncqBDbwEm2IBsQtOU1h1"
consumer_secret <- "C4gzpn5bV0oxClJCjG0A2CiiIxAFkwMJhByGe8vc4pk1nprxkd"
access_token <- "614136341-QrVWNccmnfiM5lIcCU9MIO2izg0uTR4ImQ8kqHEY"
access_secret <- "B4NZoP97jV9WCXqV8MQlXjLB3ceRZ46FFWdvOi5hM9j2F"

#set up to authenticate
setup_twitter_oauth(consumer_key ,consumer_secret,access_token ,access_secret)

tweets <- twitteR::searchTwitter('',n =10000,lang ="en",geocode='28.64,76.81,200km',since ='2019-07-20', until='2019-07-27')
tweets2 <- strip_retweets(tweets)

#convert to data frame using the twListtoDF function
df <- twListToDF(tweets2)                   #extract the data frame save it locally
saveRDS(df, file="tweets_27June.rds")
df1 <- readRDS("tweets_27June.rds")
 
n.tweet <- length(df)  ##variables
n.tweet <- length(df1)

df_text<- df$text

#convert all text to lower case
df_text<- tolower(df_text)

# Replace blank space ("rt")
#df_text <- gsub("rt", "", google_text)

# Replace @UserName
df_text <- gsub("@\\w+", "", df_text)

# Remove punctuation
df_text <- gsub("[[:punct:]]", "", df_text)  ##this removed back and forward slash

# Remove links
df_text <- gsub("http\\w+", "", df_text)

# Remove tabs
df_text <- gsub("[ |\t]{2,}", " ", df_text)

# Remove blank spaces at the beginning
df_text <- gsub("^ ", "", df_text)

# Remove blank spaces at the end
df_text <- gsub(" $", "", df_text)

#df$text <- gsub("http.*","",df$text)

#df$text <- gsub("https.*","",df$text)

#df$text <- gsub("#.*","",df$text)

#df$text <- gsub("@.*","",df$text)

#clean up by removing stop words
#df$text.text.corpus <- tm_map(google_tweets.text.corpus, function(x)removeWords(x,stopwords()))

#getting emotions using in-built function
mysentiment_tweets2<-get_nrc_sentiment((df_text))

##sentiment analysis using sentimentr; get sentiment score
sentences <- get_sentences(df_text)
sentiment(sentences)

########### Alternative approach to extracting tweets from Twitter ##########
##using rtweet package to extract tweets
# create token and save it as an environment variable
#twitter_token <- create_token(
  #app = 'rtweets_sentiments',
  #consumer_key = 'vfJAdncqBDbwEm2IBsQtOU1h1',
  #consumer_secret = 'C4gzpn5bV0oxClJCjG0A2CiiIxAFkwMJhByGe8vc4pk1nprxkd',
  #access_token = '614136341-QrVWNccmnfiM5lIcCU9MIO2izg0uTR4ImQ8kqHEY',
  #access_secret = 'B4NZoP97jV9WCXqV8MQlXjLB3ceRZ46FFWdvOi5hM9j2F'
#)

# check to see if the token is loaded
#identical(twitter_token, get_token())

#rt1 <- search_tweets( 
  #q = "#rstas",
  #n = 100,
  #include_rts = FALSE,
  #geocode ='28.64,76.81,100ml'
#)
