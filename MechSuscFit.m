function [fitresult, gof, output] = MechSuscFit(BareLWFreq, BareLWAmp, StartPoint, FitParams)
%MechSuscFit(BareLWFreq, BareLWAmp, StartPoint, FitParams)
%  Create a fit.
%
%  Data for 'untitled fit 1' fit:
%      X Input : BareLWFreq
%      Y Output: BareLWAmp
%  Output:
%      fitresult : a fit object representing the fit.
%      gof : structure with goodness-of fit info.
%
%  See also FIT, CFIT, SFIT.

%  Auto-generated by MATLAB on 08-Apr-2014 11:27:45


%% Fit: 'untitled fit 1'.
[xData, yData] = prepareCurveData( BareLWFreq, BareLWAmp );

problemVars = {};
problemVals = {};
coefficients = {};
StartPointFinal = [];
if FitParams(2)
    problemVars{end+1} = 'L';
    problemVals{end+1} = StartPoint(1);
else
    coefficients{end+1} = 'L';
    StartPointFinal(end+1) = StartPoint(1);
end
if FitParams(4)
    problemVars{end+1} = 'a';
    problemVals{end+1} = StartPoint(2);
else
    coefficients{end+1} = 'a';
    StartPointFinal(end+1) = StartPoint(2);
end
if FitParams(3)
    problemVars{end+1} = 'c';
    problemVals{end+1} = StartPoint(3);
else
    coefficients{end+1} = 'c';
    StartPointFinal(end+1) = StartPoint(3);
end
if FitParams(1)
    problemVars{end+1} = 'x0';
    problemVals{end+1} = StartPoint(4);
else
    coefficients{end+1} = 'x0';
    StartPointFinal(end+1) = StartPoint(4);
end



% Set up fittype and options.
ft = fittype( 'log(c+a*(L*x0)^2./((L*x).^2+(x.^2-x0^2).^2))', 'coefficients', coefficients,'independent', 'x', 'dependent', 'y','problem',problemVars);
opts = fitoptions( ft);
opts.Display = 'Off';
opts.Maxiter = 600;
opts.Robust = 'Off';
%opts.Algorithm = 'Levenberg-Marquardt';
opts.TolFun = 1e-8;
opts.TolX = 1e-8;
opts.DiffMinChange = 1e-7;
opts.DiffMaxChange = 0.05;
opts.MaxFunEvals = 600;
opts.Lower = [0 0 0 0];
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
opts.StartPoint = StartPointFinal;
opts.Upper = [Inf Inf Inf Inf];


% Fit model to data.
[fitresult, gof, output] = fit( xData, log(yData), ft, opts ,'problem',problemVals);

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


