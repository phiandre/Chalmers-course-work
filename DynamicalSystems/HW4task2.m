clear all; close all; clc;
a = 1.4;
b = 0.3;

nMax = 2e6;
nInitialConditions = 5;
transient = 100;
figure;

x = zeros(nInitialConditions, nMax);
y = zeros(nInitialConditions, nMax);
for iInit = 1:nInitialConditions

  x(iInit, 1) = rand()*0.4-0.2;
  y(iInit, 1) = rand()*0.2 - 0.1;
  
  %x(iInit, 1) = 0.05;
  %y(iInit, 1) = 0.05;

  for i = 1:(nMax-1)
    x(iInit, i+1) = y(iInit, i) + 1 - a*x(iInit, i).^2;
    y(iInit, i+1) = b*x(iInit, i);
  end
  hold on;
  scatter(x(iInit, transient:end),y(iInit, transient:end));
end


%%
eps_vals = 1e-3:1e-3:2e-2;

xvals = zeros(nInitialConditions, length(eps_vals));
yvals = zeros(nInitialConditions, length(eps_vals));

iInit = 1;
for iEps = 1:length(eps_vals)
  eps = eps_vals(iEps);

  x_edges = -a:eps:a+eps;
  y_edges = -a*b:eps:a*b+eps;

  N_tmp = histcounts2(x(iInit,:), y(iInit, :), x_edges, y_edges);

  N = N_tmp(N_tmp ~= 0);

  p = N./nMax;
  
  x_entry = 0;
  y_entry = 0;
  q = 4;
  I = 0;

  if (q == 1)
    for i = 1:length(p)
      I = I + p(i)*log(p(i));
    end
    x_entry = log(1./eps);
    y_entry = -I;
  else
    for i = 1:length(p)
      I = I + p(i).^q;
    end
    y_entry = log(I)./((1-q));
    x_entry = log(1./eps);
  end

  xvals(iInit,iEps) = x_entry;
  yvals(iInit,iEps) = y_entry;
  disp('Update y:')
  disp(y_entry);
end


%%

y_use = yvals(1,:);
x_use = xvals(1,:);



p_fit = polyfit(x_use, y_use, 1);
scatter(x_use, y_use); 
hold on;
plot(x_use, p_fit(2) + p_fit(1)*x_use);

