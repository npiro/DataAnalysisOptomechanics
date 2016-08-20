function [FWHM,FWHMstd,FWHMerr,width] = CalculateLorentzianWidth(x,y)

% Remove offset and make positive.
y = abs(y);
c = mean(y(1:20));
y = y - c;


%Find maximum
[M,MI]=max(y);

%Normalize
y = y/M;
plot(x,y);
% Calculate width at several points
i=0;
for R = 0.3:0.02:0.7
    i = i+1;
    a = abs(y-R);
    % Find first point
    [m1,m1i]=min(a);
    % Remove surrounding points
    a(m1i-5:m1i+5) = [];
    % Find second point
    [m2,m2i]=min(a);
    Delta = abs(x(m2i)-x(m1i));
    width(i) = sqrt(R/(1-R))*Delta/2;
end
FWHM = mean(width);
FWHMstd = std(width);
FWHMerr = FWHMstd/sqrt(i);
