function population = InitializePopulation(populationSize, numberOfHiddenNeurons)
  %Assuming 3 input terminals and 2 output neurons.
  numberOfFirstLayerParameters = 3*numberOfHiddenNeurons + numberOfHiddenNeurons;
  numberOfOutputLayerParameters = numberOfHiddenNeurons*2 + 2;
  chromosomeLength = numberOfFirstLayerParameters + numberOfOutputLayerParameters;
  
  population = zeros(populationSize, chromosomeLength);
  
  for iPopulation = 1:populationSize
    for iGene = 1:chromosomeLength
      population(iPopulation, iGene) = rand;
    end
  end
  
end