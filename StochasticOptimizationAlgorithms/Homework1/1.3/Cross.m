function newChromosomePair = Cross(chromosome1, chromosome2)
  
  numberOfGenes = size(chromosome1,2);
  
  crossoverPoint = 1 + fix(rand*(numberOfGenes-1));
  
  newChromosomePair = zeros(2, numberOfGenes);
  
  for iGenes = 1:numberOfGenes
    if (iGenes <= crossoverPoint)
      newChromosomePair(1, iGenes) = chromosome1(iGenes);
      newChromosomePair(2, iGenes) = chromosome2(iGenes);
    else
      newChromosomePair(1, iGenes) = chromosome2(iGenes);
      newChromosomePair(2, iGenes) = chromosome1(iGenes);
    end
  end
  
end