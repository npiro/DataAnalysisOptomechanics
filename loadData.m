function loadData(PathName,FileName,hObject,handles)
if ~isfield(handles,'data')
    NumSpec = 0;
else
    NumSpec = length(handles.data);
end

FullFileName = fullfile(PathName,FileName);
ParameterNames = {'cernox', 'probe', 'Input 6%','Output','LO'};
if strcmp(handles.extension,'.spe')
    [data,ParamsOut]=ImportDataAndParseParams(FullFileName,ParameterNames);
elseif strcmp(handles.extension,'.DAT')
    data = importdatfile(FullFileName);
    data(:,2) = 10.^(0.1*data(:,2));
    ParamsOut = {};
end
    
%data = dlmread(FullFileName);

loadCalTone=get(handles.LoadCalToneCheckbox,'Value');
haveCalTone = 0;
if loadCalTone
    CalToneFormat = get(handles.CalToneFilenameFormat,'String');
    A = sscanf(FileName,CalToneFormat);
    if length(A) >= 1
        param = A(1);
        foundParam = 0;
        haveCalTone = 1;
        for i = 1:length(handles.Param)
            if param == handles.Param{i}
                foundParam = 1;
                break;
            elseif param < handles.Param{i}
                foundParam = 0;
                break;
            end
        end
        
        if foundParam
            handles.dataCalTone{i} = data;
            handles.haveCalToneData{i} = true;
            handles.FileNameCalTone{i} = FileName;
        else
            i=i+1;
            handles.cernox = insertIntoCell(handles.cernox,ParamsOut{1},i);
            handles.probe = insertIntoCell(handles.probe,ParamsOut{2},i);
            handles.input6 = insertIntoCell(handles.input6,ParamsOut{3},i);
            handles.FileName = insertIntoCell(handles.FileName,0,i);
            handles.FileNameCalTone = insertIntoCell(handles.FileNameCalTone,FileName,i);
        
            handles.Param = insertIntoCell(handles.Param,param,i);
            handles.Amp = insertIntoCell(handles.Amp,0,i);
            handles.x0 = insertIntoCell(handles.x0,0,i);
            handles.L = insertIntoCell(handles.L,0,i);
            handles.c = insertIntoCell(handles.c,0,i);
            handles.n = insertIntoCell(handles.n,0,i);
            handles.Area = insertIntoCell(handles.Area,0,i);
            handles.AreaIntegrated = insertIntoCell(handles.AreaIntegrated,0,i);
            handles.data = insertIntoCell(handles.data,0,i);
            handles.fitted = insertIntoCell(handles.fitted,false,i);
            handles.OmegaM = insertIntoCell(handles.OmegaM,0,i);
            handles.g = insertIntoCell(handles.g,0,i);
            handles.SxxMax = insertIntoCell(handles.SxxMax,0,i);
            handles.SxxNoise = insertIntoCell(handles.SxxNoise,0,i);
            handles.fittedCalTone = insertIntoCell(handles.fittedCalTone,0,i);
            handles.CalTone.x0 = insertIntoCell(handles.CalTone.x0,0,i);
            handles.CalTone.c = insertIntoCell(handles.CalTone.c,0,i);
            handles.CalTone.Amp = insertIntoCell(handles.CalTone.Amp,0,i);
            handles.CalTone.L = insertIntoCell(handles.CalTone.L,0,i);
            handles.CalTone.Area = insertIntoCell(handles.CalTone.Area,0,i);
            handles.CalTone.AreaIntegrated = insertIntoCell(handles.CalTone.AreaIntegrated,0,i);
            handles.dataCalTone = insertIntoCell(handles.dataCalTone,data,i);
            handles.haveCalToneData = insertIntoCell(handles.haveCalToneData,true,i);
            handles.plotPoint = insertIntoCell(handles.plotPoint,true,i);
            
        end
        FreqCT = data(:,1);
        AmpCT = data(:,2);
        PlotCalToneSpectrum(handles,FreqCT,AmpCT);
    else
        param = 0;
        haveCalTone = 0;
    end
end

Format = get(handles.FileNameFormat,'String');
if ((loadCalTone && ~haveCalTone) || ~loadCalTone || strcmp(Format,CalToneFormat))
    
    A = sscanf(FileName,Format);
    if length(A) >= 1
        param = A(1);
    else
        param = 0;
    end
    Params = handles.Param;
    i=1;
    while i <= length(Params)
        if Params{i} >= param
            break;
        end
        i = i + 1;
    end
    if (~isempty(Params)) && loadCalTone && i <= length(Params) && Params{i} == param
        handles.data{i} = data;
        handles.FileName{i} = FileName;
    else
        if strcmp(handles.extension,'.spe')
            cernox = ParamsOut{1};
            probe = ParamsOut{2};
            input6 = ParamsOut{3};
        else
            cernox = 0;
            probe = 0;
            input6 = 0;
        end
        
        handles.cernox = insertIntoCell(handles.cernox,cernox,i);
        handles.probe = insertIntoCell(handles.probe,probe,i);
        handles.input6 = insertIntoCell(handles.input6,input6,i);
        
            
        handles.FileName = insertIntoCell(handles.FileName,FileName,i);
        handles.FileNameCalTone = insertIntoCell(handles.FileNameCalTone,0,i);
        
        handles.Param = insertIntoCell(handles.Param,param,i);
        handles.Amp = insertIntoCell(handles.Amp,0,i);
        handles.x0 = insertIntoCell(handles.x0,0,i);
        handles.L = insertIntoCell(handles.L,0,i);
        handles.c = insertIntoCell(handles.c,0,i);
        handles.n = insertIntoCell(handles.n,0,i);
        handles.Area = insertIntoCell(handles.Area,0,i);
        handles.AreaIntegrated = insertIntoCell(handles.AreaIntegrated,0,i);
        handles.data = insertIntoCell(handles.data,data,i);
        handles.fitted = insertIntoCell(handles.fitted,false,i);
        handles.OmegaM = insertIntoCell(handles.OmegaM,0,i);
        handles.g = insertIntoCell(handles.g,0,i);
        handles.SxxMax = insertIntoCell(handles.SxxMax,0,i);
        handles.SxxNoise = insertIntoCell(handles.SxxNoise,0,i);
        handles.dataCalTone = insertIntoCell(handles.dataCalTone,0,i);
        handles.haveCalToneData = insertIntoCell(handles.haveCalToneData,0,i);
        handles.fittedCalTone = insertIntoCell(handles.fittedCalTone,0,i);
        handles.CalTone.x0 = insertIntoCell(handles.CalTone.x0,0,i);
        handles.CalTone.c = insertIntoCell(handles.CalTone.c,0,i);
        handles.CalTone.Amp = insertIntoCell(handles.CalTone.Amp,0,i);
        handles.CalTone.L = insertIntoCell(handles.CalTone.L,0,i);
        handles.CalTone.Area = insertIntoCell(handles.CalTone.Area,0,i);
        handles.CalTone.AreaIntegrated = insertIntoCell(handles.CalTone.AreaIntegrated,0,i);
        handles.plotPoint = insertIntoCell(handles.plotPoint,true,i);    
    end
    Freq = data(:,1);
    Amp = data(:,2);
    PlotSpectrum(handles,Freq,Amp);
end

%handles.x0{NumSpec+1} = 0;
%handles.L{NumSpec+1} = 0;
%handles.c{NumSpec+1} = 0;
%handles.n{NumSpec+1} = 0;
%handles.Area{NumSpec+1} = 0;
%handles.data{NumSpec+1} = data;
%handles.fitted{NumSpec+1} = 0;
%handles.OmegaM{NumSpec+1} = 0;
%handles.g{NumSpec+1} = 0;
%handles.SxxMax{NumSpec+1} = 0;
%handles.SxxNoise{NumSpec+1} = 0;
handles.NumSpec = NumSpec+1;


if haveCalTone
    FreqCT = data(:,1);
    AmpCT = data(:,2);
    PlotCalToneSpectrum(handles,FreqCT,AmpCT);

end



guidata(hObject, handles);