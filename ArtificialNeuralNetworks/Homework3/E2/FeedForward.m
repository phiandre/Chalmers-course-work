function [localFields, activations] = FeedForward(pattern, weights, thresholds)
  localFields = {};
  activations = {};
  numberOfLayers = length(thresholds);
  V = pattern;
  
  activations{1} = V;
  for iLayer = 1:numberOfLayers
    localFields{iLayer} = weights{iLayer}*V - thresholds{iLayer};
    V = Sigmoid(localFields{iLayer});
    activations{iLayer + 1} = V;
  end
end