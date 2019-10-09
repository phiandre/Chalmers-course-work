function [delta1, delta2, delta3] = ComputeErrors(input, target, b1, b2, b3, weights1, weights2, weights3, M1, M2)
  O = tanh(b3);
  V2 = tanh(b2);
  V1 = tanh(b1);
  
  delta3 = (1-(tanh(b3)).^2)*(target-O);
  
  for i = 1:M2
    delta2(i) = delta3*weights3(i)*(1-(tanh(b2(i))).^2);
  end
  disp(delta2);
  for j = 1:M1
    delta1(j) = delta2*weights2(:,j)*(1-(tanh(b1(j))).^2);
  end
end