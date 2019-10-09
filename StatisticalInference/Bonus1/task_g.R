setwd("C:/Users/Philip/Documents/R/MVE155/Bonus1")

#READ DATA
cancer_data = read.csv("cancer.csv")

#EXTRACT DATA TO VECTORS
mortality = cancer_data[,1]
white_population = cancer_data[,2]
N = length(mortality)

#DRAW ONE RANDOM SAMPLE AND ESTIMATE POPULATION PARAMETERS
n = 100

#random_sample = sample(mortality, size = n, replace = FALSE)
#write.csv(random_sample, "sampled_data.csv")

read_data = read.csv("sampled_data.csv")
random_sample = read_data[,2]
print(random_sample)

estimated_mean = mean(random_sample)
estimated_total = estimated_mean*length(mortality)
estimated_variance = var(random_sample)
estimated_mean_variance = (estimated_variance / n)*(1-n/N)
estimated_std = sqrt(estimated_mean_variance)

print(estimated_mean)
print(estimated_std)