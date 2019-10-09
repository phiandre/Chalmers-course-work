clear all; close all; clc;

populationSize = 100;
numberOfGenes = 50;
crossoverProbability = 0.8;
mutationProbabilities = [0 0.02 0.05 0.10];
tournamentSelectionProbability = 0.75;
tournamentSize = 2;
variableRange = 10;
numberOfGenerations = 100;
numberOfElitismCopies = 1;
numberOfRuns = 100;


fitnessVector = zeros(length(mutationProbabilities),1);

for iMutationProb = 1:length(mutationProbabilities)
  mutationProbability = mutationProbabilities(iMutationProb);
  tmpFitness = zeros(numberOfRuns,1);
  
  for iRun = 1:numberOfRuns
    
    population = InitializePopulation(populationSize, numberOfGenes);
    for iGeneration = 1:numberOfGenerations

      maximumFitness = 0.0;
      xBest = zeros(1,2);
      bestIndividualIndex = 0;

      for i = 1:populationSize
        chromosome = population(i,:);
        x = DecodeChromosome(chromosome, 2, variableRange);
        fitness(i) = EvaluateIndividual(x);
        if (fitness(i) > maximumFitness)
          maximumFitness = fitness(i);
          bestIndividualIndex = i;
          xBest = x;
        end
      end

      %disp(['xBest: ', num2str(xBest), ' maximumFitness: ', num2str(maximumFitness)]);

      tempPopulation = population;

      for i = 1:2:populationSize
        i1 = TournamentSelect(fitness,tournamentSelectionProbability, tournamentSize);
        i2 = TournamentSelect(fitness,tournamentSelectionProbability, tournamentSize);

        chromosome1 = population(i1,:);
        chromosome2 = population(i2,:);

        if (rand < crossoverProbability)
          newChromosomePair = Cross(chromosome1, chromosome2);
          tempPopulation(i,:) = newChromosomePair(1,:);
          tempPopulation(i+1,:) = newChromosomePair(2,:);
        else
          tempPopulation(i,:) = chromosome1;
          tempPopulation(i+1,:) = chromosome2;
        end
      end

      for i = 1:populationSize
        originalChromosome = tempPopulation(i,:);
        mutatedChromosome = Mutate(originalChromosome, mutationProbability);
        tempPopulation(i,:) = mutatedChromosome;
      end
      
      bestIndividualInLastPopulation = population(bestIndividualIndex,:);
      tempPopulation = InsertBestIndividual(tempPopulation, bestIndividualInLastPopulation , numberOfElitismCopies);
      population = tempPopulation;
    end
    tmpFitness(iRun,:) = maximumFitness;
  end
  fitnessVector(iMutationProb, :) = median(tmpFitness);
end

disp(['xBest: ', num2str(xBest(1)), num2str(xBest(2))]);
  