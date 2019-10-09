function population = InsertBestIndividual(population, bestIndividual, nCopies)
  
  for iPopulation = 1:nCopies
    population(iPopulation).Chromosome = bestIndividual;
  end
end