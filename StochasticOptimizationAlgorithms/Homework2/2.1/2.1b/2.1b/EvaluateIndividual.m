function fitness = EvaluateIndividual(x, cities)
  pathLength = GetPathLength(x, cities);
  fitness = 1/pathLength;
  
end