function [swarmPositions, swarmVelocities] = InitializeSwarm(numberOfParticles, xMin, xMax, dimensionSize)

  swarmPositions = zeros(numberOfParticles, dimensionSize);
  swarmVelocities = zeros(numberOfParticles, dimensionSize);
  
  for iParticle = 1:numberOfParticles
    for iDimension = 1:dimensionSize
      r_position = rand;
      r_velocity = rand;
      swarmPositions(iParticle, iDimension) = xMin + r_position*(xMax-xMin);
      swarmVelocities(iParticle, iDimension) = -(xMax - xMin)/2 + r_velocity*(xMax - xMin);
    end
  end
end