  function mutatedChromosome = Mutate(chromosome, mutationProbability, ranges)
  
  nGenes = length(chromosome);
  mutatedChromosome = chromosome;
  
  for iGene = 1:4:nGenes
    r = rand;
    if (r < mutationProbability)
%       encodedType = mod(iGene, 4); 
%       
%       if (encodedType == 0)
%         tmpIndex = encodedType:4:nGenes;
%         allowedIndex = tmpIndex(2:end);
%       else
%         allowedIndex = encodedType:4:nGenes;
%       end
%       
%       swapIndex = randsample(allowedIndex, 1);
%       
%       tmp = mutatedChromosome(swapIndex);
%       mutatedChromosome(swapIndex) = mutatedChromosome(iGene);
%       mutatedChromosome(iGene) = tmp;

        mutatedChromosome(iGene) = randi(ranges(1));
        mutatedChromosome(iGene+1) = randi(ranges(2));
        mutatedChromosome(iGene+2) = randi(ranges(3));
        mutatedChromosome(iGene+3) = randi(ranges(4));
      
    end
  end
  
end
      