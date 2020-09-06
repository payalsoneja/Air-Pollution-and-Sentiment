# Air Pollution Sentiment Analysis with Twitter

Analysis of air pollution data and it's impact on the sentiments of people

### 1. Getting Twitter Data

#### Credentials
+ To get credentials for twitter, set up a new application using this [link](https://apps.twitter.com/app/new)
+ After creating the app, `consumer_key`, `consumer_secret`, `access_token`, and `access_secret` will be generated 

#### Get tweets using `twitterR`

+ `twitter_pollution.R` contains code to use credentials generated before to perform keyword search for tweets using `twitteR` library
+ The parameters are set to search in and around Delhi, India (200 KM radius)
+ The code then saves the tweets in `.rds` file

### 2. Cleaning the tweets

`twitter_pollution.R` also performs the following cleaning steps using regex:
+ Removes all `@username`
+ Removes punctuation
+ Removes links
+ Removes tabs
+ Strips blank spaces at end
+ Removes stop words

### 3. Run sentiment analysis

`twitter_pollution.R` runs sentiment analysis on cleaned tweets using 2 approaches:
+ Using built in function `get_nrc_sentiment` 
+ By breaking down into sentences and using `sentimentr` library to get sentiments
