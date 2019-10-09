stepLength = 1e-6;
threshold = 1e-6;
muSequence = [1e0 1e1 1e2 1e3 1e4 1e5]';
numberOfMus = length(muSequence);

startingPoint = [1,2]';

stationaryPoints = zeros(numberOfMus,2);

for iMu = 1:numberOfMus
  stationaryPoints(iMu, :) = GradientDescent(startingPoint, muSequence(iMu), stepLength, threshold);
end

x1 = stationaryPoints(:,1);
x2 = stationaryPoints(:,2);

T = table([muSequence],[x1],[x2], 'VariableNames', {'mu', 'x_1', 'x_2'});
disp(T);