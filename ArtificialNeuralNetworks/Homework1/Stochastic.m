clear all; close all; clc;
beta = 2;
g=@(b)1./(1+exp(-2*beta*b));

numberOfPatterns = 40;
numberOfBits = 200;
trials = 1e5;
sumOfOrderParameters = 0;
runThisMany = 100;

neuronsAtEachTimeStep = zeros(numberOfBits,trials);

for iRepeat=1:runThisMany
    storedPatterns = [];
    weightMatrix = 0;
    for i=1:numberOfPatterns
      storedPatterns(:,i) = 2*randi([0,1],[200,1])-1;
      weightMatrix = weightMatrix + storedPatterns(:,i)*storedPatterns(:,i)';
    end
    weightMatrix = (1/numberOfBits)*weightMatrix;
    
    %set diagonal elements in weight matrix to zero
    for i=1:numberOfBits
      weightMatrix(i,i) =0;
    end

    feededPattern = storedPatterns(:,1);
    
    for i=1:trials
      iRandom = randi(200);
      b = weightMatrix(iRandom,:)*feededPattern;
      newState = randsample([1,-1],1,true,[g(b) 1-g(b)]); %stochastic update rule
      feededPattern(iRandom) = newState;
      neuronsAtEachTimeStep(:,i) = feededPattern;
      
      if (mod(i,10000) == 0)
        disp(['runThisMany: ', num2str(iRepeat), ' T: ', num2str(i)]);
      end
    end
    
    nonNormalizedSum = 0;
    for t = 1:trials
      
      for i = 1:numberOfBits
        nonNormalizedSum = nonNormalizedSum + (1/numberOfBits)*neuronsAtEachTimeStep(i,t)*storedPatterns(i,1);
      end
    end
    m1 = (1/trials)*nonNormalizedSum;
    sumOfOrderParameters = sumOfOrderParameters + m1;
end

averageOrderParameter = sumOfOrderParameters/runThisMany;
