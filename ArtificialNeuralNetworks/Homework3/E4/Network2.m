function layers = Network2()
  inputLayer = imageInputLayer([28 28 1]);
  convLayer1 = convolution2dLayer(3, 20, 'Padding', 1, 'Stride', 1);
  bN1 = batchNormalizationLayer;
  ReLULayerConv1 = reluLayer;
  maxPool1 = maxPooling2dLayer(2, 'Padding', 0, 'Stride', 2);
  convLayer2 = convolution2dLayer(3, 30, 'Padding', 1, 'Stride', 1);
  bN2 = batchNormalizationLayer;
  ReLULayerConv2 = reluLayer;
  maxPool2 = maxPooling2dLayer(2, 'Padding', 0, 'Stride', 2);
  convLayer3 = convolution2dLayer(3, 50, 'Padding', 1, 'Stride', 1);
  bN3 = batchNormalizationLayer;
  ReLULayerConv3 = reluLayer;
  fullyConnectedLayer1 = fullyConnectedLayer(10);
  softMax = softmaxLayer;
  class = classificationLayer;

  layers = [inputLayer, convLayer1, bN1, ReLULayerConv1, maxPool1, convLayer2, bN2, ReLULayerConv2, ...
          maxPool2, convLayer3, bN3, ReLULayerConv3, fullyConnectedLayer1, softMax, class];
end