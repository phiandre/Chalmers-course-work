clear all; close all; clc;
q0 = csvread('q0.csv');
q1 = csvread('q1.csv');
q2 = csvread('q2.csv');

xrange = 1e-3:1e-3:2e-2;


figure(1);
scatter(log(1./xrange), q0, 'LineWidth', 2);
hold on;
scatter(log(1./xrange), q1, 'LineWidth', 2);
scatter(log(1./xrange), q2, 'LineWidth', 2);
set(0, 'defaultTextInterpreter', 'latex');
ax = gca;
ax.FontSize = 20;
xlabel('$\ln{\frac{1}{\epsilon}}$');
ylabel('$\frac{1}{1-q}\cdot\ln{I(q,\epsilon)}$');

p1 = polyfit(log(1./xrange), q0, 1);

p2 = polyfit(log(1./xrange), q1, 1);

p3 = polyfit(log(1./xrange), q2, 1);

plot( log(1./xrange), p1(2) + p1(1)*log(1./xrange));
plot( log(1./xrange), p2(2) + p2(1)*log(1./xrange));
plot( log(1./xrange), p3(2) + p3(1)*log(1./xrange));


legend('q_0', 'q_1', 'q_2');