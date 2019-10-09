clear all; close all; 

%Set parameters
populationSize = 50;
numberOfHiddenNeurons = 7;
numberOfGenerations = 5000;
tournamentSelectionProbability = 0.8;
tournamentSize = 5;
crossoverProbability = 0.7;
startVariableRange = 5;
fullVariableRange = 10;
mutationProbability = 0.03;

population = InitializePopulation(populationSize, numberOfHiddenNeurons);
fitness = zeros(populationSize, 1);

trainingMaximumOverall = 0.0;
validationMaximumOverall = 0.0;
bestIndex = 0;
bestChromosome = 0;

maxFitnessInGenerationTrain = zeros(numberOfGenerations, 1);
maxFitnessInGenerationValidation = zeros(numberOfGenerations, 1);


for iGeneration = 1:numberOfGenerations
  disp(['Generation: ', num2str(iGeneration), ' Maximum fitness: ', num2str(trainingMaximumOverall),...
    ' Validation mean: ', num2str(validationMaximumOverall)]);
  
  trainingMaximumInGeneration = 0.0;
  validationMaximumInGeneration = 0.0;
  for iPopulation = 1:populationSize
    chromosome = population(iPopulation,:);
    variableRange = min(fullVariableRange, startVariableRange + iGeneration/5);
    [weights, thresholds] = DecodeChromosome(chromosome, variableRange, numberOfHiddenNeurons);
    
    fitness(iPopulation) = EvaluateIndividual(weights, thresholds, 1);

    if (fitness(iPopulation) > trainingMaximumInGeneration)
      trainingMaximumInGeneration = fitness(iPopulation);
    end
    
    if (fitness(iPopulation) > trainingMaximumOverall)
      trainingMaximumOverall = fitness(iPopulation);
      bestIndex = iPopulation;
      bestChromosome = chromosome;
    end
  end
  
  tempPopulation = population;

  for i = 1:2:populationSize
    i1 = TournamentSelect(fitness, tournamentSelectionProbability, tournamentSize);
    i2 = TournamentSelect(fitness, tournamentSelectionProbability, tournamentSize);
    neuralNetwork1 = population(i1, :);
    neuralNetwork2 = population(i2, :);
    r = rand;
    if (r < crossoverProbability)
      newNeuralNetworkPair = Cross(neuralNetwork1, neuralNetwork2);
      tempPopulation(i, :) = newNeuralNetworkPair(1,:);
      tempPopulation(i+1, :) = newNeuralNetworkPair(2,:);
    else
      tempPopulation(i, :) = neuralNetwork1;
      tempPopulation(i+1, :) = neuralNetwork2;
    end
  end
  
  for i = 1:populationSize
    originalChromosome = tempPopulation(i, :);
    mutatedChromosome = Mutate(originalChromosome, mutationProbability);
    tempPopulation(i, :) = mutatedChromosome;
  end
  
  population = tempPopulation;
  
  isTimeToValidate = (mod(iGeneration, 1) == 0);
  
  if (isTimeToValidate)
    validationFitness = zeros(populationSize, 1);
    for iPopulation = 1:populationSize
      chromosome = population(iPopulation,:);
      variableRange = fullVariableRange;
      [validationWeights, validationThresholds] = DecodeChromosome(chromosome, variableRange, numberOfHiddenNeurons);
      validationFitness(iPopulation) = EvaluateIndividual(validationWeights, validationThresholds, 2);
      
      if (validationFitness(iPopulation) > validationMaximumInGeneration)
        validationMaximumInGeneration = validationFitness(iPopulation);
      end
      
      if (validationFitness(iPopulation) > validationMaximumOverall)
        validationMaximumOverall = validationFitness(iPopulation);
        csvwrite('BestNetworkTMP.csv', chromosome);
      end
    end
  end
  
  disp(['Training maximum in generation: ', num2str(trainingMaximumInGeneration)]);
  disp(['Validation maximum in generation: ', num2str(validationMaximumInGeneration)]);
  
  maxFitnessInGenerationTrain(iGeneration) = trainingMaximumInGeneration;
  maxFitnessInGenerationValidation(iGeneration) = validationMaximumInGeneration;
  csvwrite('Traindata.csv', maxFitnessInGenerationTrain);
  csvwrite('Valdata.csv', maxFitnessInGenerationValidation);
end

  