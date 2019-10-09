function gradient = Gradient(x1, x2, mu)
  if (x1^2+x2^2 >= 1)
    dfdx1 = 2*(x1-1)+2*mu*(x1^2+x2^2-1)*2*x1;
    dfdx2 = 4*(x2-2)+2*mu*(x1^2+x2^2-1)*2*x2;
    gradient = [dfdx1,dfdx2]';
  else
    dfdx1 = 2*(x1-1);
    dfdx2 = 2*(x2-2);
    gradient = [dfdx1,dfdx2]';
end