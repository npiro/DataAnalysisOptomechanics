function f = MechSuscFunc(x,c,a,x0,L)
f = c+a*(L*x0)^2./((L*x).^2+(x.^2-x0^2).^2);