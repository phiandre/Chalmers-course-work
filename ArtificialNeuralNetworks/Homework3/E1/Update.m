function [weights, thresholds] = Update(learningRate, activations, errors, weights, thresholds)
  numberOfLayers = length(thresholds);
  
  for iLayer = 1:numberOfLayers
    weights{iLayer} = weights{iLayer} + learningRate*errors{iLayer}*activations{iLayer}';
    thresholds{iLayer} = thresholds{iLayer} - learningRate*sum(errors{iLayer},2);
  end
end