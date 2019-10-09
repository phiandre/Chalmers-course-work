clear all; close all; clc;
lambda1 = csvread('lambda1_e.csv');
lambda2 = csvread('lambda2_e.csv');
lambda3 = csvread('lambda3_e.csv');

trange = linspace(1,1000,length(lambda1))';

plot(trange, lambda1, 'LineWidth', 1.5);
hold on;
plot(trange, lambda2, 'LineWidth', 1.5);
plot(trange, lambda3, 'LineWidth', 1.5);
ax = gca;
ax.FontSize = 20;
ax.XScale = 'log';
title('\sigma = 16, b=4, r = 46');
legend('\lambda_1(t)', '\lambda_2(t)', '\lambda_3(t)')
