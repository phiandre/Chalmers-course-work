function population = InitializePopulation(populationSize, minChromosomeSize, maxChromosomeSize, instructions, destinationRegisters, operands) 

  population = [];
  
  for iPopulation = 1:populationSize
    chromosomeLength = minChromosomeSize + fix(rand*(maxChromosomeSize - minChromosomeSize + 1));
    tmpChromosome = zeros(chromosomeLength,1);
    for iGene = 1:4:chromosomeLength
      instruction = randi(instructions); %{1=+, 2=-, 3=*, 4=/}
      destinationRegisterIndex = randi(destinationRegisters); 
      operand1 = randi(operands);
      operand2 = randi(operands);
      tmpChromosome(iGene) = instruction;
      tmpChromosome(iGene+1) = destinationRegisterIndex;
      tmpChromosome(iGene+2) = operand1;
      tmpChromosome(iGene+3) = operand2;
    end
    tmpIndividual = struct('Chromosome', tmpChromosome);
    population = [population tmpIndividual];
  end

end
      
      
  