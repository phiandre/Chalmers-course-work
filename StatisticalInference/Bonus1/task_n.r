setwd("C:/Users/Philip/Documents/R/MVE155/Bonus1")

#READ DATA
cancer_data <- read.csv("cancer.csv")

#EXTRACT DATA TO VECTORS AND SORT BY POPULATION
mortality <- cancer_data[,1]
white_population <- cancer_data[,2]

#FORM L STRATA
N <- length(mortality)
L <- 4
n <- 6
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


print(sigma)
print(sigma_bar^2)
print(sigma_square_bar)
