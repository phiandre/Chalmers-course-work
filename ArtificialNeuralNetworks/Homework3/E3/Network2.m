function layers = Network2()
  inputLayer = imageInputLayer([28 28 1]);
  fullyConnectedLayer1 = fullyConnectedLayer(100);
  ReLULayer1 = reluLayer;
  fullyConnectedLayer2 = fullyConnectedLayer(100);
  ReLULayer2 = reluLayer;
  fullyConnectedLayer3 = fullyConnectedLayer(100);
  ReLULayer3 = reluLayer;
  fullyConnectedLayer4 = fullyConnectedLayer(10);
  softMax = softmaxLayer;
  class = classificationLayer;

  layers = [inputLayer, fullyConnectedLayer1, ReLULayer1, ...
          fullyConnectedLayer2, ReLULayer2, fullyConnectedLayer3,...
          ReLULayer3, fullyConnectedLayer4, softMax, class];

end