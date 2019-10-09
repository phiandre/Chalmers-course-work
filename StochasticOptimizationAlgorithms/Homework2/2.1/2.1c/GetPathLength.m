function pathLength = GetPathLength(path, cityLocation)
  
  numberOfCities = length(path);
  pathLength = 0;
  
  for i = 1:(numberOfCities-1)
    toCity = path(i+1);
    fromCity = path(i);
    xDistance = cityLocation(toCity,1) - cityLocation(fromCity,1);
    yDistance = cityLocation(toCity,2) - cityLocation(fromCity,2);
    
    distance = sqrt(xDistance.^2 + yDistance.^2);
    
    pathLength = pathLength + distance;
  end
  
  lastCity = path(numberOfCities);
  firstCity = path(1);
  xFinalDistance = cityLocation(lastCity,1) - cityLocation(firstCity,1);
  yFinalDistance = cityLocation(lastCity,2) - cityLocation(firstCity,2);
  
  finalDistance = sqrt(xFinalDistance.^2 + yFinalDistance.^2);
  
  pathLength = pathLength + finalDistance;
  
end