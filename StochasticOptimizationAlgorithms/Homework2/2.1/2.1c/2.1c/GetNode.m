function node = GetNode(tabuList, pheromoneLevel, visibility, alpha, beta, numberOfCitiesVisited)
  numberOfCities = size(visibility, 1);
  previousCity = tabuList(numberOfCitiesVisited);
  
  probabilities = zeros(1, numberOfCities);
  cities = 1:numberOfCities;
  
  cumulativeProbability = 0;
  
  for iCity =  1:numberOfCities
    isNotVisited = ~ismember(iCity, tabuList);
    if (isNotVisited)
      currentPhermone = pheromoneLevel(iCity, previousCity);
      currentVisibility = visibility(iCity, previousCity);
      probability = currentPhermone.^(alpha) * currentVisibility.^(beta);
      probabilities(iCity) =  probability;
      cumulativeProbability = cumulativeProbability + probability;
    else
      probabilities(iCity) = 0;
    end
    
  end
  
  probabilities = probabilities./cumulativeProbability;
  
  node = randsample(cities, 1, true, probabilities);
  
end