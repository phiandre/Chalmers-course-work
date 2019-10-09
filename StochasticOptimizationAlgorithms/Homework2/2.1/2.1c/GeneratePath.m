function tabuList = GeneratePath(pheromoneLevel, visibility, alpha, beta)
  
  numberOfCities = size(pheromoneLevel, 1);
  tabuList = zeros(1, numberOfCities);
  
  startingCity = randi(numberOfCities);
  tabuList(1) = startingCity;
  numberOfCitiesVisited = 1;
  for iCity = 2:numberOfCities
    nextNode = GetNode(tabuList, pheromoneLevel, visibility, alpha, beta, numberOfCitiesVisited);
    tabuList(iCity) = nextNode;
    numberOfCitiesVisited = numberOfCitiesVisited + 1;
  end
  
end
    

  