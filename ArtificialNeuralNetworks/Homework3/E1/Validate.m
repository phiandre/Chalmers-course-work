function validationError = Validate(weights, thresholds, data, targets)
  numberOfLayers = length(thresholds);
  numberOfValidationInputs = size(data, 2);
  
  [x, validationActivations]= FeedForward(data, weights, thresholds);
  outputValidation = validationActivations{numberOfLayers + 1};
  C = 0;
  for i = 1:size(outputValidation,2)
    [firingNeuron, index] = max(outputValidation(:,i));
    
    C = C + (1-targets(index,i));
  end
  C = C*(1/(numberOfValidationInputs));
  
  validationError = C;
end