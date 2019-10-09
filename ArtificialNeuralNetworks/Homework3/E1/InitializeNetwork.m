function [weights, thresholds] = InitializeNetwork(sizes)
  numberOfLayers = length(sizes) - 1;
  
  weights = {};
  thresholds = {};
  
  for iLayer = 1:numberOfLayers
    neuronsInFromLayer = sizes(iLayer);
    neuronsInToLayer = sizes(iLayer + 1);
    mean = 0;
    std = 1/sqrt(neuronsInFromLayer);
    weights{iLayer} = normrnd(mean, std, neuronsInToLayer, neuronsInFromLayer);
    thresholds{iLayer} = zeros(neuronsInToLayer,1);
    
  end
    
end