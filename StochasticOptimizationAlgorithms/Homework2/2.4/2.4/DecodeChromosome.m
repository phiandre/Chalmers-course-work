function functionValue = DecodeChromosome(chromosome, dataPoint, operands)
  chromosomeLength = length(chromosome);
  operands(1) = dataPoint;
  
  for i = 1:4:chromosomeLength-3
    x = 0;
    instruction = chromosome(i);
    destinationRegister = chromosome(i+1);
    operand1 = operands(chromosome(i+2));
    operand2 = operands(chromosome(i+3));
    if (instruction == 1)
      x = operand1 + operand2;
    elseif (instruction == 2)
      x = operand1 - operand2;
    elseif (instruction == 3)
      x = operand1*operand2;
    elseif (instruction == 4)
      x = Division(operand1, operand2);
    else
      disp('Invalid instruction');
      break;
    end
    operands(destinationRegister) = x;
  end
  
  functionValue = operands(1);
end
    