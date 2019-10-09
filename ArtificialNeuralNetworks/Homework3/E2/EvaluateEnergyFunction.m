function energy = EvaluateEnergyFunction(outputs, targets)
  
  energy = (1/2) * sum(sum( (targets - outputs).^2));
end