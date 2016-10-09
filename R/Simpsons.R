## Not run: 
library(readr)
simpsons <- read_csv("~/Downloads/simpsons_script_lines.csv")
homer <- subset(simpsons, simpsons$character_id == 2)
marge <- subset(simpsons, simpsons$character_id == 1)
bart <- subset(simpsons, simpsons$character_id == 8)
lisa <- subset(simpsons, simpsons$character_id == 9)

library(wordcloud)
set.seed(42)
library(quanteda) 
titles_corpus <- corpus(homer$spoken_words)
titles_token <- quanteda::tokenize(titles_corpus, what = "word", removeNumbers = TRUE, removePunct = TRUE, removeSymbols = TRUE, removeSeparators = TRUE, removeTwitter = TRUE, removeHyphens = TRUE, removeURL = TRUE, ngrams = 1L, skip = 0L)
titles_token <- toLower(titles_token, keepAcronyms = FALSE)

titles_dfm <- dfm(titles_token, stem = FALSE)
titles_dfm <- removeFeatures(titles_dfm, stopwords("english"))
titles_dfm <- removeFeatures(titles_dfm, c("a", "b", "c", "d", "e", "f", 
                                           "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "x", "y", "w", "z"))
# Show 1000 most frequent
title_frequencies <- topfeatures(titles_dfm, 1000)
body_cloud <- wordcloud(names(title_frequencies),title_frequencies, max.words = 100,colors=brewer.pal(6,'Dark2'))