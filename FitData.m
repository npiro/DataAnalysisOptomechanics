function FitData(hObject,handles)

contents = cellstr(get(handles.ModelSelectionMenu,'String'));
model = contents{get(handles.ModelSelectionMenu,'Value')};
            
for i = 1:length(handles.data)
    
    if ~handles.fitted{i}
        
        if true
            FitSelectedData(hObject,handles,i);
        else
            ax = handles.SpectrumAxis;
            axes(ax);
            if handles.CursorsOn
                Curs = dualcursor;
                FreqStart = Curs(1);
                FreqStop = Curs(3);    
            end
            data = handles.data{i};
            Freq = data(:,1);
            Amp = data(:,2);
            if handles.CursorsOn
                valid = Freq > FreqStart & Freq < FreqStop;
            else
                valid = (ones(1,length(Freq)) == 1);
            end
            [FWHM, A, C, OmegaM] = GetLogLorentzianFitStartPoint(Freq(valid),Amp(valid));
            StartPoint = [FWHM, A, C, OmegaM];
            contents = cellstr(get(handles.ModelSelectionMenu,'String'));
            model = contents{get(handles.ModelSelectionMenu,'Value')};
            switch model
                case 'Lorentzian'
                    [fit,gof,out]=LogLorentzianFit(Freq(valid),Amp(valid),StartPoint);
                    fitAmp=exp(fit(Freq(valid)));
                case 'Mechanical susceptibility'
                    [fit,gof,out]=MechSuscFit(Freq(valid),Amp(valid),StartPoint);
                    fitAmp = fit(Freq(valid));
            end
            plotDataAndFit(handles,Freq,Amp,Freq(valid),fitAmp);
            
            
            
            a = fit.a;
            c = fit.c;
            L = fit.L;
            x0 = fit.x0;
            handles.Amp{i} = a;
            handles.c{i} = c;
            handles.L{i} = L;
            handles.x0{i} = x0;
            handles.Area{i} = pi/2*L*a;
            handles.fit{i} = fit;
            handles.fitFreq{i} = Freq(valid);
            handles.fitAmp{i} = fitAmp;
            
        end
        handles = guidata(hObject);
    end
    handles.fitted{i} = 1;
    
    handles = guidata(hObject);
    WriteDataToTable(hObject,handles);
end
guidata(hObject,handles);