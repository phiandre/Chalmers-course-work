addpath('TSPgraphics');
clear all; close all; clc;

cities = LoadCityLocations;

populationSize = 100;
numberOfCities = size(cities, 1);
mutationProbability = 0.02;
tournamentSelectionProbability = 0.75;
tournamentSize = 2;
numberOfElitismCopies = 1;
numberOfGenerations = 500000;
fitness = zeros(populationSize, 1);

tspFigure = InitializeTspPlot(cities,[0 20 0 20]); 
connections = InitializeConnections(cities);
population = InitializePopulation(populationSize, numberOfCities);

maximumFitness = 0.0;
bestPath = zeros(1, numberOfCities);
bestIndividualIndex  = 0;
for iGeneration = 1:numberOfGenerations

  if (mod(iGeneration,10000) == 0)
    disp(['Generation: ', num2str(iGeneration)]);
  end

  newBestPathFound = false;
  for iPopulation = 1:populationSize
    chromosome = population(iPopulation, :);
    fitness(iPopulation) = EvaluateIndividual(chromosome, cities);

    if (fitness(iPopulation) > maximumFitness)
      maximumFitness = fitness(iPopulation);
      bestIndividualIndex = iPopulation;
      newBestPathFound = true;
      disp(['Generation: ', num2str(iGeneration), ' Distance: ', num2str(1/maximumFitness)]);
      bestPath = chromosome;
    end
  end

  tempPopulation = population;

  for iPopulation = 1:populationSize
    individual = TournamentSelect(fitness, tournamentSelectionProbability, tournamentSize);
    chromosome = population(individual,:);
    tempPopulation(iPopulation, :) = chromosome;
  end

  for iPopulation = 1:populationSize
    originalChromosome = tempPopulation(iPopulation, :);
    mutatedChromosome = Mutate(originalChromosome, mutationProbability);
    tempPopulation(iPopulation, :) = mutatedChromosome;
  end

  tempPopulation = InsertBestIndividual(tempPopulation, bestPath, numberOfElitismCopies);

  if (newBestPathFound)
    csvwrite('BestPath.csv', bestPath);
    PlotPath(connections, cities, bestPath);
    newBestPathFound = false;
  end

  population = tempPopulation;
end