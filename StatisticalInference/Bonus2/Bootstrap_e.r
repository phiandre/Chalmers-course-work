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
