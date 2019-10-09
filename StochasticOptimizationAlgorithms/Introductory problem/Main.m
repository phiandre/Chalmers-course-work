polynomialCoefficients = [10 -2 -1 1]; %Defines the polynomial 10 - 2x - x^2 + x^3.
startingPoint = 2;
tolerance = 0.0001;
iterationValues = NewtonRaphson(polynomialCoefficients, startingPoint, tolerance);
if (length(iterationValues) > 0) 
  PlotIterations(polynomialCoefficients, iterationValues);
end