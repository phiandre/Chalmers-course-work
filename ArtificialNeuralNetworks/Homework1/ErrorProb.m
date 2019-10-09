clear all; close all; clc;

amountOfPatterns = [12,20,40,60,80,100]; 
numberOfBits = 100; 
oneStepErrorProbability = []; %vector that will store the computed error probabilities
trials = 1e5;

for iPattern = 1:length(amountOfPatterns) 
    errorOccured = 0;
    for trial=1:trials
        numberOfPatterns = amountOfPatterns(iPattern);
        %Store patterns in network by using Hebb's rule
        storedPatterns = [];
        weightMatrix = 0;
        for i=1:numberOfPatterns
            pattern = 2*randi([0,1],100,1)-1;
            storedPatterns(:,i) = pattern;
            weightMatrix = weightMatrix + storedPatterns(:,i)*storedPatterns(:,i)';
        end
        weightMatrix = (1/numberOfBits)*weightMatrix;
        
        %Set diagonal weights to zero
%         for i=1:numberOfBits
%             weightMatrix(i,i) = 0;
%         end
%         
        %Randomly select one of the stored patterns
        randomIndex = randi(numberOfPatterns);
        randomlySelectedPattern = storedPatterns(:,randomIndex);
        
        %remainingPatterns = [storedPatterns(:,1:(randomIndex-1)) storedPatterns(:,(randomIndex+1):12)];
        
        updateIndex= randi(numberOfBits); %select a random neuron for asynchronous update
        
        b = weightMatrix(randomIndex,:)*randomlySelectedPattern; %local field for the randomly selected neuron
        updatedBit = sign(b);
        
%         C = -randomlySelectedPattern(randomIndex)*(1/N)...
%             *sum(remainingPatterns(randomIndex,:)*remainingPatterns'*randomlySelectedPattern);
%         if( C>1)
%             errorOccured = errorOccured + 1;
%         end
        
        %If the sign of the neuron differ before and after the update, an error has occured
        hasErrorOccured = updatedBit*randomlySelectedPattern(randomIndex) < 0; 
        if (hasErrorOccured)
            errorOccured = errorOccured + 1;
        end
        if( mod(trial,10000)==0)
            disp(['Trial: ', num2str(trial), ' Pattern: ', num2str(numberOfPatterns)]);
        end
    end
    oneStepErrorProbability(iPattern) = (errorOccured/trials)';
end





