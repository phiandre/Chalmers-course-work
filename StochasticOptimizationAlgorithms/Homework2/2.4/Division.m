function x = Division(operand1, operand2)
  
  if(operand2 == 0)
    x = 1e10;
  else
    x = operand1./operand2;
  end
  
end