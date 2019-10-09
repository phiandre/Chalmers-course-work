function mutatedChromosome = Mutate(chromosome, mutationProbability)
  
  chromosomeLength = length(chromosome);
  mutatedChromosome = chromosome;
  creepRate = 0.1;
  for iGene = 1:chromosomeLength
    r = rand;
    if (r < mutationProbability)
      %q = rand;
      mutatedChromosome(iGene) = rand;
      %mutatedChromosome(iGene) = mutatedChromosome(iGene) - creepRate/2 + creepRate*q;
    end
  end
end
      