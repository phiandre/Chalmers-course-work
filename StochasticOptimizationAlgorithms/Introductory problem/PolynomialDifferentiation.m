function derivativeCoefficients = PolynomialDifferentiation(coefficients, derivativeOrder)
  derivativeCoefficients = [];
  isAcceptedDerivativeOrder = derivativeOrder < 3;
  numberOfCoefficients = length(coefficients);
    
  if (isAcceptedDerivativeOrder)
    first = derivativeOrder+1; %First element in coefficients that will appear in derivativeCoefficients
    for iCoefficient = first:numberOfCoefficients
      derivativeFactor = prod((iCoefficient-1):-1:iCoefficient-derivativeOrder); %Compute n*(n-1)*...*(n-k+1) 
      derivativeCoefficient = coefficients(iCoefficient)*derivativeFactor; 
      insertionIndex = iCoefficient-derivativeOrder; 
      derivativeCoefficients(insertionIndex) = derivativeCoefficient;
    end
  end
end
        
        