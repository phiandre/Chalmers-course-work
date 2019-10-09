close all; clear all; clc;
bestChromosome = csvread('BestNetworkFound.csv');
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
  slopeAngle = GetSlopeAngle(distanceTravelled, 1, 3);
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

%       disp(['Pedal pressure: ', num2str(pedalPressure)]);
%       disp(['Brake temperature: ', num2str(brakeTemperature)]);
%       pause(0.1);

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
ax = gca;
ax.FontSize = 16;
title('Slope angle', 'FontSize', 20);

subplot(5,1,2);
plot(xRange, pedalPressures(range));
ax = gca;
ax.FontSize = 16;
title('Pedal pressure', 'FontSize', 20);

subplot(5,1,3);
plot(xRange, gears(range));
ax = gca;
ax.FontSize = 16;
title('Gear', 'FontSize', 20);

subplot(5,1,4);
plot(xRange, speeds(range));
ax = gca;
ax.FontSize = 16;
title('Speed', 'FontSize', 20);

subplot(5,1,5);
plot(xRange, brakeTemperatures(range));
ax = gca;
ax.FontSize = 16;
title('Brake temperature','FontSize', 20);
