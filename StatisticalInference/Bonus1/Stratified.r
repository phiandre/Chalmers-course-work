setwd("C:/Users/Philip/Documents/R/MVE155/Bonus1")

#READ DATA
cancer_data <- read.csv("cancer.csv")

#EXTRACT DATA TO VECTORS AND SORT BY POPULATION
mortality <- cancer_data[,1]
white_population <- cancer_data[,2]

#FORM 4 STRATA
N <- length(mortality)
n <- 6
W_l <- 1/4

stratum1 <- mortality[1:75]
stratum2 <- mortality[76:150]
stratum3 <- mortality[151:225]
stratum4 <- mortality[226:300]

#SAMPLE n OBSERVATIONS FROM EACH STRATUM
s1_samp_r <- sample(stratum1, size <- n, replace <- FALSE)
s2_samp_r <- sample(stratum2, size <- n, replace <- FALSE)
s3_samp_r <- sample(stratum3, size <- n, replace <- FALSE)
s4_samp_r <- sample(stratum4, size <- n, replace <- FALSE)

#OBTAINED SAMPLES FOR TASK l)
#s1_samp = c(9, 6, 12, 7, 14, 9)
#s2_samp = c(12, 28, 15, 18, 10, 23)
#s3_samp = c(24, 42, 26, 34, 66, 34)
#s4_samp = c(63, 63, 88, 360, 36, 79)

mean_est <- W_l*(mean(s1_samp_r) + mean(s2_samp_r) + mean(s3_samp_r) + mean(s4_samp_r))
total_est <- N*mean_est
print(mean_est)

#PROPORTIONAL ALLOCATION WHEN STRATIFIED SAMPLING
W_l <- 1/4 #Same proportion in all four stratas
n1_p <- round(W_l*n)
n2_p <- round(W_l*n)
n3_p <- round(W_l*n)
n4_p <- round(W_l*n)


s1_samp_p <- sample(stratum1, size <- n1_p, replace <- FALSE)
s2_samp_p <- sample(stratum2, size <- n2_p, replace <- FALSE)
s3_samp_p <- sample(stratum3, size <- n3_p, replace <- FALSE)
s4_samp_p <- sample(stratum4, size <- n4_p, replace <- FALSE)


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

tmp2 = 0.25*((mean(stratum1) - mean(mortality))^2 + (mean(stratum2) - mean(mortality))^2 +
               (mean(stratum3) - mean(mortality))^2 + (mean(stratum4) - mean(mortality))^2 )
sigma_square = tmp2 + sigma_square_bar

n1_o <- round(n*W_l*sigma_1_square/sigma_bar)
n2_o <- round(n*W_l*sigma_2_square/sigma_bar)
n3_o <- round(n*W_l*sigma_3_square/sigma_bar)
n4_o <- round(n*W_l*sigma_4_square/sigma_bar)

s1_samp_o <- sample(stratum1, size <- n1_o, replace <- FALSE)
s2_samp_o <- sample(stratum2, size <- n2_o, replace <- FALSE)
s3_samp_o <- sample(stratum3, size <- n3_o, replace <- FALSE)
s4_samp_o <- sample(stratum4, size <- n4_o, replace <- FALSE)

opt_var = 523.0781/n
prop_var = 1215.255/n
rand_var = 2593.686/n

print(opt_var)
print(prop_var)
print(rand_var)



