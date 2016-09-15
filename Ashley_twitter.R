## loading required pacakges
library(ggplot2) # Data visualization
library(readr) # CSV file I/O, e.g. the read_csv function
library("tm") # Package for text mining
library("SnowballC")
library("wordcloud")
library(dplyr)
library("RColorBrewer") # Data Visualization

Ash=read.csv("C:/Users/Jay/Desktop/Prof.Mike/Ashley Madison/Ashley10k.csv",stringsAsFactors = FALSE)
names(Ash)

#load the twitter data

#format the Ash 
#Ash$text <- gsub("#GOPDebate", "", Ash$text) 
#Ash$text = gsub("(RT|via)((?:\\b\\W*@\\w+)+)", "", Ash$text) 
#Ash$text <- gsub("#GOPdebate", "", Ash$text)  
Ash$Contents = gsub("[[:punct:]]", "", Ash$Contents)
Ash$Contents = gsub("[[:digit:]]", "",Ash$Contents)
Ash$Contents = gsub("http\\w+", "", Ash$Contents)
Ash$Contents = gsub("\n", "", Ash$Contents)
#Ash$text = gsub("^\\s+|\\s+$", "", Ash$text)
#Ash$text = gsub("amp", "", Ash$text)
#Ash$text = gsub("[^\x20-\x7E]", "", Ash$text)

wcloud <- function(documents){
  wordcorpus <- Corpus(VectorSource(documents)) %>% 
    tm_map(content_transformer(tolower)) %>%
    tm_map(removePunctuation) %>%
    tm_map(stripWhitespace) %>% 
    #tm_map(stemDocument) %>% 
    tm_map(removeWords,stopwords("english")) %>%
    tm_map(removeWords,
           c("Ashley Madison","ashleymadison","madison","madisons","ashley","http","WWW","twitter")) %>%
    DocumentTermMatrix() %>%
    as.matrix() %>%
    as.data.frame()
  return(wordcorpus)
} 

Ash_clean <- wcloud(Ash$Contents)
freq <- colSums(Ash_clean)
freq <- sort(freq,decreasing = T)
head(freq)
#freq <- freq[c(-1,-2,-7)]
wordcloud(words = names(freq),freq,min.freq = sort(freq,decreasing = T)[[500]],random.order = FALSE,random.color = TRUE,
          colors = brewer.pal(8, "Dark2"))





# parsing date
date_and_time <- strptime(Ash$Date..CST., '%m/%d/%Y %H:%M')
Ash$Year <- as.numeric(format(date_and_time, '%Y'))
Ash$Month <- as.numeric(format(date_and_time, '%m'))
Ash$Day <- as.numeric(format(date_and_time, '%d'))
Ash$Source=NULL



# Group by data
library(dplyr)
g=group_by(Ash,Date, Category) 
df=summarise(g,n = n())
df=as.data.frame(df)

Ash$Date <- as.Date( Ash$Date, '%m/%d%Y')
ggplot(df, aes(x=Date, y=n, col=Category)) + geom_line()+scale_x_date() + xlab("Date") + ylab("Tweet counts")

