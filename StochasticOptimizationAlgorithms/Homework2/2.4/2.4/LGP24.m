clear all; close all; clc;
data = LoadFunctionData;

populationSize = 200;
minInitialChromosomeSize = 4;
maxInitialChromosomeSize = 100;
constantRegisters = [1, -1];
variableRegisters = 5;
instructions = 4; %{+,-,*,/}
numberOfGenerations = 50000;
numberOfDataPoints = length(data);
tournamentSelectionProbability = 0.75;
crossoverProbability = 0.2;
tournamentSize = 4;
numberOfElitismCopies = 1;
maximumChromosomeLength = 1024;

populationDiversityLimit = 0.45;
maxMutationProbability = 0.2;
minMutationProbability = 0.04;
mutationProbabilityScalingFactor = 1.1;

mutationProbability = minMutationProbability;

numberOfOperands = length(constantRegisters) + variableRegisters;
operands = zeros(1, numberOfOperands);
operands(variableRegisters+1:end)  = constantRegisters;

ranges = [instructions, variableRegisters, numberOfOperands, numberOfOperands];
population = InitializePopulation(populationSize, minInitialChromosomeSize, maxInitialChromosomeSize, instructions, variableRegisters, numberOfOperands);

fitness = zeros(populationSize, 1);
approximatedValues = zeros(numberOfDataPoints, 1);
bestFunction = zeros(numberOfDataPoints, 1);
maximumFitness = 0.0;
bestIndividualIndex = 0;


for iGeneration = 1:numberOfGenerations
  
  if (mod(iGeneration,1) == 0)
    disp(['Generation: ', num2str(iGeneration), ' maximumFitness: ', num2str(maximumFitness)]);
  end
  
  for iPopulation = 1:populationSize
    chromosome = population(iPopulation).Chromosome;
    
    if (length(chromosome) > MAXIMUM_CHROMOSOME_LENGTH)
      population(iPopulation).Chromosome = chromosome(1:MAXIMUM_CHROMOSOME_LENGTH);
      chromosome = chromosome(1:MAXIMUM_CHROMOSOME_LENGTH);
    end
    
    for iData = 1:numberOfDataPoints
      dataPoint = data(iData, 1);
      approximatedFunctionValue = DecodeChromosome(chromosome, dataPoint, operands);
      approximatedValues(iData) = approximatedFunctionValue;
    end
    
    fitness(iPopulation) = EvaluateIndividual(approximatedValues, data(:,2));
    
    if (fitness(iPopulation) > maximumFitness)
      maximumFitness = fitness(iPopulation);
      bestIndividualIndex  = iPopulation;
      bestInstructions = chromosome;
      bestFunction = approximatedValues;
      %csvwrite('BestChromosomeFound.csv', chromosome);
    end
  end
  
  tempPopulation = population;
  
  for iPopulation = 1:2:populationSize
    i1 = TournamentSelect(fitness, tournamentSelectionProbability, tournamentSize);
    i2 = TournamentSelect(fitness, tournamentSelectionProbability, tournamentSize);
    chromosome1 = population(i1).Chromosome;
    chromosome2 = population(i2).Chromosome;
    
    r = rand;
    if (r < crossoverProbability)
      [newChromosome1, newChromosome2] = Cross(chromosome1,chromosome2);
      tempPopulation(iPopulation).Chromosome = newChromosome1;
      tempPopulation(iPopulation+1).Chromosome = newChromosome2;
    else
      tempPopulation(iPopulation).Chromosome = chromosome1;
      tempPopulation(iPopulation+1).Chromosome = chromosome2;
    end
  end
  

  mutationProbability = CalculateMutationProbability(tempPopulation, populationSize, populationDiversityLimit,...
                                                      mutationProbabilityScalingFactor, minMutationProbability,...
                                                      maxMutationProbability, mutationProbability);
  for iPopulation = 1:populationSize
    originalChromosome = tempPopulation(iPopulation).Chromosome;
    mutatedChromosome = Mutate(originalChromosome, mutationProbability, ranges);
    tempPopulation(iPopulation).Chromosome = mutatedChromosome;
  end

  bestIndividualInLastPopulation = population(bestIndividualIndex).Chromosome;
  tempPopulation = InsertBestIndividual(tempPopulation, bestIndividualInLastPopulation , numberOfElitismCopies);
  population = tempPopulation;
  
end


