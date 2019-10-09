function pathLength = GetPathLength(x, cities)
  xCoordinates = cities(x, 1);
  yCoordinates = cities(x, 2);
  
  numberOfCities = length(xCoordinates);
  pathLength = 0;
  for iCity = 1:(numberOfCities-1)
    xDistance = abs(xCoordinates(iCity + 1) - xCoordinates(iCity));
    yDistance = abs(yCoordinates(iCity + 1) - yCoordinates(iCity));
    
    pathLength = pathLength + sqrt(xDistance.^2 + yDistance.^2);
    
  end
  
  xDistanceFinal = abs(xCoordinates(numberOfCities) - xCoordinates(1));
  yDistanceFinal = abs(yCoordinates(numberOfCities) - yCoordinates(1));
  
  pathLength = pathLength + sqrt(xDistanceFinal.^2 + yDistanceFinal.^2);
end