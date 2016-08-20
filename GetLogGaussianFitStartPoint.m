function [Sigma, A, C, OmegaM] = GetLogGaussianFitStartPoint(Freq,Amp)

% Calculate smoothing factor according to the relative noise of the signal
%sm=500*std(Amp(1:30))/mean(Amp(1:30))
sm = 1;
AmpSm = smooth(Amp,sm);
[Mb,~]=max(Amp);
[Ms,IX]=max(AmpSm);
M = (1*Mb+0*Ms);
%[m,iX]=min(BareLWAmp);
m = mean(AmpSm(1:2));

Dist = Amp - m;
total = sum(Dist);
M1 = sum(Freq.*Dist)/total;
M2 = sum(Freq.^2.*Dist)/total;
mu = M1;
sigma = sqrt(M2 - M1^2);

[~,iHW1]=min(abs(Amp(1:IX)-(m+(M-m)/2)));
[~,iHW2]=min(abs(Amp(IX:end)-(m+(M-m)/2)));
[~,iHW3]=min(abs(Amp(1:IX)-(m+(M-m)/5)));
[~,iHW4]=min(abs(Amp(IX:end)-(m+(M-m)/5)));
[~,iHW5]=min(abs(AmpSm(1:IX)-(m+(M-m)/5)));
[~,iHW6]=min(abs(AmpSm(IX:end)-(m+(M-m)/5)));
CF = Freq(IX);
%FWHM1 = abs(Freq(iHW1)-Freq(iHW2+IX-1));
%FWHM2 = 0.5*abs(Freq(iHW3)-Freq(iHW4+IX-1));
%FWHM3 = 0.5*abs(Freq(iHW5)-Freq(iHW6+IX-1));

%FWHM = FWHM1;
%Sigma = FWHM/2.35;
Sigma = sigma;
A = M-m;
C = m;
CF = M1;
OmegaM = CF;
%StartPoint = [FWHM3 M-m m Freq(IX)];