function errors = Backpropagation(localFields, targets, weights, thresholds)
  errors = {};
  numberOfLayers = length(thresholds);
  
  outputLocalField = localFields{numberOfLayers};
  outputActivation = Sigmoid(outputLocalField);
  
  outputError = SigmoidDerivative(outputLocalField).*(targets - outputActivation);
  errors{numberOfLayers} = outputError;
  
  for iLayer = numberOfLayers:-1:2
    localField = localFields{iLayer-1};
    currentWeight = weights{iLayer};
    previousError = errors{iLayer};
    
    newError = currentWeight'*previousError.*SigmoidDerivative(localField);
    
    errors{iLayer - 1} = newError;
    
  end
  
end