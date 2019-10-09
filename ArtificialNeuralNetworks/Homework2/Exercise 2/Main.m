clear all; close all; clc;
inputData = csvread('input_data_numeric.csv');

MAXIMUM_NUMBER_OF_UPDATES = 1e5;

weights = 0.4*rand(1,4)-0.2;
threshold = 2*rand-1;
learningRate = 0.02;


%Uncomment the wanted target values
% a)
%target = [1, 1, 1, 1, 1, -1, -1, 1, 1, 1, -1, -1, 1, 1, -1, 1];

%b)
%target = [-1, -1, -1, 1, 1, -1, 1, 1, 1, 1, 1, -1, -1, 1, 1, 1]; 

%c)
%target = [-1, -1, -1, 1, 1, -1, -1, -1, -1, 1, 1, -1, -1, -1, 1, -1]; 

%d)
%target = [-1, -1, -1, 1, -1, -1, -1, 1, 1, 1, -1, 1, -1, -1, -1, 1];

%e)
%target = [1, 1, -1, -1, -1, 1, -1, 1, 1, 1, -1, -1, -1, 1, -1, 1]; 

% f)
target = [1, 1, -1, 1, -1, 1, 1, 1, -1, -1, -1, -1, -1, -1, -1, -1]; 



amountOfPatterns = length(target);

for iUpdate = 1:MAXIMUM_NUMBER_OF_UPDATES
  iPattern = randi(amountOfPatterns);
  pattern = inputData(iPattern, 2:end)';
  targetVal = target(iPattern);
  
  localField = (1/2)*(weights*pattern - threshold);
  output = tanh(localField);
  
  dw = (1/2)*learningRate*(targetVal - output)'*(1-(tanh(localField)).^2)*pattern;
  dt = -(1/2)*learningRate*(targetVal - output)'*(1-(tanh(localField)).^2);
  
  weights = weights + dw';
  threshold = threshold + dt';
  
  
  %Test if succeeded, done with the whole batch at once
  allPatterns = inputData(:,2:end)';
  batchOutput = tanh((1/2)*(weights*allPatterns - threshold));
  if (all(sign(batchOutput) == target))
    disp('Converged');
    break;
  end
end
disp('Finished');

    
  
  