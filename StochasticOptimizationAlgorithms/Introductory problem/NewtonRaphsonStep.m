function newPoint = NewtonRaphsonStep(oldPoint, firstDerivative, secondDerivative)
  if (secondDerivative == 0)
    %If the second derivative is zero, a new solution cannot be computed
    %with Newton-Raphson's method. 
    newPoint = oldPoint; 
  else
    newPoint = oldPoint - Polynomial(oldPoint, firstDerivative)/Polynomial(oldPoint, secondDerivative);
  end
end
