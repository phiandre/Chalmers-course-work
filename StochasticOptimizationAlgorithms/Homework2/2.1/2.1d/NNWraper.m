
totalNNPathLength = 0;
numberOfRuns = 10000;

for iRun = 1:numberOfRuns
  totalNNPathLength = totalNNPathLength + NNPathLengthCalculator;
end

meanNNPathLength = totalNNPathLength/numberOfRuns;

disp(['Mean path length: ', num2str(meanNNPathLength)]);