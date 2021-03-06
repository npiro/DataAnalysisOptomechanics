function [fitresult, gof, output] = LogLorentzianFit(Freq, Amp, StartPoint)
%CREATEFIT(BARELWFREQ,BARELWAMP)
%  Create a fit.
%
%  Data for 'untitled fit 1' fit:
%      X Input : Freq
%      Y Output: Amp
%  Output:
%      fitresult : a fit object representing the fit.
%      gof : structure with goodness-of fit info.
%
%  See also FIT, CFIT, SFIT.

%  Auto-generated by MATLAB on 08-Apr-2014 11:27:45


%% Fit: 'untitled fit 1'.
[xData, yData] = prepareCurveData( Freq, Amp );

% Set up fittype and options.
ft = fittype( 'log(c+a/(1+((x-x0)/(L/2))^2))', 'coefficients', {'L','a','c','x0'},'independent', 'x', 'dependent', 'y' );
opts = fitoptions( ft);

opts.Maxiter = 1000;
opts.Robust = 'Off';
%opts.Algorithm = 'Levenberg-Marquardt';
opts.Display = 'Off';
opts.TolFun = 1e-6;
opts.TolX = 1e-6;
opts.DiffMinChange = 1e-8;
opts.DiffMaxChange = 0.1;
opts.MaxFunEvals = 1000;
opts.Lower = [0 0 0 0];
opts.Upper = [Inf Inf Inf Inf];
% Calculate smoothing factor according to the relative noise of the signal
%sm=500*std(BareLWAmp(1:30))/mean(BareLWAmp(1:30));
%AmpSm = smooth(BareLWAmp,sm);
%[Mb,~]=max(BareLWAmp);
%[Ms,IX]=max(AmpSm);
%M = (0.0*Mb+1*Ms);
%[m,iX]=min(BareLWAmp);
%m = mean(AmpSm(1:10));

%[~,iHW1]=min(abs(BareLWAmp(1:IX)-(m+(M-m)/2)));
%[~,iHW2]=min(abs(BareLWAmp(IX:end)-(m+(M-m)/2)));
%[~,iHW3]=min(abs(BareLWAmp(1:IX)-(m+(M-m)/5)));
%[~,iHW4]=min(abs(BareLWAmp(IX:end)-(m+(M-m)/5)));
%[~,iHW5]=min(abs(AmpSm(1:IX)-(m+(M-m)/5)));
%[~,iHW6]=min(abs(AmpSm(IX:end)-(m+(M-m)/5)));
%CF = BareLWFreq(IX)
%FWHM = abs(BareLWFreq(iHW1)-BareLWFreq(iHW2+IX-1))
%FWHM2 = 0.5*abs(BareLWFreq(iHW3)-BareLWFreq(iHW4+IX-1))
%FWHM3 = 0.5*abs(BareLWFreq(iHW5)-BareLWFreq(iHW6+IX-1))
%opts.StartPoint = [FWHM3 M-m m BareLWFreq(IX)];
opts.StartPoint = StartPoint;



% Fit model to data.
[fitresult, gof, output] = fit( xData, log(yData), ft, opts );
% Plot fit with data.
%figure( 'Name', 'untitled fit 1' );
%yFitData = exp(fitresult(xData));
%h = plot(xData, yFitData, xData, yData );
%legend( h, 'BareLWAmp vs. BareLWFreq', 'untitled fit 1', 'Location', 'NorthEast' );
% Label axes
%xlabel( 'Frequency (Hz)' );
%%ylabel( 'Amplitude' );
%set(gca,'YScale','log');
%grid on


