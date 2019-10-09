function mutatedChromosome = Mutate(chromosome, mutationProbability)
  
  numberOfCities = length(chromosome);
  mutatedChromosome = chromosome;
  
  for iGene = 1:numberOfCities
    r = rand;
    if (r < mutationProbability)
      swapIndex = randi(numberOfCities); %It is possible for swapIndex == iGene.
      tmp = mutatedChromosome(iGene);
      mutatedChromosome(iGene) = mutatedChromosome(swapIndex);
      mutatedChromosome(swapIndex) = tmp;
    end
  end
  
end
      