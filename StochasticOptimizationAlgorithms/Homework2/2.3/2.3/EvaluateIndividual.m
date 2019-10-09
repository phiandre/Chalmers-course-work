function fitness = EvaluateIndividual(weights, thresholds, dataSet)
  %Limits
  minVelocity = 1;
  maxVelocity = 25;
  maxTemperature = 750;
  maxSlope = 10;
  
  if (dataSet == 1)
    numberOfSlopes = 10;
  else
    numberOfSlopes = 5;
  end
  slopeOrder = randperm(numberOfSlopes);
  
  fitnessVector = zeros(numberOfSlopes, 1);
  timeStep = 0.05;
  
  
  for iSlope = 1:numberOfSlopes
    slopeIndex = slopeOrder(iSlope);
    
    %Initial conditions
    velocity = 20;
    gear = 7;
    brakeTemperature = 500;
    distanceTravelled = 0;
    
    hasNotCrashed = true;
    totalSpeed = 0;
    totalTime = 0;
    timeUntilGearChangeAvailable = 0;
    
    while (hasNotCrashed)
      slopeAngle = GetSlopeAngle(distanceTravelled, slopeIndex, dataSet);
      networkInputs = [velocity/maxVelocity; slopeAngle/maxSlope; brakeTemperature/maxTemperature];
      
      [gearChange, pedalPressure] = FeedForward(weights, thresholds, networkInputs);
      
      if (timeUntilGearChangeAvailable > 0)
        timeUntilGearChangeAvailable = timeUntilGearChangeAvailable - timeStep;
      else
        gear = gear + gearChange;
        timeUntilGearChangeAvailable = 2;
      end
      
      if (gear < 1)
        gear = 1;
      elseif (gear > 10)
        gear = 10;
      end
      
      [velocity, brakeTemperature] = Truck(gear, pedalPressure, slopeAngle, velocity, brakeTemperature, timeStep);
      
      distanceTravelled = distanceTravelled + velocity*timeStep;

      isTooSlow = velocity < minVelocity;
      isTooFast = velocity > maxVelocity;
      isTooHot = brakeTemperature > maxTemperature;
      isFinished = (distanceTravelled > 1000);
      

      if (isTooSlow || isTooFast || isTooHot || isFinished)
        hasNotCrashed = false;
      end

      totalTime = totalTime + timeStep;
      totalSpeed = totalSpeed + velocity;
    end
    
    averageSpeed = totalSpeed/(totalTime/timeStep);
    if (distanceTravelled < 500)
      fitnessVector(iSlope) = distanceTravelled*averageSpeed/(1e4/distanceTravelled);
    else
      fitnessVector(iSlope) = distanceTravelled*averageSpeed;
    end
  end
  
  fitness = mean(fitnessVector);
end