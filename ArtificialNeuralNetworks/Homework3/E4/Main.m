clear all; close all; clc;

[xTrain, tTrain, xValid, tValid, xTest, tTest] = LoadMNIST(3);

layers = Network2();

options = trainingOptions('sgdm', ...
            'InitialLearnRate', 0.01, 'MaxEpochs', 30, 'MiniBatchSize', 8192, 'Shuffle', 'every-epoch',...
            'ValidationData', {xValid, tValid}, 'ValidationFrequency', 30, 'ValidationPatience' , 5, ...
            'Plots', 'training-progress');
          

net2 = trainNetwork(xTrain, tTrain, layers, options);

save net2;

YPredTrain = classify(net2, xTrain);
YPredVal = classify(net2, xValid);
YPredTest = classify(net2, xTest);

trainingScore = sum(YPredTrain == tTrain)/numel(tTrain);
validationScore = sum(YPredVal == tValid)/numel(tValid);
testScore = sum(YPredTest == tTest)/numel(tTest);

disp(['Training accuracy: ', num2str(trainingScore)]);
disp(['Validation accuracy: ', num2str(validationScore)]);
disp(['Test accuracy: ', num2str(testScore)]);