clear all; 
format long;
f = @(x,y) (x.^2 + y - 11).^2 + (x + y.^2 - 7).^2;
numberOfParticles = 40;
xMax = 5;
xMin = -5;
dimension = 2; %We are considering a function of two variables
maximumVelocity = xMax;

[swarmPositions, swarmVelocities] = InitializeSwarm(numberOfParticles, xMin, xMax, dimension);
bestParticlePositions = ones(numberOfParticles, dimension)*Inf;
bestParticleValues = ones(numberOfParticles, 1)*Inf;
swarmBestPosition = zeros(1,2);
swarmBest = Inf;
tolerance = 1e-7;

inertia = 1.4;
iNewBestNotFound = 0;
noNewBestFoundFor100Iterations = iNewBestNotFound < 100;

while (noNewBestFoundFor100Iterations)
  oldSwarmBest = swarmBest;
  for iParticle = 1:numberOfParticles
    particlePosition = swarmPositions(iParticle, :);
    x = particlePosition(1);
    y = particlePosition(2);
    functionValue = f(x,y);
    
    if (functionValue < bestParticleValues(iParticle))
      bestParticleValues(iParticle) = functionValue;
      bestParticlePositions(iParticle, :) = particlePosition;
      
      if (functionValue < swarmBest)
        swarmBestPosition = particlePosition;
        swarmBest = functionValue;
      end
    end
  end
  
  if ( abs(oldSwarmBest - swarmBest) < tolerance )
    iNewBestNotFound = iNewBestNotFound + 1;
  else
    iNewBestNotFound = 0;
  end
  
  for iParticle = 1:numberOfParticles
    particlePosition = swarmPositions(iParticle, :);
    particleVelocity = swarmVelocities(iParticle, :);
    particleBestPosition = bestParticlePositions(iParticle, :);
    
    [particlePosition, particleVelocity] = UpdateSwarm(particlePosition, particleVelocity,...
                                                        particleBestPosition, swarmBestPosition, ...
                                                        maximumVelocity, inertia);
    swarmPositions(iParticle, :) = particlePosition;
    swarmVelocities(iParticle, :) = particleVelocity;
  end
  
  inertia = max(0.3, 0.99*inertia);
  noNewBestFoundFor100Iterations = iNewBestNotFound < 100;
end

disp(['Best position in swarm: (', num2str(swarmBestPosition(1)), ', ', num2str(swarmBestPosition(2)), ')']);