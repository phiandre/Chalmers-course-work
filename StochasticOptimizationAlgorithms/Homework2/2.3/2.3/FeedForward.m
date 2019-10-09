function [gear, pedalPressure] = FeedForward(weights, thresholds, input)

  hiddenLayerLocalFields =  weights{1}*input - thresholds{1};
  hiddenLayerActivations = Sigmoid(hiddenLayerLocalFields);
  
  outputLayerLocalFields = weights{2}*hiddenLayerActivations - thresholds{2};
  outputLayerActivations = Sigmoid(outputLayerLocalFields);
  
  tmpGearChange = outputLayerActivations(1);
  
  if (tmpGearChange < 0.3)
    gear = -1;
  elseif (tmpGearChange > 0.7)
    gear = 1;
  else
    gear = 0;
  end
  
  pedalPressure = outputLayerActivations(2);
end