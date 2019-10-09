function reflectedVector = Reflect(vector, axis)
  rotatedVector = zeros(1,length(vector));
  
  if (axis == 1) %reflect through axis parallel to x-axis
    reflectedVector(1) = vector(3);
    reflectedVector(2) = vector(4)
    reflectedVector(3) = vector(1);
    reflectedVector(4) = vector(2);
    reflectedVector(5) = vector(7);
    reflectedVector(6) = vector(8);
    reflectedVector(7) = vector(5);
    reflectedVector(8) = vector(6);
  elseif (axis == 2) %reflect through axis parallel to y axis
    reflectedVector(1) = vector(2);
    reflectedVector(2) = vector(1)
    reflectedVector(3) = vector(4);
    reflectedVector(4) = vector(3);
    reflectedVector(5) = vector(6);
    reflectedVector(6) = vector(5);
    reflectedVector(7) = vector(8);
    reflectedVector(8) = vector(7);
  elseif (axis == 3) %reflect through axis parallel to z axis
    reflectedVector(1) = vector(5);
    reflectedVector(2) = vector(6)
    reflectedVector(3) = vector(7);
    reflectedVector(4) = vector(8);
    reflectedVector(5) = vector(1);
    reflectedVector(6) = vector(2);
    reflectedVector(7) = vector(3);
    reflectedVector(8) = vector(4);
  end
end
    