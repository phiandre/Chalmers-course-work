setwd("C:/Users/Philip/Documents/R/MVE155/Bonus2")

whales_data <- read.table("whales.txt")

whales <- whales_data[,1]

F <- function(x){
  return(n*log(x) - n*log(X_bar) + sum(log(sample_data))-n*digamma(x))
}



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
