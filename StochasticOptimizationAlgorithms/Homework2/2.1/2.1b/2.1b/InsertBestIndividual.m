function population = InsertBestIndividual(population, bestIndividual, numberOfCopies)
  
  for iPopulation = 1:numberOfCopies
    population(iPopulation, :) = bestIndividual;
  end
end
  