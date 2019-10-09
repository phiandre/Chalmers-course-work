setwd("C:/Users/Philip/Documents/R/MVE155/Bonus2")


#ill_data <- read.table("illinois.txt")

#perc <- ill_data[,1]
whales_data <- read.table("whales.txt")




whales <- whales_data[,1]
n <- length(whales)


tol <- 1e-7

alpha_neg2 <- 0.79536848
alpha_neg1 <- 2


#X_bar <- mean(perc)
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
