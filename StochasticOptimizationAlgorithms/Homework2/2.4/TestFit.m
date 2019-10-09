clc;
f = @(x) (x^3 - x^2 + 1)/(x^4 - x^2 + 1);

xRange = linspace(-5,5, 201);
approximatedValues = zeros(201,1);
trueValues = data(:,2);

for i = 1:201
  approximatedValues(i) = f(xRange(i));
end

figure(1)
plot(xRange, approximatedValues)
title('Approximated function');
figure(2)
plot(xRange, trueValues)
title('True function');

disp(['Error: ', num2str(CalculateError(approximatedValues, trueValues))]);