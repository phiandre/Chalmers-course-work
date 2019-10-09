
trainData = csvread('Traindata.csv');
valData = csvread('Valdata.csv');


iterations = length(trainData);

averageOver = 1;
avgVal = zeros(5000/averageOver, 1);
avgTrain = zeros(5000/averageOver, 1);
iIter = 1;
for i=1:averageOver:5000
  avgTrain(iIter) = mean(trainData(i:i+averageOver-1));
  avgVal(iIter) = mean(valData(i:i+averageOver-1));
  iIter = iIter + 1;
end

plot(1:5000/averageOver, avgTrain, 'LineWidth', 2);
hold on;
plot(1:5000/averageOver, avgVal, 'LineWidth', 2);
ax = gca;
ax.FontSize = 24;
xlabel('Generation', 'FontSize', 30); 
ylabel('Maximum fitness value', 'FontSize', 30);
legend({'Training data', 'Validation data'}, 'FontSize', 30);
axis([0 5000 0 25000]);


  
