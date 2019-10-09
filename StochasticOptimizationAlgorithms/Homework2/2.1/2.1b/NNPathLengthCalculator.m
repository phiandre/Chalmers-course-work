function pathLength = NNPathLengthCalculator
  cityLocation = LoadCityLocations();
  pathLength = GetNearestNeighbourPathLength(cityLocation);
end