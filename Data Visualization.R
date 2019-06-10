suppressMessages(library(tidyverse))
library(tidyverse)
library(dplyr)
library(ggplot2) # Data visualization
library(readr) # CSV file I/O, e.g. the read_csv function
library(stringr)
library(wordcloud)

country_medals <- read.csv("C:/Users/Owner/Desktop/AIT 580/Assignments/olympics.csv")
summary(country_medals)

####  Qn 2 To find correlation among the columns #####
library(dplyr)
selected_data <- select(country_medals, "X2010.population","X2011.GDP","Female.count","Male.count","Gold.medals","Silver.medals","Bronze.medals")
#summary(selected_data)

pairs(selected_data)

#####
library("Hmisc")
rcorr(as.matrix(selected_data))

library(corrplot)
corrplot(selected_data, method = "number")



#---------------------------  Qn 1 - Relationship between country's medals and population ----------------------#


country_medals$medals <- country_medals$Gold.medals + country_medals$Silver.medals  + country_medals$Bronze.medals

cor(country_medals$X2010.population,country_medals$medals, method="pearson")

country_medals$X2010.population = as.numeric(country_medals$X2010.population)
typeof(country_medals$X2010.population)

radius <- sqrt(country_medals$medals / pi) #we want to size the points by the number of medals won
radius
typeof(radius)

symbols(x=country_medals$X2010.population,
        y=country_medals$medals,
        circles=radius,inches=0.2,
       xlim=c(100000,1500000000),
     #   ylim=c(15000000000000000,150000000000000),
        fg="white",bg="red",xlab="Population",ylab="medals") +
   text((country_medals$X2010.population),
       (country_medals$medals),
        country_medals$Country.name,cex=0.9) #no limit on population


plot(country_medals$X2010.population,country_medals$medals)
# -------------------  Qn 1 Part 2 ----------------------------#
country_medals$X2011.GDP = as.numeric(country_medals$X2011.GDP)
typeof(country_medals$X2011.GDP)

ratio(country_medals$Male.count,country_medals$Female.count)

country_medals %>%
  ggplot(aes(x=as.numeric(as.character(X2011.GDP)),y=medals)) +
  geom_point() +
  xlab("GDP per Capita") +
  ylab("Number of medals") +
  geom_smooth(method=lm)


country_medals %>%
  ggplot(aes(x=as.numeric(as.character(X2011.GDP)),y=ratio_mf)) +
  geom_point() +
  xlab("GDP per Capita") +
  ylab("Number of medals") +
  geom_smooth(method=loess)

country_medals$Female.count <-  as.numeric(country_medals$Female.count)
country_medals$Male.count <-  as.numeric(country_medals$Male.count)
country_medals$ratio_mf <- country_medals$Female.count/country_medals$Male.count

#cor(country_medals$ratio_mf,country_medals$X2011.GDP)
#plot(country_medals$ratio_mf,country_medals$X2011.GDP)

symbols(x=country_medals$ratio_mf,
        y=country_medals$X2011.GDP,
        circles=radius,inches=0.2,
      #  xlim=c(100,15000),
        #   ylim=c(15,15),
        fg="white",bg="red",xlab="Ratio",ylab="GDP") +
  text((country_medals$ratio_mf),
       (country_medals$X2011.GDP),
       country_medals$Country.name,cex=0.9)

corplot_var <- data.frame(country_medals$X2011.GDP,country_medals$ratio_mf)

#View(corplot_var)
#plot(corplot_var)
#library("PerformanceAnalytics")
#chart.Correlation(corplot_var)
pairs(corplot_var)

#library(scatterplot3d)
#library(sm)
#plot(country_medals$ratio_mf,country_medals$X2011.GDP)
#sm.density.compare(country_medals$ratio_mf,country_medals$X2011.GDP)
#heatmap
#---------------------------------------------------------------------------------------#
plot(country_medals$X2010.population,country_medals$medals, xlab="population", ylab="medals")
?plot

cor(country_medals$X2010.population,country_medals$medals, method = c("pearson", "kendall", "spearman"))

select_data <- c("X2010.population","X2011.GDP","Female.count","Male.count","Gold.medals","Silver.medals","Bronze.medals")
View(select_data)

pairs(selected_data)
plot(country_medals$X2010.population,country_medals$X2011.GDP)
pairs(country_medals$X2010.population~country_medals$medals)
library(corrgram)
corrgram(country_medals)
?corrgram



summary(country_medals$X2010.population, na.rm = TRUE)
fivenum(country_medals$X2011.GDP, na.rm = TRUE)
fivenum(country_medals$Female.count, na.rm = TRUE)
fivenum(country_medals$Male.count, na.rm = TRUE)
fivenum(country_medals$Gold.medals, na.rm = TRUE)
fivenum(country_medals$Silver.medals, na.rm = TRUE)
fivenum(country_medals$Bronze.medals, na.rm = TRUE)
fivenum(country_medals$medals, na.rm = TRUE)


#------------------- 6.5 ---------------------- #
source('C:/Users/Owner/Desktop/AIT 580/Assignments/hw.R')
#plot(country_medals$X2010.population,country_medals$X2011.GDP)

ggplot(faithful,aes(x=eruptions,y=waiting)) +
  geom_line(binwidth=2,
                 fill="white",color="black")+
  labs(x="Waiting Time Between Eruptions In Minutes",
       y="Counts",
       title="Old Faithful Geyser Eruptions")


# Pie Chart with Percentages
slices <- c(46,38,7,11,11)
lbls <- c("US", "China", "Japan", "Germany", "France")
pct <- round(slices/sum(slices)*100)
lbls <- paste(lbls, pct) # add percents to labels
lbls <- paste(lbls,"%",sep="") # ad % to labels
pie(slices,labels = lbls, col=rainbow(length(lbls)),
    main="Share of medals by countries sorted based on GDP")

matrix_iris <- data.matrix(Glass)
heatmap(matrix_iris)

library(ggplot2)
ggplot(data = country_medals, aes(x=country_medals$ratio_mf, fill=country_medals$medals)) +
  geom_tile()


ggplot(diamonds , aes( x = color) ) +
  geom_bar() +
  labs(x="Category",
       y="Count",
       title="Diamonds")

mine.heatmap <- ggplot(data = mine.long, mapping = aes(x = Sample.name,
                                                       y = Class,
                                                       fill = Abundance)) +
  geom_tile() +
  xlab(label = "Sample")

mine.heatmap

data(mtcars)
summary(mtcars)
library(expss)

mtcars = apply_labels(mtcars,
                      mpg = "Miles/(US) gallon",
                      cyl = "Number of cylinders",
                      disp = "Displacement (cu.in.)",
                      hp = "Gross horsepower",
                      drat = "Rear axle ratio",
                      wt = "Weight (1000 lbs)",
                      qsec = "1/4 mile time",
                      vs = "Engine",
                      vs = c("V-engine" = 0,
                             "Straight engine" = 1),
                      am = "Transmission",
                      am = c("Automatic" = 0,
                             "Manual"=1),
                      gear = "Number of forward gears",
                      carb = "Number of carburetors"
)
mtcars
mtcars_tab <- cro(mtcars$am, mtcars$vs)
cro_cpct(mtcars$cyl,mtcars$am)
mtcars %>%
  tab_cells(mpg, disp, hp, wt, qsec) %>%
  tab_cols(total(label = "#Total| |"), am) %>%
  tab_stat_fun(Mean = w_mean, "Std. dev." = w_sd, "Valid N" = w_n, method = list) %>%
  tab_pivot()
mtcars_tab <- table(mtcars$cyl,mtcars$am)
mtcars_tab
mosaicplot(mtcars_tab)

?cro_cpct
