setwd("C:/Users/Philip/Documents/R/MVE155/Bonus3")
library(ggplot2)

data <- read.table("fruitfly.txt", header = TRUE, sep = ",")

group1 <- data[1:25,]
group2 <- data[26:50,]
group3 <- data[51:75,]
group4 <- data[76:100,]
group5 <- data[101:125,]


par(mar = c(5,4,1,1) + 1)

p <- ggplot() + geom_point(data = group1, aes(x=lifespan, y = thorax), color = 'red') +
  geom_point(data = group2, aes(x = lifespan, y = thorax), color = 'blue') +
  geom_point(data = group3, aes(x = lifespan, y = thorax), color = 'green')+
  geom_point(data = group4, aes(x = lifespan ,y = thorax), color = 'black' )+
  geom_point(data = group5, aes(x = lifespan, y = thorax), color = 'orange')

p + labs(x = "Lifespan in days", y = "Thorax length in mm") + theme(axis.text = element_text(size = 16),
                                                                    axis.title = element_text(size = 20))