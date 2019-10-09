function pathLength = GetNearestNeighbourPathLength(cityLocation)
  startNodeIndex = randi(size(cityLocation, 1));
  pathLength = 0;
  firstCityVisited = cityLocation(startNodeIndex, :);
  while (size(cityLocation, 1) > 1)
    startCity = cityLocation(startNodeIndex, :);
    cityLocation(startNodeIndex, :) = [];
    squaredDistances = (cityLocation(:,1) - startCity(1)).^2 + (cityLocation(:,2) - startCity(2)).^2;
    distances = sqrt(squaredDistances);
    pathLength = pathLength + min(distances);
    startNodeIndex = find( distances == min(distances) );
  end
  
  lastCityVisited = cityLocation(startNodeIndex, :);
  
  lastDistance = sqrt( (lastCityVisited(1)-firstCityVisited(1)).^2 + ...
                       (lastCityVisited(2) - firstCityVisited(2)).^2);
  
  pathLength = pathLength + lastDistance;
end