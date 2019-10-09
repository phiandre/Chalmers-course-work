function f = EvaluateIndividual(approximatedValues, trueValues)
  f = 1./CalculateError(approximatedValues, trueValues);
end