function newPoint = GradientDescent(startingPoint, mu, stepLength, threshold)
  isNotConverged = true;
  while( isNotConverged )
    x1 = startingPoint(1);
    x2 = startingPoint(2);
    
    computedGradient = Gradient(x1, x2, mu);
    newPoint = startingPoint - stepLength*computedGradient;
    
    isNotConverged = norm(computedGradient) > threshold;
    startingPoint = newPoint;
  end
end