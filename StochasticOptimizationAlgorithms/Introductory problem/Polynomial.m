function f = Polynomial(x, coefficients)
  numberOfCoefficients = length(coefficients);
  f = 0; %If there are no coefficients in the list, the function value 0 is returned. 
  for iCoefficient = 1:numberOfCoefficients
    f = f + coefficients(iCoefficient)*x.^(iCoefficient-1);
  end
end
    