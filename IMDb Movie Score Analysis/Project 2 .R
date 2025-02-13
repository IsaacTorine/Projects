setwd("~/Downloads")
movies<-read.csv("Project2_IMDb_data (1).csv")
#1:Histogram 
hist(movies$score,
     main= "Frequency of Scores",
     xlab= "Scores", 
     ylab= "Number of Movies",
     col= "Red")
#2: Table 
mean(movies$score)
median(movies$score)
table(movies$score)
summary(movies$score)
sd(movies$score)
IQR(movies$score)

#3 : Scatterplot 
plot(movies$score,movies$gross_in_millions, 
     main="Gross Revenue per Score",
     xlab= "Score",
     ylab="Gross Revenue (in millions)", 
     xlim=c(0,10), 
     ylim=c(0,1000), 
     col= "orange")
cor(movies$score, movies$gross_in_millions,use = "complete.obs")
#line of best fit 
myLine<- lm(movies$score~ movies$gross_in_millions)
abline(myLine)     
#4: Score and movie genre 
bargraph<-aggregate(movies$score~ movies$genre,FUN=mean)
bargraph
#5: score and release month
diffgraph<-aggregate(movies$score~movies$month,FUN=mean) 
diffgraph
#6: Another visualization 
graph<- aggregate(movies$score~ movies$director,FUN=max)
graph

