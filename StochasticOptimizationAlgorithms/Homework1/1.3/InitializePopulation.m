function population = InitializePopulation(populationSize, numberOfGenes)
  population = zeros(populationSize, numberOfGenes);
  for iPopulation = 1:populationSize
    for jGenes = 1:numberOfGenes
      s = rand;
      if (s < 0.5)
        population(iPopulation, jGenes) = 0;
      else
        population(iPopulation, jGenes) = 1;
      end
    end
  end
  
end