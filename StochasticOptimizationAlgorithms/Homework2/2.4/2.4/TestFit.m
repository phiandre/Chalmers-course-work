clear all; close all; clc;
f = @(x) (x^3 - x^2 + 1)/(x^4 - x^2 + 1);

data = LoadFunctionData();
numberOfDataPoints = size(data, 1);
xRange = linspace(-5,5, numberOfDataPoints);
approximatedValues = zeros(numberOfDataPoints,1);
trueValues = data(:,2);

for i = 1:numberOfDataPoints
  approximatedValues(i) = f(xRange(i));
end

figure(1)
plot(xRange, approximatedValues)
title('Approximated function');
figure(2)
plot(xRange, trueValues)
title('True function');

disp(['Error: ', num2str(CalculateError(approximatedValues, trueValues))]);