function functionExpression = ConstructFunctionExpression(instructions, operands)

  chromosomeLength = length(instructions);

  numberOfOperands = length(operands);
  registers = cell(1, numberOfOperands);
  registers{1} = 'x';
  for iRegister = 2:numberOfOperands
    operand = operands(iRegister);
    registers{iRegister} = num2str(operand);
  end
  
  for iChromosome = 1:4:(chromosomeLength-3)
    
    operator = instructions(iChromosome);
    destinationRegister = instructions(iChromosome+1);
    operand1 = num2str(registers{instructions(iChromosome+2)});
    operand2 = num2str(registers{instructions(iChromosome+3)});
    
    if (operator == 1)
      sum = ['(' operand1 '+' operand2 ')'];
      
    elseif (operator == 2)
      sum = ['(' operand1 '-' operand2 ')'];
    elseif (operator == 3)
      %x = Multiplication(operand1, operand2);
      sum = ['(' operand1 '*' operand2 ')'];
    elseif (operator == 4)
      sum = ['(' operand1 '/' operand2 ')'];
    else
      disp('Invalid instruction');
      break;
    end
    registers{destinationRegister} = sum;
  end
  
  functionExpression = registers{1};
end