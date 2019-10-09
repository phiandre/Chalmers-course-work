
function alpha = GetSlopeAngle(x, iSlope, iDataSet)
  if (iDataSet == 1)                                % Training
    if (iSlope == 1) 
      alpha = 4 + sin(x/100) + cos(sqrt(2)*x/50);    
    elseif (iSlope == 2)
      alpha = 4 - 0.5*sin(x/75) + 0.5*cos(x/100);
    elseif (iSlope == 3)
      alpha = 5 + sin(x/200) + cos(sqrt(3)*x/100);
    elseif (iSlope == 4)
      alpha = 5 + 1.5*sin(x/100) + cos(sqrt(3)*x/60);
    elseif (iSlope == 5)
      alpha = 4 + cos(sqrt(5)*x/50) + 2.5*sin(x/50);
    elseif (iSlope == 6)
      alpha = 4 + sin(x/20) + 2*cos(x/75);
    elseif (iSlope == 7)
      alpha = 5 + 2*sin(x/50) + sqrt(7) * cos(x/100);
    elseif (iSlope == 8)
      alpha = 4 + sin(x/100) + cos(x/30);
    elseif (iSlope == 9)
      alpha = 5 + 0.8*sin(x/40) + 0.5*cos(x/75);
    elseif (iSlope== 10)
      alpha = 3 + 2*sin(x/50) + cos(sqrt(2)*x/100);  
    end 
  elseif (iDataSet == 2)                            % Validation
    if (iSlope == 1) 
      alpha = 6 - sin(x/100) + cos(sqrt(3)*x/50);    
    elseif (iSlope == 2)
      alpha = 3 - sin(x/120) + 0.5*cos(x/50);
    elseif (iSlope == 3)
      alpha = 5 + sqrt(3)*sin(x/50) - 3*cos(x/100);
    elseif (iSlope == 4)
      alpha = 4 + sin(sqrt(3)*x/60) - cos(sqrt(5)*x/150);
    elseif (iSlope == 5) 
      alpha = 5 + sin(x/50) + cos(sqrt(5)*x/50);    
    end 
  elseif (iDataSet == 3)                           % Test
    if (iSlope == 1) 
      alpha = 6 - sin(x/100) - cos(sqrt(7)*x/50);   
    elseif (iSlope == 2)
      alpha = 4 - sin(x/50) + cos(sqrt(9)*x/100);
    elseif (iSlope == 3)
      alpha = 4 + sin(x/50) + 2*cos(x/75);
    elseif (iSlope == 4)
      alpha = 3 + sin(x/100) - cos(x/50);
    elseif (iSlope == 5)
      alpha = 4 + (x/1000) + sin(x/70) + cos(sqrt(7)*x/100); 
    end
end
