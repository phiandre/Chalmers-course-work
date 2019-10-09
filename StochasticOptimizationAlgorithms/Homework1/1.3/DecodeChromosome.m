function x = DecodeChromosome(chromosome, numberOfVariables, variableRange)
  
  chromosomeLength = length(chromosome);
  bitsPerVariable = chromosomeLength/numberOfVariables; %assumed to be an integer
  x = zeros(numberOfVariables, 1);
  
  for iVariable = 1:numberOfVariables
    coefficients = zeros(1, bitsPerVariable);
    for iBit = 1:bitsPerVariable
      coefficients(iBit) = 2.^(-iBit);
    end
    
    startReading = 1+bitsPerVariable*(iVariable-1);
    endReading = bitsPerVariable*iVariable;
    genes = chromosome(startReading:endReading)';
    tmpVariable = coefficients*genes;
    
    x(iVariable) = -variableRange + 2*variableRange*tmpVariable/(1-2.^(-bitsPerVariable));
  end
  
end