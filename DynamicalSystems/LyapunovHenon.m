clear all; close all; clc;

a = 1.4;
b = 0.3;

nMax = 2e6;

transient = 1e3;

x = zeros(1, nMax);
y = zeros(1, nMax);

x(1) = 0.0;
y(1) = 0.0;

for iIter = 1:(nMax-1)
  x(iIter+1) = y(iIter) + 1 - a*x(iIter).^2;
  y(iIter+1) = b*x(iIter);
end

l1 = 0;
l2 = 0;
lambda1 = zeros(1, nMax);
lambda2 = zeros(1, nMax);

Q_old = eye(2);
M = eye(2);
Id = eye(2);

for iIter = 1:nMax
  J = [-2*a*x(iIter), 1; b, 0];
  M = J;
  [Q,R] = qr(M*transpose(Q_old));
  l1 = l1 + real(log(R(1,1)));
  l2 = l2 + real(log(R(2,2)));
  lambda1(iIter) = l1/iIter;
  lambda2(iIter) = l2/iIter;
  Q_old = Q;
end

l1 = l1/nMax;
l2 = l2/nMax;
%%
xrange = linspace(transient, nMax, nMax);

plot(xrange, lambda2);
ax = gca;
ax.XScale = 'log';
