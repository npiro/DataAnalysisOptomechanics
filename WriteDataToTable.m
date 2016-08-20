function WriteDataToTable(hObject,handles)
contents = cellstr(get(handles.ModelSelectionMenu,'String'));
model = contents{get(handles.ModelSelectionMenu,'Value')};
TableDat = get(handles.ResultsTable,'Data');
if length(TableDat) > 0
    oldPlot = TableDat(:,18);
else
    oldPlot = [];
end
switch model
    
    case {'Lorentzian','Mechanical susceptibility'}
        
         
        TableDat = {}; %TableDat(1:length(handles.Param),:);
        for i=1:length(handles.Param)
            TableDat(i,1) = handles.Param(i);
            TableDat(i,2) = handles.x0(i);
            TableDat(i,3) = handles.L(i);
            TableDat(i,4) = handles.c(i);
            TableDat(i,5) = handles.Amp(i);
            TableDat(i,6) = handles.Area(i);
            TableDat(i,7) = handles.AreaIntegrated(i);
            TableDat(i,8) = handles.n(i);
            TableDat(i,9) = handles.CalTone.Amp(i);
            TableDat(i,10) = handles.CalTone.c(i);
            TableDat(i,11) = handles.CalTone.L(i);
            TableDat(i,12) = handles.CalTone.x0(i);
            TableDat(i,13) = handles.CalTone.Area(i);
            TableDat(i,14) = handles.CalTone.AreaIntegrated(i);
            TableDat(i,15) = handles.cernox(i);
            TableDat(i,16) = handles.probe(i);
            TableDat(i,17) = handles.input6(i);
            if length(oldPlot) >= i
                TableDat(i,18) = oldPlot(i);
            else
                TableDat(i,18) = {true};
            end
            TableDat(i,19) = handles.fitted(i);
        end
        %TableDat = [handles.Param{1:end};handles.x0{1:end};handles.L{1:end};handles.c{1:end};handles.Amp{1:end};handles.Area{1:end};handles.AreaIntegrated{1:end};handles.n{1:end};...
        %    handles.CalTone.Amp{1:end};handles.CalTone.c{1:end};handles.CalTone.L{1:end};handles.CalTone.x0{1:end};handles.CalTone.Area{1:end};handles.CalTone.AreaIntegrated{1:end};handles.cernox{1:end};handles.probe{1:end};handles.input6{1:end};ones(1,length(handles.Area));ones(1,length(handles.Area))]';
    case 'Squashing model'
        TableDat = {}; %TableDat(1:length(handles.Param),:);
        for i=1:length(handles.Param)
            TableDat(i,1) = handles.Param(i);
            TableDat(i,2) = handles.OmegaM(i);
            TableDat(i,3) = handles.g(i);
            TableDat(i,4) = handles.SxxNoise(i);
            TableDat(i,5) = handles.SxxMax(i);
            TableDat(i,6) = handles.Area(i);
            TableDat(i,7) = handles.AreaIntegrated(i);
            TableDat(i,8) = handles.n(i);
            TableDat(i,9) = handles.CalTone.Amp(i);
            TableDat(i,10) = handles.CalTone.c(i);
            TableDat(i,11) = handles.CalTone.L(i);
            TableDat(i,12) = handles.CalTone.x0(i);
            TableDat(i,13) = handles.CalTone.Area(i);
            TableDat(i,14) = handles.CalTone.AreaIntegrated(i);
            TableDat(i,15) = handles.cernox(i);
            TableDat(i,16) = handles.probe(i);
            TableDat(i,17) = handles.input6(i);
            if length(oldPlot) > 0
                TableDat(i,18) = oldPlot(i);
            else
                TableDat(i,18) = {true};
            end
            
            TableDat(i,19) = handles.fitted(i);
        end
                %TableDat = [handles.Param{1:end};handles.OmegaM{1:end};handles.g{1:end};handles.SxxNoise{1:end};handles.SxxMax{1:end};handles.Area{1:end};handles.AreaIntegrated{1:end};handles.n{1:end};...
        %    handles.CalTone.Amp{1:end};handles.CalTone.c{1:end};handles.CalTone.L{1:end};handles.CalTone.x0{1:end};handles.CalTone.Area{1:end};handles.CalTone.AreaIntegrated{1:end};handles.cernox{1:end};handles.probe{1:end};handles.input6{1:end};ones(1,length(handles.Area));ones(1,length(handles.Area))]';
end

set(handles.ResultsTable,'Data',TableDat);

guidata(hObject,handles);