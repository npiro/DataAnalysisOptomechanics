function [ data,paramsOut ] = ImportDataAndParseParams(FileName, ParamNames)

Dat = importdata(FileName);
Head = Dat.textdata;
data = Dat.data;

if isstr(ParamNames) 
    ParamNamesCell = {ParamNames};
else
    ParamNamesCell = ParamNames;
end
for n = 1:length(ParamNamesCell)
    ParamName = ParamNamesCell{n};
    patern = [ParamName,' = '];
    NewParamName = strrep(ParamName, '%', '%%');
    format = [NewParamName,' = %e'];
    
    
    
    matchline = '';
    res=strfind(Head,patern);
    for i=1:length(res)
        if (~isempty(res{i}))
            matchline=Head{i};
            break
        end
    end
    if ~isempty(matchline)
        A=sscanf(matchline,format);
        if isstr(ParamNames)
            paramsOut = A(1);
        else
            paramsOut{n} = A(1);
        end
    else
        if isstr(ParamNames)
            paramsOut = NaN;
        else
            paramsOut{n} = NaN;
        end
    end
end
