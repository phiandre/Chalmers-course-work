setwd("C:/Users/Philip/Documents/R/MVE155/Bonus3")
library(e1071)
library(moments)

data <- read.table("fruitfly.txt", header = TRUE, sep = ",")

group1 <- data[1:25,]
group2 <- data[26:50,]
group3 <- data[51:75,]
group4 <- data[76:100,]
group5 <- data[101:125,]

group1_ls <- group1$lifespan
group2_ls <- group2$lifespan
group3_ls <- group3$lifespan
group4_ls <- group4$lifespan
group5_ls <- group5$lifespan

means_ls <- c(mean(group1_ls), mean(group2_ls), mean(group3_ls), mean(group4_ls), mean(group5_ls))
variance_ls <- c(var(group1_ls), var(group2_ls), var(group3_ls), var(group4_ls), var(group5_ls))


lifespan_data <- data.frame(
  treatment_1 = group1_ls,
  treatment_2 = group2_ls,
  treatment_3 = group3_ls,
  treatment_4 = group4_ls,
  treatment_5 = group5_ls
)

group1_sleep <- group1$sleep
group2_sleep <- group2$sleep
group3_sleep <- group3$sleep
group4_sleep <- group4$sleep
group5_sleep <- group5$sleep


sleep_data <- data.frame(
  treatment_1 = data[1:25,]$sleep,
  treatment_2 = data[26:50,]$sleep,
  treatment_3 = data[51:75,]$sleep,
  treatment_4 = data[76:100,]$sleep,
  treatment_5 = data[101:125,]$sleep
)
plot_size <- 1.5
par(mar = c(5,4,1,1) + 1)
boxplot(lifespan_data, 
        ylab = "Lifespan",
        main = "Boxplot of lifespan data",
        las = 2,
        names = c("Group 1", "Group 2", "Group 3", "Group 4", "Group 5"),
        cex.axis = plot_size,
        cex.lab = plot_size)


means_sleep <- c(mean(group1_sleep), mean(group2_sleep), mean(group3_sleep), mean(group4_sleep),
                 mean(group5_sleep))

var_sleep <- c(var(group1_sleep), var(group2_sleep), var(group3_sleep), var(group4_sleep),
                 var(group5_sleep))

boxplot(sleep_data,
        ylab = "Percentage of time sleeping",
        main = "Boxplot of sleep data",
        las = 2,
        names = c("Group 1", "Group 2", "Group 3", "Group 4", "Group 5"),
        cex.axis = plot_size,
        cex.lab = plot_size,
        cex.main = plot_size)


lifespans <- data$lifespan
thorax <- data$thorax

g1_t <- thorax[1:25]
g2_t <- thorax[26:50]
g3_t <- thorax[51:75]
g4_t <- thorax[76:100]
g5_t <- thorax[101:125]

thorax_means <- c(mean(g1_t), mean(g2_t), mean(g3_t), mean(g4_t), mean(g5_t))
thorax_variances <- c(var(g1_t), var(g2_t), var(g3_t), var(g4_t), var(g5_t))
ymin <- 0.4
ymax <- 1

plot(lifespans[1:25], thorax[1:25], xlab = "Life span", ylab = "Thorax length", ylim = c(ymin, ymax), col = "red")
par(new = TRUE)
plot(lifespans[26:50], thorax[26:50], xlab = "", ylab = "", ylim = c(ymin, ymax), xaxt="n", yaxt="n", col = "blue")
par(new = TRUE)
plot(lifespans[51:75], thorax[51:75], xlab = "", ylab = "", ylim = c(ymin, ymax), xaxt="n", yaxt="n", col = "green")
par(new = TRUE)
plot(lifespans[76:100], thorax[76:100], xlab = "", ylab = "", ylim = c(ymin, ymax), xaxt="n", yaxt="n", col = "black")
par(new = TRUE)
plot(lifespans[101:125], thorax[101:125], xlab = "", ylab = "", ylim = c(ymin, ymax), xaxt="n", yaxt="n", col = "yellow")


#TASK D LONGETIVITY, USE ONE-WAY ANOVA
variances <- c(var(lifespan_data$treatment_1), var(lifespan_data$treatment_2), var(lifespan_data$treatment_3),
               var(lifespan_data$treatment_4), var(lifespan_data$treatment_5))

means <- c(mean(lifespan_data$treatment_1), mean(lifespan_data$treatment_2), mean(lifespan_data$treatment_3),
            mean(lifespan_data$treatment_4), mean(lifespan_data$treatment_5))

numberOfPairs <- choose(5,2)
differences <- integer(numberOfPairs)

iPair <- 1
for(i in 1:4){
  for(j in (i+1):5){
    differences[iPair] <- abs(means[i] - means[j])
    iPair <- iPair + 1
  }
}

SS_T <- var(lifespans)*124 #(J*I - 1)*var(combined data)
SS_E <- sum(variances*24) #sum of (J-1)*var(group)
SS_A <- SS_T - SS_E



df_A <- 4 #(I-1)
df_E <- 120 #I*(J-1)


MS_A <- SS_A/df_A
MS_E <- SS_E/df_E
F <- MS_A/MS_E

p_val <- 1 - pf(F, df_A, df_E)

#BONFERRONI
df <- 120

s_p <- sqrt(MS_E)
t_dis <- qt(1-0.025/numberOfPairs, df)

bonferroni <- s_p*t_dis*sqrt(2/25)

#TUKEY
sr_dis <- qtukey(1-0.05, 5, 120)
tukey <- sr_dis*s_p*sqrt(1/25)

#KRUSKAL-WALLIS

F <- function(dataFrame){
  numberOfColumns <- ncol(dataFrame)
  numberOfRows <- nrow(dataFrame)
  tmp <- c()
  for(iCol in 1:numberOfColumns){
    tmp <- c(tmp, dataFrame[,iCol])
  }
  ranks <- rank(tmp, ties = "first")
  return(ranks)
}

ranked_lifespans <- F(lifespan_data)

ranked_lifespans_matrix <- matrix(ranked_lifespans, nrow = 25, ncol = 5)

ranked_lifespan_data <- data.frame(
  group1 = ranked_lifespans[1:25],
  group2 = ranked_lifespans[26:50],
  group3 = ranked_lifespans[51:75],
  group4 = ranked_lifespans[76:100],
  group5 = ranked_lifespans[101:125]
)

ranked_means <- c(mean(ranked_lifespan_data$group1),
                  mean(ranked_lifespan_data$group2),
                  mean(ranked_lifespan_data$group3),
                  mean(ranked_lifespan_data$group4),
                  mean(ranked_lifespan_data$group5))

total_ranked_mean <- mean(ranked_means)
W <- 12*25/(125*126) * sum( (ranked_means - total_ranked_mean)^2 )

p_value_KW <- 1 -pchisq(W, 4)


ranked_differences <- integer(numberOfPairs)
iPair <- 1
for(i in 1:4){
  for(j in (i+1):5){
    ranked_differences[iPair] <- abs(ranked_means[i] - ranked_means[j])
    iPair <- iPair + 1
  }
}

SS_A_ranked <- 25*sum( (ranked_means - total_ranked_mean)^2 )
SS_E_ranked <-0
SS_tot_ranked <- 0
i <- 0
j <- 0
for(i in 1:5){
  for(j in 1:25){
    SS_E_ranked <- SS_E_ranked + (ranked_lifespans_matrix[j,i] - ranked_means[i])^2
    SS_tot_ranked <- SS_tot_ranked + (ranked_lifespans_matrix[j,i] - total_ranked_mean)^2 
  }
}

s_p_ranked <- sqrt(SS_E_ranked/120)



bonferroni_ranked <- qt(1-0.05/numberOfPairs, 120)*s_p_ranked*sqrt(2/25)


#AFFECTION ON SLEEP
sleep <- data$sleep


sleep_variances <- c(var(sleep_data$treatment_1), var(sleep_data$treatment_2), var(sleep_data$treatment_3),
               var(sleep_data$treatment_4), var(sleep_data$treatment_5))

sleep_means <- c(mean(sleep_data$treatment_1), mean(sleep_data$treatment_2), mean(sleep_data$treatment_3),
           mean(sleep_data$treatment_4), mean(sleep_data$treatment_5))

numberOfPairs <- choose(5,2)
sleep_differences <- integer(numberOfPairs)

iPair <- 1
for(i in 1:4){
  for(j in (i+1):5){
    sleep_differences[iPair] <- abs(sleep_means[i] - sleep_means[j])
    iPair <- iPair + 1
  }
}



ranked_sleep <- F(sleep_data)

ranked_sleep_matrix <- matrix(ranked_sleep, nrow = 25, ncol = 5)

ranked_sleep_data <- data.frame(
  group1 = ranked_sleep[1:25],
  group2 = ranked_sleep[26:50],
  group3 = ranked_sleep[51:75],
  group4 = ranked_sleep[76:100],
  group5 = ranked_sleep[101:125]
)

ranked_sleep_means <- c(mean(ranked_sleep_data$group1),
                  mean(ranked_sleep_data$group2),
                  mean(ranked_sleep_data$group3),
                  mean(ranked_sleep_data$group4),
                  mean(ranked_sleep_data$group5))

total_ranked_sleep_mean <- mean(ranked_sleep_means)
W_rank <- 12*25/(125*126) * sum( (ranked_sleep_means - total_ranked_sleep_mean)^2 )

p_value_KW_rank <- 1 -pchisq(W_rank, 4)

