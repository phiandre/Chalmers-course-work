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
     breaks = 50,
     main = "Histogram of cancer mortality",
     xlab = 'Population mortality',
     ylab = 'Count',
     xlim = c(0,max(mortality)),
     ylim = c(0,80),
     cex.axis = plot_size,
     cex.main = plot_size,
     cex.lab = plot_size,
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
     breaks = 25,
     main = "Simulated mean value (n=25)",
     xlab = "Mean number of mortalities",
     ylab = "Count",
     xlim = c(0,max(simulated_mean)+20),
     ylim = c(0,NUMBER_OF_RUNS/5),
     cex.axis = plot_size,
     cex.main = plot_size,
     cex.lab = plot_size)


#DRAW ONE RANDOM SAMPLE AND ESTIMATE POPULATION PARAMETERS
n <- 300 #REPLACE WITH 100 FOR TASK g)
random_sample <- sample(mortality, size <- n, replace <- FALSE)

estimated_mean <- mean(random_sample)
estimated_total <- estimated_mean*N
estimated_variance <- var(random_sample)
estimated_mean_variance <- (estimated_variance / n)*(1-n/N)
estimated_std <- sqrt(estimated_mean_variance)

#MAKE A 95% CONFIDENCE INTERVAL
lower_bound <- estimated_mean - qnorm(0.975)*estimated_std
upper_bound <- estimated_mean + qnorm(0.975)*estimated_std

#FORM 4 STRATA
N <- length(mortality)
n <- 24
n_l <- 24/4
W_l <- 1/4

stratum1 <- mortality[1:75]
stratum2 <- mortality[76:150]
stratum3 <- mortality[151:225]
stratum4 <- mortality[226:300]

#SAMPLE n OBSERVATIONS FROM EACH STRATUM
s1_samp_r <- sample(stratum1, size <- n_l, replace <- FALSE)
s2_samp_r <- sample(stratum2, size <- n_l, replace <- FALSE)
s3_samp_r <- sample(stratum3, size <- n_l, replace <- FALSE)
s4_samp_r <- sample(stratum4, size <- n_l, replace <- FALSE)

#PROPORTIONAL ALLOCATION WHEN STRATIFIED SAMPLING
W_l <- 1/4 #Same proportion in all four stratas

#MULTIPLY BY n AND ROUND TO GET THE NUMBER OF SAMPLES FOR EACH STRATUM
n1_p <- W_l
n2_p <- W_l
n3_p <- W_l
n4_p <- W_l


#OPTIMAL ALLOCATION WHEN STRATIFIED SAMPLING
N1 <- length(stratum1)
sigma_1_square <- (N1-1)/N1 * var(stratum1)
N2 <- length(stratum2)
sigma_2_square <- (N2-1)/N2 * var(stratum2)
N3 <- length(stratum3)
sigma_3_square <- (N3-1)/N3 * var(stratum3)
N4 <- length(stratum4)
sigma_4_square <- (N4-1)/N4 * var(stratum4)

sigma_bar <- W_l*(sqrt(sigma_1_square) + sqrt(sigma_2_square) + sqrt(sigma_3_square) + sqrt(sigma_4_square))
sigma_square_bar <- W_l*(sigma_1_square + sigma_2_square + sigma_3_square + sigma_4_square) 

#MULTIPLY BY n AND ROUND TO GET THE NUMBER OF SAMPLES FOR EACH STRATUM
n1_o <- W_l*sqrt(sigma_1_square)/sigma_bar
n2_o <- W_l*sqrt(sigma_2_square)/sigma_bar
n3_o <- W_l*sqrt(sigma_3_square)/sigma_bar
n4_o <- W_l*sqrt(sigma_4_square)/sigma_bar


#FORM L STRATA
N <- length(mortality)
L <- 4 #REPLACE WITH THE AMOUNT OF STRATA DESIRED
N_l <- N/L
N_tmp <- round(N_l)*L

weights <- integer(L)
numberOfStratas <- integer(L)

"
If the elements can not be evenly distributed over the L strata the following policy is used:

If the desired amount of elements in each stratum N_tmp yields in too many elements, the elements in
the strata corresponding to smallest population sizes will be reduced by 1 each until the total number
of elements sum to N. 

If instead, N_tmp yields too few elements, the elements in the strata corresponding to largest population
sizes will be increased by 1 each until the total number of elements sum to N.
"
remainder <- max(N,N_tmp) %% min(N,N_tmp) 

if(remainder == 0){
  for(i in 1:L){
    val <- round(N_l)
    numberOfStratas[i] <- val
    weights[i] <- val/N
  }
} else {
  if(N < N_tmp){ #ADD IN THE END
    
    for(i in 1:remainder){
      val <- round(N_l) - 1
      numberOfStratas[i] <- val
      weights[i] <- val/N
    }
    for(j in (remainder+1):L){
      val <- round(N_l)
      numberOfStratas[j] <- val
      weights[j] <- val/N
    }
  }  else { #REDUCE IN THE BEGINNING
    for(i in 1:(L-remainder)){
      val <- round(N_l)
      numberOfStratas[i] <- val
      weights[i] <- val/N
    }
    for(j in (L-remainder + 1):L){
      val <- round(N_l) + 1
      numberOfStratas[j] <- val
      weights[j] <- val/N
    }
  } 
}


variances <- integer(L)
i <- 0
for(i in 1:L){
  startIndex <- sum(numberOfStratas[1:i]) - numberOfStratas[i] + 1
  endIndex <- sum(numberOfStratas[1:i])
  strat <- mortality[startIndex:endIndex]
  stratLength <- numberOfStratas[i]
  variances[i] <- var(strat)*(stratLength-1)/stratLength 
}

sigma <- var(mortality)*(N-1)/N
sigma_bar <- 0
sigma_square_bar <-  0
i <- 0
for(i in 1:L){
  sigma_bar <-  sigma_bar + weights[i]*sqrt(variances[i])
  sigma_square_bar <- sigma_square_bar + weights[i]*variances[i]
}