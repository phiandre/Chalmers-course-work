possibleFunctions = [];
edges = 8;
map = 4;
cubeVector = zeros(1,edges);
foundPatterns = [];
placeOnes = randperm(edges,map);
runThisMany = 1000;

for iRun = 1:runThisMany
  for i = 1:map
    cubeVector(placeOnes(i)) = 1;
  end
end