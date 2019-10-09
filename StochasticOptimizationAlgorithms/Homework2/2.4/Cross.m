function [newChromosome1, newChromosome2] = Cross(chromosome1, chromosome2)

  nGenesChromosome1 = length(chromosome1);
  nGenesChromosome2 = length(chromosome2);
  
  validIndices1 = 1:4:nGenesChromosome1;
  validIndices2 = 1:4:nGenesChromosome2;
  
  tmpLimit11 = randsample(validIndices1, 1);
  tmpLimit12 = randsample(validIndices1, 1);
  tmpLimit21 = randsample(validIndices2, 1);
  tmpLimit22 = randsample(validIndices2, 1);
  
  lowerLimit1 = min(tmpLimit11, tmpLimit12); 
  higherLimit1 = max(tmpLimit11, tmpLimit12);
  
  lowerLimit2 = min(tmpLimit21, tmpLimit22);
  higherLimit2 = max(tmpLimit21, tmpLimit22);
  
  newChromosome1part1 = chromosome1(1:lowerLimit1);
  newChromosome1part2 = chromosome2(lowerLimit2+1:higherLimit2);
  newChromosome1part3 = chromosome1(higherLimit1+1:end);
  
  newChromosome1 = [newChromosome1part1; newChromosome1part2; newChromosome1part3];
  
  newChromosome2part1 = chromosome2(1:lowerLimit2);
  newChromosome2part2 = chromosome1(lowerLimit1+1:higherLimit1);
  newChromosome2part3 = chromosome2(higherLimit2+1:end);
  
  newChromosome2 = [newChromosome2part1; newChromosome2part2; newChromosome2part3];
  
  
end
  
  