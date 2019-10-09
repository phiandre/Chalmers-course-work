function deltaPheromoneLevel = ComputeDeltaPheromoneLevels(pathCollection,pathLengthCollection)
  numberOfAnts = size(pathCollection, 1);
  numberOfCities = size(pathCollection, 2);
  deltaPheromoneLevel = zeros(numberOfCities, numberOfCities);
  
  for iAnt = 1:numberOfAnts
    pathTravelled = pathCollection(iAnt, :);
    tourLength = pathLengthCollection(iAnt);
    for iPath = 1:(numberOfCities-1)
      index1 = pathTravelled(iPath);
      index2 = pathTravelled(iPath+1);
      deltaPheromoneLevel(index1, index2) = deltaPheromoneLevel(index1, index2) + 1./tourLength;
    end
    firstCity = pathTravelled(1);
    lastCity = pathTravelled(end);
    deltaPheromoneLevel(lastCity, firstCity) = deltaPheromoneLevel(lastCity, firstCity) + 1./tourLength;
  end
end