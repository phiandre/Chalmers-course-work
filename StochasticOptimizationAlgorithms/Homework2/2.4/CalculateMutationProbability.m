function newMutationProbability = CalculateMutationProbability(population, populationSize, populationDiversityLimit, mutationProbabilityScalingFactor, minMutationProbability, maxMutationProbability, mutationProbability)
  
  
  populationDiversity = 0;
  
  for iPopulation = 1:populationSize - 1
    chromosome1 = population(iPopulation).Chromosome;
    for jPopulation = iPopulation+1:populationSize
      chromosome2 = population(jPopulation).Chromosome;
      numberOfInstructionsInChromosome1 = length(chromosome1);
      numberOfInstructionsInChromosome2 = length(chromosome2);
      
      smallestNumberOfInstructions = min(numberOfInstructionsInChromosome1, numberOfInstructionsInChromosome2);
      
      numberOfGenesNotEqual = 0;
      for iInstruction = 1:smallestNumberOfInstructions
        if (chromosome1(iInstruction) ~= chromosome2(iInstruction))
          numberOfGenesNotEqual = numberOfGenesNotEqual + 1;
        end
      end
      
      fractionOfGenesNotEqual = numberOfGenesNotEqual/smallestNumberOfInstructions;
      
      populationDiversity = populationDiversity + fractionOfGenesNotEqual;
    end
  end
  
  populationDiversity = populationDiversity/(populationSize*(populationSize-1)/2);
  
  if (populationDiversity < populationDiversityLimit)
    newMutationProbability = min(maxMutationProbability, mutationProbability*mutationProbabilityScalingFactor);
  else
    newMutationProbability = max(minMutationProbability, mutationProbability/mutationProbabilityScalingFactor);
  end
  
end
    
      
      