clear all; close all; clc;

[xTrain, tTrain, xValid, tValid, xTest, tTest] = LoadMNIST(1);

xTrainMean = 0;

for i = 1:size(xTrain,2)
  xTrainMean = xTrainMean + xTrain(:,i);
end

xTrainMean = xTrainMean./(size(xTrain,2));

xTrain = xTrain - xTrainMean;
xValid = xValid - xTrainMean;
xTest = xTest - xTrainMean;



networkSizes = [784, 30, 30, 30, 30, 10];

numberOfLayers = length(networkSizes) - 1;
numberOfEpochs = 50;
numberOfTrainingInputs = size(xTrain, 2);

learningRate = 3e-3;
miniBatchSize = 10;

learningSpeed = zeros(numberOfEpochs, numberOfLayers);
trainingError = zeros(numberOfEpochs,1);
outputEnergyValues = zeros(numberOfEpochs, 1);

[weights, thresholds] = InitializeNetwork(networkSizes);

for iEpoch = 1:numberOfEpochs
  newOrdering = randperm(numberOfTrainingInputs);
  xTrain = xTrain(:, newOrdering');
  tTrain = tTrain(:, newOrdering');
  
  
%   validationDataError = Validate(weights, thresholds, xValid, tValid);
  trainingDataError = Validate(weights, thresholds, xTrain, tTrain);
  
  trainingError(iEpoch) = trainingDataError;
%   validationError(iEpoch) = validationDataError;
%   
%   if (validationDataError < lowestValidationError)
%     lowestValidationError = validationDataError;
%     disp('New lowest validation found!');
%     save weights_4.mat weights;
%     save thresholds_4.mat thresholds;
%   end
  
  disp(['Epoch: ', num2str(iEpoch), ' Error on training data: ', num2str(trainingDataError) ]);
  for iMiniBatch = 1:miniBatchSize:numberOfTrainingInputs
    miniBatch = xTrain(:, iMiniBatch:iMiniBatch + (miniBatchSize - 1));
    targets = tTrain(:, iMiniBatch:iMiniBatch + (miniBatchSize - 1)); 
    totalWeightUpdate = weights;
    totalThresholdUpdate = thresholds;
    for iBatch = 1:miniBatchSize
      pattern = miniBatch(:, iBatch);
      target = targets(:, iBatch);
      [localFields, activations] = FeedForward(pattern, weights, thresholds);
      errors = Backpropagation(localFields, target, weights, thresholds);
      for iLayer = 1:numberOfLayers
        totalWeightUpdate{iLayer} = totalWeightUpdate{iLayer} + learningRate*errors{iLayer}*activations{iLayer}';
        totalThresholdUpdate{iLayer} = totalThresholdUpdate{iLayer} - learningRate*sum(errors{iLayer},2);
      end  
%     [localFields, activations] = FeedForward(miniBatch, weights, thresholds);
%     errors = Backpropagation(localFields, targets, weights, thresholds);
    %[weights, thresholds] = Update(learningRate, activations, errors, weights, thresholds);
    end
    weights = totalWeightUpdate;
    thresholds = totalThresholdUpdate;
  end
  [errLocalFields, errActivations] = FeedForward(xTrain, weights, thresholds);
  errErrors = Backpropagation(errLocalFields, tTrain, weights, thresholds);
  for k = 1:5
    e = norm(sum(errErrors{k}, 2));
    learningSpeed(iEpoch, k) = e;
  end
  
  outputs = errActivations{end};
  outputEnergy = EvaluateEnergyFunction(outputs, tTrain);
  outputEnergyValues(iEpoch) = outputEnergy;
  
end

csvwrite('speed.csv', learningSpeed);
csvwrite('energy.csv', outputEnergyValues);

%%
xRange = 1:numberOfEpochs;
figure(1);
plot(xRange, outputEnergyValues, 'LineWidth', 2);
ax = gca;
ax.FontSize = 24;
title('Energy function', 'FontSize', 30);
xlabel('Epoch', 'FontSize', 30);
ylabel('Energy value', 'FontSize', 30);

figure(2);
for i=1:5
  semilogy(xRange, learningSpeed(:,i), 'LineWidth', 2);
  hold on;
end
ax = gca;
ax.FontSize = 24;
title('Learning speed in different layers', 'FontSize', 30);
xlabel('Epoch', 'FontSize', 30);
ylabel('Learning speed', 'FontSize', 30);
legend({'Layer 1', 'Layer 2', 'Layer 3', 'Layer 4', 'Layer 5'}, 'FontSize', 24);
