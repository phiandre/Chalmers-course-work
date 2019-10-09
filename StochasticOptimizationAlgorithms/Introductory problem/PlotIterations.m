function PlotIterations(polynomialCoefficients, iterationValues)
  %Make a plot of the function
  xMinRange = min(iterationValues) - 0.1*min(iterationValues);
  xMaxRange = max(iterationValues) + 0.1*max(iterationValues);
  resolution = 0.01;
  plottingRange = xMinRange:resolution:xMaxRange;
  functionValues = Polynomial(plottingRange, polynomialCoefficients);
  plot(plottingRange, functionValues, 'LineWidth', 1.5);
  hold on;
  
  %Explicity mark the values computed by the Newton-Raphson method
  plot(iterationValues, Polynomial(iterationValues, polynomialCoefficients), 'ko', 'MarkerSize', 10, 'LineWidth', 1.5);
  yMinRange = min(functionValues) - max(0.1*min(functionValues),1);
  yMaxRange = max(functionValues) + max(0.1*max(functionValues),1);
  axis([xMinRange xMaxRange yMinRange yMaxRange]);
end