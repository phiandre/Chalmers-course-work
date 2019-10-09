setwd("C:/Users/Philip/Documents/R/MVE155/Bonus1")

#READ DATA
cancer_data <- read.csv("cancer.csv")

#EXTRACT DATA TO VECTORS
mortality <- cancer_data[,1]
population <- cancer_data[,2]
N <- length(mortality)

#PARAMETERS TO IMPROVE QUALITY OF PLOT
plot_size <- 2
par(mar <- c(5,4,4,1) + 1)

#MAKE A HISTOGRAM PLOT
hist(mortality,
     breaks <- 50,
     main <- "Histogram of cancer mortality",
     xlab <- 'Population mortality',
     ylab <- 'Count',
     xlim <- c(0,max(mortality)),
     ylim <- c(0,80),
     cex.axis <- plot_size,
     cex.main <- plot_size,
     cex.lab <- plot_size,
     )



#CALCULATE POPULATION PARAMETERS
mean_mortality <- mean(mortality)
total_mortality <- mean_mortality*N

variance_mortality <- var(mortality)*(N-1)/N #RESCALE, SINCE WE HAVE THE WHOLE POPULATION AND NOT A SAMPLE
std_mortality <- sqrt(variance_mortality)



#SIMULATE THE SAMPLING DISTRIUBTION OF THE MEAN
n <- 25
NUMBER_OF_RUNS <- 20000
simulated_mean <- integer(NUMBER_OF_RUNS)
for(i in 1:NUMBER_OF_RUNS){
  random_sample <- sample(mortality, size = n, replace = FALSE) #SAMPLE WITHOUT REPLACEMENT
  estimated_mean <- mean(random_sample)
  simulated_mean[i] <- estimated_mean
}


#PLOT THE SIMULATED MEAN
hist(simulated_mean,
     breaks <- 25,
     main <- "Simulated mean value (n=25)",
     xlab <- "Mean number of mortalities",
     ylab <- "Count",
     xlim <- c(0,max(simulated_mean)+20),
     ylim <- c(0,NUMBER_OF_RUNS/5),
     cex.axis <- plot_size,
     cex.main <- plot_size,
     cex.lab <- plot_size)


#DRAW ONE RANDOM SAMPLE AND ESTIMATE POPULATION PARAMETERS
n <- 25 #REPLACE WITH 100 FOR TASK g)
random_sample <- sample(mortality, size <- n, replace <- FALSE)

estimated_mean <- mean(random_sample)
estimated_total <- estimated_mean*N
estimated_variance <- var(random_sample)
estimated_mean_variance <- (estimated_variance / n)*(1-n/N)
estimated_std <- sqrt(estimated_mean_variance)

#MAKE A 95% CONFIDENCE INTERVAL
lower_bound <- estimated_mean - qnorm(0.975)*estimated_std
upper_bound <- estimated_mean + qnorm(0.975)*estimated_std






