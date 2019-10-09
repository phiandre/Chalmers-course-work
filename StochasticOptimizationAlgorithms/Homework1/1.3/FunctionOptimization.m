populationSize = 100;
numberOfGenes = 50;
crossoverProbability = 0.8;
mutationProbability = 0.02;
tournamentSelectionProbability = 0.75;
tournamentSize = 2;
variableRange = 10;
numberOfGenerations = 100;
numberOfVariables = 2;
numberOfElitismCopies = 1;

fitness = zeros(populationSize, 1);
population = InitializePopulation(populationSize, numberOfGenes);
for iGeneration = 1:numberOfGenerations

  maximumFitness = 0.0;
  xBest = zeros(1,2);
  bestIndividualIndex = 0;

  for i = 1:populationSize
    chromosome = population(i,:);
    x = DecodeChromosome(chromosome, numberOfVariables, variableRange);
    fitness(i) = EvaluateIndividual(x);
    if (fitness(i) > maximumFitness)
      maximumFitness = fitness(i);
      bestIndividualIndex = i;
      xBest = x;
    end
  end
  

  temporaryPopulation = population;

  for i = 1:2:populationSize
    iFirstSelectedIndividual = TournamentSelect(fitness,tournamentSelectionProbability, tournamentSize);
    iSecondSelectedIndividual = TournamentSelect(fitness,tournamentSelectionProbability, tournamentSize);

    chromosome1 = population(iFirstSelectedIndividual,:);
    chromosome2 = population(iSecondSelectedIndividual,:);

    if (rand < crossoverProbability)
      newChromosomePair = Cross(chromosome1, chromosome2);
      temporaryPopulation(i,:) = newChromosomePair(1,:);
      temporaryPopulation(i+1,:) = newChromosomePair(2,:);
    else
      temporaryPopulation(i,:) = chromosome1;
      temporaryPopulation(i+1,:) = chromosome2;
    end
  end

  for i = 1:populationSize
    originalChromosome = temporaryPopulation(i,:);
    mutatedChromosome = Mutate(originalChromosome, mutationProbability);
    temporaryPopulation(i,:) = mutatedChromosome;
  end

  bestIndividualInLastPopulation = population(bestIndividualIndex,:);
  temporaryPopulation = InsertBestIndividual(temporaryPopulation, bestIndividualInLastPopulation , numberOfElitismCopies);
  population = temporaryPopulation;
end

x1 = xBest(1);
x2 = xBest(2);

disp(['x*: (', num2str(x1), ', ', num2str(x2), ')']);

bestFunctionValue = EvaluateFunction(xBest);
disp(['f(x*) = ', num2str(bestFunctionValue)]);
  