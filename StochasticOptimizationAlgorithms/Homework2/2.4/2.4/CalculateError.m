function error = CalculateError(approximatedValues, trueValues)
  numberOfValues = length(approximatedValues);
  error = sqrt((1./numberOfValues)*sum((approximatedValues - trueValues).^2));
end