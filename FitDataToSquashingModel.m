function FitDataToSquashingModel(hObject,handles)
ax = handles.SpectrumAxis;
axes(ax);
if handles.CursorsOn
    Curs = dualcursor;
    FreqStart = Curs(1);
    FreqStop = Curs(3);    
end
for i = 1:length(handles.data)
    
    if ~handles.fitted{i}
        handles.fitted{i} = 1;
        guidata(hObject, handles);
        data = handles.data{i};
        Freq = data(:,1);
        Amp = data(:,2);
        if handles.CursorsOn
            valid = Freq > FreqStart & Freq < FreqStop;
        else
            valid = (ones(1,length(Freq)) == 1);
        end
        fi = 0;
        GammaM = 7;
        [SxxMax,SxxNoise,OmegaM,g]=GetSquashingModelFitStartPoint(Freq,Amp,GammaM);
        StartPoint = [SxxMax,SxxNoise,OmegaM,g];
        [fit,gof]=SquashingModelFit(Freq(valid),Amp(valid),StartPoint,GammaM,fi);
        fitData=fit(Freq(valid));
        plot(Freq,Amp,'b',Freq(valid),fitData,'g');
        set(gca,'YScale','log');
        SxxNoise = fit.SxxNoise;
        SxxMax = fit.SxxMax;
        OmegaM = fit.OmegaM;
        g = fit.g;
        handles.g{i} = g;
        handles.OmegaM{i} = OmegaM;
        handles.SxxNoise{i} = SxxNoise;
        handles.SxxNoise{i} = SxxNoise;
        

        handles.Area{i} = pi/2 * GammaM/(1+g) * (SxxMax + g^2 * SxxNoise);

    end
end
guidata(hObject,handles);