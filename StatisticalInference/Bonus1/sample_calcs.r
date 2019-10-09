#CALCULATIONS
bb = c(28, 250, 31, 37, 33, 37, 12, 142, 72, 6, 46, 16, 10, 127, 6, 55, 63, 38, 5, 20, 6, 20, 105, 48, 53)

mean_est = mean(bb)

vvv = 0
n = length(bb)
for(i in 1:n){
  vvv = vvv + 1/(n-1) * (bb[i]-mean_est)^2  
}
print(vvv)
estimated_variance = var(bb)
print(mean_est)
print(estimated_variance)