clear all; close all; clc;

[xTrain, tTrain, xValid, tValid, xTest, tTest] = LoadMNIST(3);

layers = Network1();

options = trainingOptions('sgdm', ...
            'InitialLearnRate', 0.01, 'MaxEpochs', 200, 'MiniBatchSize', 8192, 'Shuffle', 'every-epoch',...
            'ValidationData', {xValid, tValid}, 'ValidationFrequency', 30, 'ValidationPatience' , 5, ...
            'Plots', 'training-progress');
          

net = trainNetwork(xTrain, tTrain, layers, options);

save net;

YPredTrain = classify(net, xTrain);
YPredVal = classify(net, xValid);
YPredTest = classify(net, xTest);

trainingScore = sum(YPredTrain == tTrain)/numel(tTrain);
validationScore = sum(YPredVal == tValid)/numel(tValid);
testScore = sum(YPredTest == tTest)/numel(tTest);

disp(['Training accuracy: ', num2str(trainingScore)]);
disp(['Validation accuracy: ', num2str(validationScore)]);
disp(['Test accuracy: ', num2str(testScore)]);