function FitSelectedDataV2(hObject,handles,SelInd)
% Fit the data in row SelInd of results table
ax = handles.SpectrumAxis;
axes(ax);
if handles.CursorsOn
    Curs = dualcursor;
    FreqStart = Curs(1);
    FreqStop = Curs(3);
end

data = handles.data{SelInd};
Freq = data(:,1);
Amp = data(:,2);
if handles.CursorsOn
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
        
if ~handles.fitted{SelInd}
    handles.fitted{SelInd} = true;
    guidata(hObject, handles);
    switch model
        case {'Lorentzian','Mechanical susceptibility'}
            [FWHM, A, C, OmegaM] = GetLogLorentzianFitStartPoint(Freq(valid),Amp(valid));
            StartPoint = [FWHM, A, C, OmegaM];
        case 'Squashing model'
            [g,SxxMax,SxxNoise,OmegaM]=GetSquashingModelFitStartPoint(Freq(valid),Amp(valid),GammaM)
            StartPoint = [g,SxxMax,SxxNoise,OmegaM];
    end
    StartPoint0 = StartPoint;
    
    
else
    SelInd = handles.SelectedData;
    ResultsData = get(handles.ResultsTable,'Data');
    SelData = ResultsData(SelInd,:);
    switch model
        case {'Lorentzian','Mechanical susceptibility'}
            StartPoint0 = [SelData{3},SelData{5},SelData{4},SelData{2}];
            StartPoint = StartPoint0;     
        case 'Squashing model'
            StartPoint0 = [SelData{3},SelData{5},SelData{4},SelData{2}];
            StartPoint = StartPoint0
    end

end
switch model
    case 'Lorentzian'
        [fit,gof,out]=LogLorentzianFit(Freq(valid),Amp(valid),StartPoint);
    case 'Mechanical susceptibility'
        [fit,gof,out]=MechSuscFit(Freq(valid),Amp(valid),StartPoint);
    case 'Squashing model'
        [fit,gof,out]=SquashingModelFit(Freq(valid),Amp(valid),StartPoint,GammaM,fi);
end
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
        switch model
            case 'Lorentzian'
                [thisfit,thisgof, out]=LogLorentzianFit(Freq(valid),Amp(valid),StartPoint);
            case 'Mechanical susceptibility'
                [thisfit,thisgof,out]=MechSuscFit(Freq(valid),Amp(valid),StartPoint);
            case 'Squashing model'
                [thisfit,thisgof,out]=SquashingModelFit(Freq(valid),Amp(valid),StartPoint,GammaM,fi);
        end
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
plotDataAndFit(handles,Freq,Amp,Freq(valid),fitAmp);
confInt = confint(fit);
handles.confInt{SelInd} = confInt;
switch model
    case {'Lorentzian','Mechanical susceptibility'}
        a = fit.a;
        c = fit.c;
        L = fit.L;
        x0 = fit.x0;
        handles.Amp{SelInd} = a;
        handles.c{SelInd} = c;
        handles.L{SelInd} = L;
        handles.x0{SelInd} = x0;
        handles.Area{SelInd} = pi/2*L*a;
           
    case 'Squashing model'
        SxxMax = fit.SxxMax;
        ErrorSxxMax = confInt(4)-confInt(3);
        
        SxxNoise = fit.SxxNoise;
        
        OmegaM = fit.OmegaM;
        ErrorOmegaM = confInt(8)-confInt(7);
        g = fit.g;
        ErrorG = confInt(2)-confInt(1);
        handles.SxxMax{SelInd} = fit.SxxMax;
        handles.ErrorSxxMax{SelInd} = ErrorSxxMax;
        handles.SxxNoise{SelInd} = fit.SxxNoise;
        handles.OmegaM{SelInd} = fit.OmegaM;
        handles.ErrorOmegaM{SelInd} = ErrorOmegaM;
        handles.g{SelInd} = fit.g;
        handles.ErrorG{SelInd} = ErrorG;
        handles.Area{SelInd} = (pi+2*atan(2*OmegaM/((1+g)*GammaM)))/4 * GammaM/(1+g) * (SxxMax + g^2 * SxxNoise);
        handles.ErrorArea{SelInd} = handles.Area{SelInd}*(ErrorG^2/(1+g)*ErrorSxxMax/(SxxMax+g^2*SxxNoise));
end
handles.gof{SelInd} = gof;
handles.fit{SelInd} = fit;
handles.fitFreq{SelInd} = Freq(valid);
handles.fitAmp{SelInd} = fitAmp;

guidata(hObject,handles);