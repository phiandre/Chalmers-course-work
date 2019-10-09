clear all; close all; clc;

trainingSet = csvread('training_set.csv');
trainingInputs = trainingSet(:,1:2);
trainingTargets = trainingSet(:,3);

validationSet = csvread('validation_set.csv');
validationInputs = validationSet(:,1:2);
validationTargets = validationSet(:,3);


M1 = 13;
M2 = 7;
learningRate = 0.01;
numberOfInputUnits = size(trainingInputs, 2);
numberOfPatterns = size(trainingInputs, 1);
sizeOfValidation = size(validationSet, 1);

weights1 = 2*rand(M1, numberOfInputUnits)-1;
weights2 = 2*rand(M2, M1)-1;
weights3 = 2*rand(1, M2)-1;

threshold1 = 2*rand(M1,1)-1;
threshold2 = 2*rand(M2,1)-1;
threshold3 = 2*rand-1;


keepIterating = true;
iIter = 0;
Cost = [];
while (keepIterating)
  
  randomIndex = randi(numberOfPatterns);
  pattern = trainingInputs(randomIndex, :)';
  target = trainingTargets(randomIndex, :);

  b1 = -threshold1 + weights1*pattern;
  V1 = tanh(b1);

  b2 = -threshold2 + weights2*V1;
  V2 = tanh(b2);

  b3 = -threshold3 + weights3*V2;
  O = tanh(b3);
  delta3 = (1-(tanh(b3)).^2).*(target - O);
  delta2 = (weights3'*delta3).*(1-(tanh(b2)).^2);
  delta1 = (weights2'*delta2).*(1-(tanh(b1)).^2);

  dw1 = learningRate*delta1*pattern';
  dw2 = learningRate*delta2*V1';
  dw3 = learningRate*delta3*V2';

  dt1 = -learningRate*delta1;
  dt2 = -learningRate*delta2;
  dt3 = -learningRate*delta3;

  weights1 = weights1 + dw1;
  weights2 = weights2 + dw2;
  weights3 = weights3 + dw3;

  threshold1 = threshold1 + dt1;
  threshold2 = threshold2 + dt2;
  threshold3 = threshold3 + dt3;
  
  
  
  
  if (mod(iIter, 100) == 0)
    C = 0;
    valb1 = -threshold1 + weights1*validationInputs';
    valV1 = tanh(valb1);
    
    valb2 = -threshold2 + weights2*valV1;
    valV2 = tanh(valb2);
    
    valb3 = -threshold3 + weights3*valV2;
    
    valO = tanh(valb3);
    
    C = (1/(2*sizeOfValidation))*sum(abs(sign(valO) - validationTargets'));
    
    
    
    keepIterating = C > 0.11; %Would suffice with > 0.12, but this is even better.
     
  end
  
  iIter = iIter + 1;
  
end
csvwrite('w1.csv', weights1);
csvwrite('w2.csv', weights2);
csvwrite('w3.csv', weights3);
csvwrite('t1.csv', threshold1);
csvwrite('t2.csv', threshold2);
csvwrite('t3.csv', threshold3);
