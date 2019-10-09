function rotatedVector = Rotate(vector)
  rotatedVector = zeros(1,length(vector));
  rotatedVector(1) = vector(5);
  rotatedVector(2) = vector(1);
  rotatedVector(3) = vector(7);
  rotatedVector(4) = vector(3);
  rotatedVector(5) = vector(6);
  rotatedVector(6) = vector(2);
  rotatedVector(7) = vector(8);
  rotatedVector(8) = vector(4);

end