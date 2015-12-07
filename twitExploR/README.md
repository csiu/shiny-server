## Note

`setup_twitter_oauth.R` should defined with the following content:

```r
library(twitteR)

## You will need to replace '<secret>'
consumer_key <- "<secret>"
consumer_secret <- "<secret>"
access_token <- "<secret>"
access_secret <- "<secret>"

setup_twitter_oauth(consumer_key, consumer_secret,
                    access_token, access_secret)
```
