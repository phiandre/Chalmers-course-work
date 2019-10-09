setwd("C:/Users/Philip/Documents/R/MVE155/Bonus2")

whales_data <- read.table("whales.txt")


whales <- whales_data[,1]

n <- length(whales) 

#PARAMETERS TO IMPROVE QUALITY OF PLOT
plot_size <- 1.5
par(mar = c(4,5,1,1) + 1)

hist(whales,
     breaks = seq(0,5,l=50),
     xlab = "Swim velocity",
     ylab = "Counts",
     main = "Histogram plot of whales data",
     cex.axis = plot_size,
     cex.lab = plot_size,
     cex.main = plot_size
     )



#COMPUTE MME
sample_mean <- mean(whales)
sample_variance <- var(whales)

MME_lambda <- sample_mean/sample_variance
MME_alpha <- sample_mean^2 / sample_variance


#PLOT ON TOP OF HISTOGRAM

par(new = TRUE)

qa <- seq(0.05,4,length=10000)
gamma_d <- (1/gamma(MME_alpha))*MME_lambda^(MME_alpha)*qa^(MME_alpha-1) * exp(-MME_lambda*qa)
plot(qa, gamma_d, xlab="", ylab="", main="", xaxt="n", yaxt="n")

#COMPUTE THE MAXIMUM LIKELIHOOD ESTIMATES

tol <- 1e-7

alpha_neg2 <- 0.79536848 #MME 
alpha_neg1 <- 2 #ARBITRARILY CHOSEN

X_bar <- mean(whales)

alpha <- 0
nIter <- 0
while(abs(alpha_neg2-alpha) > tol){
  fn_neg1 <- n*log(alpha_neg1) - n*log(X_bar) + sum(log(whales))-n*digamma(alpha_neg1)
  fn_neg2 <- n*log(alpha_neg2) - n*log(X_bar) + sum(log(whales))-n*digamma(alpha_neg2)
  alpha <- alpha_neg1 - fn_neg1 * (alpha_neg1 - alpha_neg2)/(fn_neg1 - fn_neg2)
  
  alpha_neg2 <- alpha_neg1
  alpha_neg1 <- alpha
  nIter <- nIter + 1
}

MLE_alpha <- alpha
MLE_lambda <- alpha/X_bar

#PLOT ON TOP OF HISTOGRAM
par(new = TRUE)

qa <- seq(0.001,4,length=10000)
gamma_d <- (1/gamma(MLE_alpha))*MLE_lambda^(MLE_alpha)*qa^(MLE_alpha-1) * exp(-MLE_lambda*qa)
plot(qa, gamma_d, xlab="", ylab="", main="", xaxt="n", yaxt="n")


#BOOTSTRAP FOR MME

NUM_SIMULATIONS = 1000
n <- length(whales)

simulatedAlphas <- integer(NUM_SIMULATIONS)
simulatedLambdas <- integer(NUM_SIMULATIONS)

for(i in 1:NUM_SIMULATIONS){
  alpha <- 0.7953685
  lambda <- 1.312491
  sample_data <- rgamma(n, shape = alpha, rate = lambda)
  tol <- 1e-7
  
  
  X_bar <- mean(sample_data)
  
  
  lambda <- X_bar/var(sample_data)
  alpha <- X_bar^2 / var(sample_data)
  
  
  simulatedAlphas[i] <- alpha
  simulatedLambdas[i] <- lambda
  
}

var_alpha = sum( (simulatedAlphas - mean(simulatedAlphas))^2 ) / (NUM_SIMULATIONS - 1)
std_alpha = sqrt(var_alpha)

var_lambda = sum( (simulatedLambdas - mean(simulatedLambdas))^2) / (NUM_SIMULATIONS - 1)
std_lambda = sqrt(var_lambda)

hist(simulatedAlphas,
     breaks = seq(0,1.5,l=25),
     xlab = "Alpha value",
     ylab = "Counts",
     main = "Simulated alpha values",
     cex.axis = plot_size,
     cex.lab = plot_size
)


#BOOTSTRAP FOR MLE

F <- function(x){
  return(n*log(x) - n*log(X_bar) + sum(log(sample_data))-n*digamma(x))
}



NUM_SIMULATIONS = 1000
n <- length(whales)

simulatedAlphas <- integer(NUM_SIMULATIONS)
simulatedLambdas <- integer(NUM_SIMULATIONS)

for(i in 1:NUM_SIMULATIONS){
  alpha <- 1.5954086
  lambda <- 2.6326916
  
  
  sample_data <- rgamma(n, shape = alpha, rate = lambda)
  tol <- 1e-7
  alpha_neg2 <- 1.5954086
  alpha_neg1 <- 2
  
  
  X_bar <- mean(sample_data)
  
  alpha <- 0
  nIter <- 0
  while(abs(alpha_neg2-alpha) > tol){
    fn_neg1 <- F(alpha_neg1)
    fn_neg2 <- F(alpha_neg2)
    alpha <- alpha_neg1 - fn_neg1 * (alpha_neg1 - alpha_neg2)/(fn_neg1 - fn_neg2)
    
    alpha_neg2 <- alpha_neg1
    alpha_neg1 <- alpha
    nIter <- nIter + 1
  }
  
  simulatedAlphas[i] <- alpha
  simulatedLambdas[i] <- alpha/X_bar
  
}


var_alpha = sum( (simulatedAlphas - mean(simulatedAlphas))^2 ) / (NUM_SIMULATIONS - 1)
std_alpha = sqrt(var_alpha)

var_lambda = sum( (simulatedLambdas - mean(simulatedLambdas))^2) / (NUM_SIMULATIONS - 1)
std_lambda = sqrt(var_lambda)

hist(simulatedLambdas,
     breaks = seq(1.5,4,l=25),
     xlab = "Lambda values",
     ylab = "Counts",
     main = "Simulated lambda values",
     cex.axis = plot_size,
     cex.lab = plot_size,
     cex.main = plot_size
)

