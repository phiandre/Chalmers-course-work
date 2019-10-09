function iSelectedIndividual = TournamentSelect(fitness, pTournament, tournamentSize)
  populationSize = length(fitness);
  
  fitnessIndex = zeros(tournamentSize, 2);
  
  for iContestant = 1:tournamentSize
    index = 1 + fix(rand*populationSize);
    fitnessIndex(iContestant, 1) = index;
    fitnessIndex(iContestant, 2) = fitness(index);
  end
  
  fitnessIndex = sortrows(fitnessIndex, -2); %sort after best fitness value
  hasNotSelectedIndividual = true;
  iContestant = 1;
  while (hasNotSelectedIndividual)
    if (rand < pTournament)
      iSelectedIndividual = fitnessIndex(iContestant,1);
      hasNotSelectedIndividual = false;
    else
      iContestant = iContestant + 1;
    end
    
    if (iContestant == tournamentSize)
      iSelectedIndividual = fitnessIndex(iContestant,1);
      hasNotSelectedIndividual = false;
    end
  end
  
end