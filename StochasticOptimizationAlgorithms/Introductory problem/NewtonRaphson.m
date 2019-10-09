function iterates = NewtonRaphson(polynomial, startingPoint, tolerance)
  polynomialDegree = max(find(polynomial))-1;
  if (length(polynomialDegree) == 0)
    polynomialDegree = 0;
  end
  cannotComputeIterates = polynomialDegree < 2; %Second derivative must not be 0.
  if (cannotComputeIterates)
    disp('The degree of the polynomial must be 2 or larger');
    iterates = []; %No iterate can be computed in this case, so return an empty vector.
    return; 
  end
  
  iterates = (startingPoint); %Array to store iteration values
  iIteration = 1;
  isNotConverged = true; 
  while (isNotConverged)
    iIteration = iIteration + 1;
    firstDerivative = PolynomialDifferentiation(polynomial, 1);
    secondDerivative = PolynomialDifferentiation(polynomial, 2);
    newPoint = NewtonRaphsonStep(startingPoint, firstDerivative, secondDerivative);
    iterates(iIteration) = newPoint;
    isNotConverged = abs(newPoint - startingPoint) > tolerance;
    startingPoint = newPoint;
    if (mod(iIteration, 1000) == 0) %If the program has not converged by iteration 1000, do not run it any further.
      disp('Completed 1000 iterations without convergence');
      return;
    end
  end
end