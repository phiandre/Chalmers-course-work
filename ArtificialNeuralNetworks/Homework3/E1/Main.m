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

learningRate = 3*1e-3;
miniBatchSize = 10;

learningSpeed = zeros(numberOfEpochs, numberOfLayers);
trainingError = zeros(numberOfEpochs,1);
validationError = zeros(numberOfEpochs,1);

lowestValidationError = inf;
[weights, thresholds] = InitializeNetwork(networkSizes);

for iEpoch = 1:numberOfEpochs
  newOrdering = randperm(numberOfTrainingInputs);
  xTrain = xTrain(:, newOrdering');
  tTrain = tTrain(:, newOrdering');
  
  
  validationDataError = Validate(weights, thresholds, xValid, tValid);
  trainingDataError = Validate(weights, thresholds, xTrain, tTrain);
  
  trainingError(iEpoch) = trainingDataError;
  validationError(iEpoch) = validationDataError;
  
  if (validationDataError < lowestValidationError)
    lowestValidationError = validationDataError;
    disp('New lowest validation found!');
    save weights_speed.mat weights;
    save thresholds_speed.mat thresholds;
  end
  
  disp(['Epoch: ', num2str(iEpoch), ' Error on validation data: ', num2str(validationDataError) ]);
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
  
end
csvwrite('speed.csv', learningSpeed);

%%
xRange = 1:50;
figure(1)
for k = 1:5
  semilogy(xRange, learningSpeed(:,k));
  hold on;
end
%%
clear weights thresholds

load weights_speed.mat
load thresholds_speed.mat

testError = Validate(weights, thresholds, xTest, tTest);
valError = Validate(weights, thresholds, xValid, tValid);
trainError = Validate(weights, thresholds, xTrain, tTrain);
ep = find(validationError == min(validationError));
disp(['Early-stopping epoch: ', num2str(ep(1))]);
disp(['Training error: ', num2str(trainError)]);
disp(['Validation error: ', num2str(valError)]);
disp(['Test error: ', num2str(testError)]);

csvwrite('network4_train.csv', trainingError);
csvwrite('network4_validation.csv', validationError);

%%
close all;
xRange = 1:30;
firstNetworkTrain = csvread('network1_train.csv');
secondNetworkTrain = csvread('network2_train.csv');
thirdNetworkTrain = csvread('network3_train.csv');
fourthNetworkTrain = csvread('network4_train.csv');

firstNetworkValid = csvread('network1_validation.csv');
secondNetworkValid = csvread('network2_validation.csv');
thirdNetworkValid = csvread('network3_validation.csv');
fourthNetworkValid = csvread('network4_validation.csv');


%%
close all;
xRange = 1:30;

figure(1);
semilogy(xRange, firstNetworkTrain, 'LineWidth', 3);
hold on;
semilogy(xRange, firstNetworkValid, '--', 'LineWidth', 3);
semilogy(xRange, secondNetworkTrain, 'LineWidth', 3);
semilogy(xRange, secondNetworkValid, '--', 'LineWidth', 3);
semilogy(xRange, thirdNetworkTrain, 'LineWidth', 3);
semilogy(xRange, thirdNetworkValid, '--', 'LineWidth', 3);
semilogy(xRange, fourthNetworkTrain, 'LineWidth', 3);
semilogy(xRange, fourthNetworkValid, '--', 'LineWidth', 3);
ax = gca;
ax.FontSize = 24;
axis([0 30 1e-4 1e0]);

legend({'Train (network 1)', 'Validation (network 1)', ...
  'Train (network 2)', 'Validation (network 2)', ...
  'Train (network 3)', 'Validation (network 3)', ...
  'Train (network 4)', 'Validation (network 4)'}, 'FontSize', 20);