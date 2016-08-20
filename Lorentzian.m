function f = Lorentzian(x,c,a,x0,L)
f = c+a./(1+((x-x0)/(L/2)).^2);