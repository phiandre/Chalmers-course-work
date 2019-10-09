function l = GetNearestNeighbourPathLength(cityLocation)
  startNode = randi(size(cityLocation, 1));
  l = 0;
  first = cityLocation(startNode, :);
  while (size(cityLocation,1) > 1)
    startCity = cityLocation(startNode, :);
    cityLocation(startNode, :) = [];
    d2 = (cityLocation(:,1) - startCity(1)).^2 + (cityLocation(:,2) - startCity(2)).^2;
    d = sqrt(d2);
    l = l + min(d);
    startNode = find(d == min(d));
  end
  
  last = cityLocation(startNode,:);
  
  lastDistance = sqrt( (last(1)-first(1)).^2 + (last(2) - first(2)).^2);
  
  l = l + lastDistance;
end