function FitSelectedCalToneData(hObject,handles,SelInd)
% Fit the data in row SelInd of results table
ax = handles.CalToneAxis;
axes(ax);
if handles.CursorsOnCalTone
    Curs = dualcursor;
    FreqStart = Curs(1);
    FreqStop = Curs(3);
end

if ~handles.haveCalToneData{SelInd}
    return;
end
data = handles.dataCalTone{SelInd};
Freq = data(:,1);
Amp = data(:,2);
if handles.CursorsOnCalTone
    valid = Freq > FreqStart & Freq < FreqStop;
else
    valid = (true(1,length(Freq)));
end

sm = str2double(get(handles.SmoothFactorText,'String'));
Amp = smooth(Amp,sm);

contents = cellstr(get(handles.ModelSelectionMenu,'String'));
model=contents{get(handles.ModelSelectionMenu,'Value')};

        
fi = 0;
GammaM = 7;
        
if ~handles.fittedCalTone{SelInd}
    handles.fittedCalTone{SelInd} = 1;
    guidata(hObject, handles);
    
    [FWHM, A, C, OmegaM] = GetLogGaussianFitStartPoint(Freq(valid),Amp(valid));
    StartPoint = [FWHM, A, C, OmegaM];

    StartPoint0 = StartPoint;
    
    
else
    SelInd = handles.SelectedData;
    ResultsData = get(handles.ResultsTable,'Data');
    SelData = ResultsData(SelInd,:);

    StartPoint0 = [SelData(10),SelData(8),SelData(9),SelData(11)];
    StartPoint = StartPoint0;     

end

[fit,gof,out]=LogGaussianFit(Freq(valid),Amp(valid),StartPoint);

fit
%for p1 = 0.8:0.1:1.2
%    for p2 = 0.8:0.1:1.2
%[fit,gof, out]=LogLorentzianFit(Freq(valid),Amp(valid),StartPoint);
minres = sum((out.residuals).^2);
set(handles.SumOfResText,'String',num2str(minres));
if handles.DoOptimization
    NumIter=str2num(get(handles.OptimizationStepsText,'String'));
    
    for i = 1:NumIter
        Sigma = 0.5*(NumIter-i)/NumIter;
        p1 = random('norm',1,Sigma,[1,1]);
        p2 = random('norm',1,Sigma,[1,1]);
        p3 = random('norm',1,Sigma,[1,1]);
        
        StartPoint(1) = StartPoint0(1)*p1;
        StartPoint(2) = StartPoint0(2)*p2;
        StartPoint(3) = StartPoint0(3)*p3;

        [thisfit,thisgof, out]=LogGaussianFit(Freq(valid),Amp(valid),StartPoint);

        sumres = sum((out.residuals).^2);
        
        if sumres < minres
            minres = sumres;
            set(handles.SumOfResText,'String',num2str(minres));
            fit = thisfit;
            gof = thisgof;
            StartPoint0 = StartPoint;
            %        end
            %    end
        end
        set(handles.OptStepsCompletedText,'String',[num2str(i),'/',num2str(NumIter)]);
    end
    gof
end
%[fit,gof]=LogLorentzianFit(Freq(valid),Amp(valid),StartPoint);
fitAmp=fit(Freq(valid));
%if strcmp(model,'Lorentzian') || strcmp(model,'Mechanical susceptibility') 
    fitAmp = exp(fitAmp);
%end
plotCalToneDataAndFit(handles,Freq,Amp,Freq(valid),fitAmp);
confInt = confint(fit);
handles.confInt{SelInd} = confInt;

a = fit.a;
c = fit.c;
L = fit.L;
x0 = fit.x0;
handles.CalTone.Amp{SelInd} = a;
handles.CalTone.c{SelInd} = c;
handles.CalTone.L{SelInd} = L;
handles.CalTone.x0{SelInd} = x0;
handles.CalTone.Area{SelInd} = sqrt(2*pi)*L*a;


handles.CalTone.gof{SelInd} = gof;
handles.CalTone.fit{SelInd} = fit;
handles.CalTone.fitFreq{SelInd} = Freq(valid);
handles.CalTone.fitAmp{SelInd} = fitAmp;

guidata(hObject,handles);