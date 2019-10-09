function [particlePosition, particleVelocity]= UpdateSwarm(particlePosition, particleVelocity, particleBest, swarmBest, maximumVelocity, inertia)
  r = rand;
  q = rand;
  c1 = 2;
  c2 = 2;
  
  dimensions = length(particleVelocity);
  
  for iDimension = 1:dimensions
    particleVelocity(iDimension) = inertia*particleVelocity(iDimension) + c1*q*(particleBest(iDimension) - particlePosition(iDimension)) + c2*r*(swarmBest(iDimension) - particlePosition(iDimension));
    if (particleVelocity(iDimension) > maximumVelocity)
      particleVelocity(iDimension) = maximumVelocity;
    end
  end

  for iDimension = 1:dimensions
    particlePosition(iDimension) = particlePosition(iDimension) + particleVelocity(iDimension);
  end
  
end