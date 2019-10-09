function fitnessValue = EvaluateIndividual(approximatedValues, trueValues)
  fitnessValue = 1./CalculateError(approximatedValues, trueValues);
end