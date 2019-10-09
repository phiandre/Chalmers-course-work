function y = SigmoidDerivative(x)
  y = Sigmoid(x).*(1-Sigmoid(x));
end