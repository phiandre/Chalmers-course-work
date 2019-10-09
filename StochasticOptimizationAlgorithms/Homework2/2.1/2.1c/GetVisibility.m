function visibility = GetVisibility(cityLocation)
  numberOfCities = size(cityLocation,1);
  visibility = zeros(numberOfCities, numberOfCities);
  for iCurrentCity = 1:numberOfCities
    for iOtherCity = 1:numberOfCities
      xDistance = cityLocation(iOtherCity, 1) - cityLocation(iCurrentCity, 1);
      yDistance = cityLocation(iOtherCity, 2) - cityLocation(iCurrentCity, 2);
      
      distance = sqrt(xDistance.^2 + yDistance.^2);
      
      if(iOtherCity == iCurrentCity)
        visibility(iOtherCity, iCurrentCity) = 0;
      else
        visibility(iOtherCity, iCurrentCity) = 1/distance;
      end
    end
  end
end