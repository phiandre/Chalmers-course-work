function layers = Network1()
  inputLayer = imageInputLayer([28 28 1]);
  convLayer1 = convolution2dLayer(5, 20, 'Padding', 1, 'Stride', 1);
  ReLULayerConv = reluLayer;
  maxPool1 = maxPooling2dLayer(2, 'Padding', 0, 'Stride', 2);
  fullyConnectedLayer1 = fullyConnectedLayer(100);
  ReLULayer1 = reluLayer;
  fullyConnectedLayer2 = fullyConnectedLayer(10);
  softMax = softmaxLayer;
  class = classificationLayer;

  layers = [inputLayer, convLayer1, ReLULayerConv, maxPool1, fullyConnectedLayer1, ReLULayer1, ...
          fullyConnectedLayer2, softMax, class];

end