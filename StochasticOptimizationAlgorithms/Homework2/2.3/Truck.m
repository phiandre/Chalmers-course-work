function [v, T] = Truck(gear, pedalPressure, slopeAngle, velocity, temperature, timeStep)
  truckMass = 20000;
  g = 9.8;
  Ch = 40;
  tau = 30;
  maximumTemperature = 750;
  ambientTemperature = 283;
  
  deltaTemperature = temperature - ambientTemperature;
  
  if (temperature < (maximumTemperature - 100))
    foundationBrakeForce = truckMass*g*pedalPressure/20;
  else
    foundationBrakeForce = (1/20)*truckMass*g*pedalPressure*exp(-(temperature-(maximumTemperature - 100))/100);
  end
  
  engineBrakeForce = EngineBrakeForce(gear);
  
  gravityForce = truckMass*g*sind(slopeAngle);
  
  v = velocity + (1/truckMass)*(gravityForce - foundationBrakeForce - engineBrakeForce)*timeStep;
  
  if (pedalPressure < 0.01)
    deltaTemperature = deltaTemperature - deltaTemperature*timeStep/tau;
  else
    deltaTemperature = deltaTemperature + Ch*pedalPressure*timeStep;
  end
  
  T =  deltaTemperature + ambientTemperature;
  
  
end