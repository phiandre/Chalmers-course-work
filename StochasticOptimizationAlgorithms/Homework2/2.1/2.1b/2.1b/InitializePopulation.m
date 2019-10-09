function population = InitializePopulation(populationSize, numberOfGenes)
  population = zeros(populationSize, numberOfGenes);
  for iPopulation = 1:populationSize
    population(iPopulation, :) = randperm(numberOfGenes);
  end

end