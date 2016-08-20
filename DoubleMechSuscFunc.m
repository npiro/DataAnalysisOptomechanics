function [ f ] = DoubleMechSuscFunc( G1,G2,a1,a2,c,x01,x02,x )
%DoubleMechSuscFunc Two interferening modes
%   
f = c+(a2*G2^2*(G1^2*x.^2 + (x.^2 - x01^2).^2)*x02^2 + 2*sqrt(a1)*sqrt(a2)*G1*G2*x01*x02*(G1*G2*x.^2 + (x - x01).*(x + x01).*(x - x02).*(x + x02)) + a1*G1^2*x01^2*(G2^2*x.^2 + (x.^2 - x02^2).^2))./((G1^2*x.^2 + (x.^2 - x01^2).^2).*(G2^2*x.^2 + (x.^2 - x02^2).^2));

end

