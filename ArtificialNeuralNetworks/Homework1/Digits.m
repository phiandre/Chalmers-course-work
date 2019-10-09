clear all; close all; clc;

%Store image of zero
zeroRow1 = [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1];
zeroRow2 = [-1,-1,-1,1,1,1,1,-1,-1,-1];
zeroRow3 = [-1,-1,1,1,1,1,1,1,-1,-1];
zeroRow4 = [-1,1,1,1,-1,-1,1,1,1,-1];
storedZero = [zeroRow1, zeroRow2, zeroRow3, repmat(zeroRow4,1,10), zeroRow3, zeroRow2, zeroRow1]';
clear zeroRow1 zeroRow2 zeroRow3 zeroRow4;

%Store image of one
oneRow1 = [-1,-1,-1,1,1,1,1,-1,-1,-1];
storedOne = repmat(oneRow1,1,16)';
clear oneRow1;

%Store image of two
twoRow1 = [1,1,1,1,1,1,1,1,-1,-1];
twoRow2 = [-1,-1,-1,-1,-1,1,1,1,-1,-1];
twoRow3 = [1,1,1,-1,-1,-1,-1,-1,-1,-1];
storedTwo = [repmat(twoRow1, 1,2), repmat(twoRow2,1,5),...
    repmat(twoRow1,1,2), repmat(twoRow3,1,5), repmat(twoRow1,1,2)]';
clear twoRow1 twoRow2 twoRow3
        
%Store image of three
threeRow1 = [-1,-1,1,1,1,1,1,1,-1,-1];
threeRow2 = [-1,-1,1,1,1,1,1,1,1,-1];
threeRow3 = [-1,-1,-1,-1,-1,-1,1,1,1,-1];

storedThree = [threeRow1, threeRow2, repmat(threeRow3,1,5), repmat(threeRow1,1,2),...
                repmat(threeRow3,1,5), threeRow2, threeRow1]';
clear threeRow1 threeRow2 threeRow3

           
%Store image of four
fourRow1 = [-1,1,1,-1,-1,-1,-1,1,1,-1];
fourRow2 = [-1,1,1,1,1,1,1,1,1,-1];
fourRow3 = [-1,-1,-1,-1,-1,-1,-1,1,1,-1];

storedFour = [repmat(fourRow1,1,7), repmat(fourRow2,1,2), repmat(fourRow3,1,7)]';
clear fourRow1 fourRow2 fourRow3
      
numberOfBits = length(storedZero); %could have taken size of any stored pattern

%Create weight matrix, according to Hebb's rule
weightMatrix = (1/numberOfBits)*(storedZero*storedZero'+storedOne*storedOne'+storedTwo*storedTwo'+storedThree*storedThree'+ storedFour*storedFour');

%Set diagonal weights to zero
for i=1:numberOfBits
    weightMatrix(i,i) = 0;
end
clear i;

%%
%Feeding the first pattern 

feededPattern = [[-1, 1, -1, 1, -1, 1, -1, 1, 1, -1], [-1, 1, -1, 1, -1, 1, -1, 1, 1, -1],...
    [1, -1, 1, -1, 1, 1, -1, 1, 1, -1], [1, -1, 1, -1, 1, 1, -1, 1, 1, -1],...
    [1, -1, 1, -1, 1, 1, -1, 1, 1, -1], [1, -1, 1, -1, 1, 1, -1, 1, 1, -1],...
    [1, -1, 1, -1, 1, 1, -1, 1, 1, -1], [-1, 1, -1, 1, -1, 1, -1, 1, 1, -1],...
    [-1, 1, -1, 1, -1, 1, -1, 1, 1, -1], [-1, 1, -1, -1, 1, -1, 1, -1, 1, -1],... 
    [-1, 1, -1, -1, 1, -1, 1, -1, 1, -1], [-1, 1, -1, -1, 1, -1, 1, -1, 1, -1],... 
    [-1, 1, -1, -1, 1, -1, 1, -1, 1, -1], [-1, 1, -1, -1, 1, -1, 1, -1, 1, -1],...
    [-1, 1, -1, 1, -1, 1, -1, 1, 1, -1], [-1, 1, -1, 1, -1, 1, -1, 1, 1, -1]]';

  
isConverged = false;
iIteration = 0;
while(not(isConverged))
    oldNeuronStates = feededPattern; %used to check convergence
    iIteration = iIteration + 1;
    for i=1:numberOfBits %asynchronous update of every neuron according to typewriter scheme
      feededPattern(i) = sign(weightMatrix(i,:)*feededPattern);
      
      if (feededPattern(i) == 0) %we defined sign(0) = 1
        feededPattern(i) = 1;
      end
    end
    
    %algorith has converged if no neuron changed its state after N
    %asynchronous updates
    isConverged = all(oldNeuronStates-feededPattern == 0);
end


%%
% Feed the second pattern
feededPattern = [[1, 1, 1, -1, -1, 1, -1, -1, -1, -1], [-1, 1, 1, -1, -1, 1, -1, 1, 1, -1],... 
                 [1, -1, 1, -1, -1, -1, 1, 1, 1, 1], [1, -1, -1, -1, 1, 1, -1, 1, -1, 1],... 
                 [1, -1, -1, -1, 1, 1, -1, 1, 1, 1], [1, -1, 1, 1, 1, -1, -1, -1, -1, -1],... 
                 [1, -1, 1, -1, -1, -1, -1, -1, 1, -1], [1, -1, 1, 1, 1, 1, -1, 1, -1, 1],... 
                 [-1, -1, 1, 1, 1, -1, 1, -1, 1, -1], [1, -1, 1, 1, 1, -1, 1, -1, -1, 1],... 
                 [-1, 1, 1, 1, 1, 1, 1, 1, -1, -1], [-1, 1, -1, -1, -1, -1, -1, -1, 1, -1],... 
                 [-1, 1, -1, 1, -1, 1, -1, -1, 1, 1], [-1, 1, -1, 1, 1, -1, -1, 1, 1, 1],... 
                 [1, 1, -1, 1, 1, -1, 1, -1, 1, -1], [1, 1, -1, -1, -1, 1, -1, 1, 1, 1]]';

isConverged = false;
iIteration = 0;
while (not(isConverged))
  oldNeuronStates = feededPattern; %used to check convergence
  iIteration = iIteration + 1;
  for i=1:numberOfBits %asynchronous update of every neuron according to typewriter scheme
    feededPattern(i) = sign(weightMatrix(i,:)*feededPattern);
    
    if (feededPattern(i) == 0) %we define sign(0) = 1
      feededPattern(i) = 1;
    end
  end
  
  isConverged = all(oldNeuronStates - feededPattern == 0);
  
end
imagesc(vec2mat(feededPattern,10));

%%
%Feed pattern 3

feededPattern = [[-1, 1, 1, -1, -1, -1, -1, 1, 1, -1], [-1, 1, 1, -1, -1, -1, -1, 1, 1, -1],...
                 [-1, 1, 1, -1, -1, -1, -1, 1, 1, -1], [-1, 1, 1, -1, -1, -1, -1, 1, 1, -1],...
                 [-1, 1, 1, -1, -1, -1, -1, 1, 1, -1], [-1, 1, 1, -1, -1, -1, -1, 1, 1, -1],...
                 [-1, 1, 1, -1, -1, -1, -1, 1, 1, -1], [-1, 1, 1, 1, 1, 1, 1, 1, 1, -1],...
                 [-1, 1, 1, 1, 1, 1, 1, 1, 1, -1], [-1, -1, -1, -1, -1, -1, -1, 1, 1, -1],...
                 [-1, -1, -1, -1, -1, -1, -1, 1, 1, -1], [-1, -1, -1, -1, -1, -1, -1, 1, 1, -1],...
                 [-1, -1, -1, -1, -1, -1, -1, 1, 1, -1], [-1, -1, -1, -1, -1, -1, -1, 1, 1, -1],...
                 [-1, -1, -1, -1, -1, -1, -1, 1, 1, -1], [1, 1, 1, 1, 1, 1, 1, -1, -1, 1]]';

               
isConverged = false;
iIteration = 0;
while (not(isConverged))
    oldNeuronStates = feededPattern; %used to check convergence
    iIteration = iIteration + 1;
    for i=1:numberOfBits
        feededPattern(i) = sign(weightMatrix(i,:)*feededPattern);
        
        if (feededPattern(i) == 0) %we defined sign(0) = 1
          feededPattern(i) = 1;
    end
    
    isConverged = all(oldNeuronStates - feededPattern == 0);
end
imagesc(vec2mat(newNeuronState,10));

