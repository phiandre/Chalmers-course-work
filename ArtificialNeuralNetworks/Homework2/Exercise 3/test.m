validationSet = csvread('validation_set.csv');
validationInputs = validationSet(:,1:2);
validationTargets = validationSet(:,3);
sizeOfValidation = size(validationSet, 1);
w1 = csvread('w1.csv');
w2 = csvread('w2.csv');
w3 = csvread('w3.csv');

t1 = csvread('t1.csv');
t2 = csvread('t2.csv');
t3 = csvread('t3.csv');

valb1 = -t1 + w1*validationInputs';
valV1 = tanh(valb1);

valb2 = -t2 + w2*valV1;
valV2 = tanh(valb2);

valb3 = -t3 + w3*valV2;

valO = tanh(valb3);

C = (1/(2*sizeOfValidation))*sum(abs(sign(valO) - validationTargets'));