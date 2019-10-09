function tempPopulation = InsertBestIndividual(population, bestIndividual, numberOfCopies)
  
  tempPopulation = population;
  for i = 1:numberOfCopies
    tempPopulation(i, :) = bestIndividual;
  end
end