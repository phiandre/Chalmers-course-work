function [swarmPositions, swarmVelocities] = InitializeSwarm(numberOfParticles, xMin, xMax, dimensionSize)

  swarmPositions = zeros(numberOfParticles, dimensionSize);
  swarmVelocities = zeros(numberOfParticles, dimensionSize);
  
  for iParticle = 1:numberOfParticles
    for iDimension = 1:dimensionSize
      r = rand;
      swarmPositions(iParticle, iDimension) = xMin + r*(xMax-xMin);
      swarmVelocities(iParticle, iDimension) = -(xMax - xMin)/2 + r*(xMax - xMin);
    end
  end
end