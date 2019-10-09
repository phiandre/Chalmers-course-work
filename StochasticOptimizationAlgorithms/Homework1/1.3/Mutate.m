function mutatedChromosome = Mutate(chromosome, mutationProbability)

  numberOfGenes = size(chromosome,2);
  mutatedChromosome = chromosome;
  
  for iGenes = 1:numberOfGenes
    r = rand;
    if (r < mutationProbability)
      mutatedChromosome(iGenes) = 1 - chromosome(iGenes);
    end
  end
end