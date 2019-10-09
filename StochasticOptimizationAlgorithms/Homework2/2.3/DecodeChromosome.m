function [weights, thresholds] = DecodeChromosome(chromosome, variableRange, numberOfHiddenNeurons)
  totalNumberOfParameters = 5*numberOfHiddenNeurons + numberOfHiddenNeurons + 2;
  
  weightMatrix1 = [];
  thresholds1 = [];
  
  for iGene = 1:4:numberOfHiddenNeurons*(3+1)
    weights = -variableRange + 2*variableRange*chromosome(iGene:iGene+2);
    threshold = -variableRange + 2*variableRange*chromosome(iGene+3);
    weightMatrix1 = [weightMatrix1; weights];
    thresholds1 = [thresholds1; threshold];
  end
  
  weightMatrix2 = [];
  thresholds2 = [];
  for iGene = (numberOfHiddenNeurons*4+1):numberOfHiddenNeurons+1:totalNumberOfParameters
    weights = -variableRange + 2*variableRange*chromosome(iGene:iGene+numberOfHiddenNeurons-1);
    threshold = -variableRange + 2*variableRange*chromosome(iGene+numberOfHiddenNeurons);
    weightMatrix2 = [weightMatrix2; weights];
    thresholds2 = [thresholds2; threshold];
  end
  

  weights = {weightMatrix1, weightMatrix2};
  thresholds = {thresholds1, thresholds2};
end