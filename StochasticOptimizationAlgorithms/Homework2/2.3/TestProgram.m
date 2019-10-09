close all; clear all; clc;
bestChromosome = csvread('BestNetworkTMP.csv');
[weights, thresholds] = DecodeChromosome(bestChromosome, 10.0, 7);
%Limits
minVelocity = 1;
maxVelocity = 25;
maxTemperature = 750;
maxSlope = 10;

%Initial conditions
velocity = 20;
gear = 7;
brakeTemperature = 500;
distanceTravelled = 0;
timeStep = 0.05;

distanceTravelled = 0;
hasNotCrashed = true;
hasNotCrashed = true;
averageSpeed = 0;
totalTime = 0;
timeUntilGearChangeAvailable = 0;

angles = zeros(1000/timeStep, 1);
pedalPressures = zeros(1000/timeStep, 1);
gears = zeros(1000/timeStep, 1);
speeds = zeros(1000/timeStep, 1);
brakeTemperatures = zeros(1000/timeStep, 1);

iIter = 0;

while (hasNotCrashed)
  
  iIter = iIter + 1;
  slopeAngle = GetSlopeAngle(distanceTravelled, 5, 3);
  inputs = [velocity/maxVelocity; slopeAngle/maxSlope; brakeTemperature/maxTemperature];
  [gearChange, pedalPressure] = FeedForward(weights, thresholds, inputs);

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

  angles(iIter) = slopeAngle;
  pedalPressures(iIter) = pedalPressure;
  gears(iIter) = gear;
  speeds(iIter) = velocity;
  brakeTemperatures(iIter) = brakeTemperature;
  
end
xRange =linspace(1,distanceTravelled,iIter);
range = 1:iIter;
subplot(5,1,1);
plot(xRange, angles(range));
title('Slope angle');

subplot(5,1,2);
plot(xRange, pedalPressures(range));
title('Pedal pressure');

subplot(5,1,3);
plot(xRange, gears(range));
title('Gear');

subplot(5,1,4);
plot(xRange, speeds(range));
title('Speed');

subplot(5,1,5);
plot(xRange, brakeTemperatures(range));
title('Brake temperature');
