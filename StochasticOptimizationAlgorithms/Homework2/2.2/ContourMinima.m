clear all; close all; clc;
x = linspace(-5,5);
y = linspace(-5,5);

[X, Y] = meshgrid(x, y);

Z = log(0.01 +(X.^2 + Y - 11).^2 + (X + Y.^2 - 7).^2);

[M, c] = contour(X, Y, Z);
c.LineWidth = 2;
colormap winter;
colorbar;