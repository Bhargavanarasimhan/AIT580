# -*- coding: utf-8 -*-
"""
Created on Sat Apr  6 18:33:42 2019

@author: Nero
"""

import nltk
from nltk import sent_tokenize
from nltk.tokenize import word_tokenize
#from nltk.corpus import stopwords 
#stop_words = set(stopwords.words('english')) 

#Read the file into lines using .read() function
bike_injury = open("C://Users/Owner/Desktop/AIT 580/Assignments/BikeInjury.txt", "r") 
lines = bike_injury.read()

# Qn 1: Word count summary and graph of most frequent types (Before cleansing)
#--------------------#
tokenized_word=word_tokenize(lines)
freq_dist = nltk.FreqDist(tokenized_word)
print(freq_dist)
print(freq_dist.most_common(20))
freq_dist.plot(20)
    
#Use regular expressions to parse them for words and also by converting lines variables to lower
from nltk.tokenize import RegexpTokenizer
tokenizer = RegexpTokenizer(r'\w+')
tokens = tokenizer.tokenize(lines.lower())

#remove stop words by using stopwords library of nltk
from nltk.corpus import stopwords
tokens = [token for token in tokens if token not in stopwords.words('english')]
print(tokens)

#describe 25 common injuries
freq_dist = nltk.FreqDist(tokens)
print(freq_dist)
print(freq_dist.most_common(25))
freq_dist.plot(25)

#Use sent_tokenize to display several injury description sentences
sentences = nltk.sent_tokenize(lines)
print(sentences[0])
print(sentences[1])
print(sentences[20])
