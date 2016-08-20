function varargout = MechanicsAnalyzer(varargin)
% MECHANICSANALYZER MATLAB code for MechanicsAnalyzer.fig
%      MECHANICSANALYZER, by itself, creates a new MECHANICSANALYZER or raises the existing
%      singleton*.
%
%      H = MECHANICSANALYZER returns the handle to a new MECHANICSANALYZER or the handle to
%      the existing singleton*.
%
%      MECHANICSANALYZER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MECHANICSANALYZER.M with the given input arguments.
%
%      MECHANICSANALYZER('Property','Value',...) creates a new MECHANICSANALYZER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before MechanicsAnalyzer_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to MechanicsAnalyzer_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help MechanicsAnalyzer

% Last Modified by GUIDE v2.5 10-Nov-2014 16:27:19

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @MechanicsAnalyzer_OpeningFcn, ...
                   'gui_OutputFcn',  @MechanicsAnalyzer_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before MechanicsAnalyzer is made visible.
function MechanicsAnalyzer_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to MechanicsAnalyzer (see VARARGIN)

% Choose default command line output for MechanicsAnalyzer
handles.output = hObject;
handles.haveCTCorrection = false;
handles.CursorsOn = false;
handles.CursorsOnCalTone = false;
handles.havecalibration = false;
handles.haveoccupationcalibration = false;
handles.DoOptimization = false;
handles.x0 = {};
handles.Amp = {};
handles.Area = {};
handles.OmegaM = {};
handles.SxxMax = {};
handles.SxxNoise = {};
handles.g = {};
handles.Amp = {};
handles.Area = {};
handles.AreaIntegrated = {};
handles.L = {};
handles.c = {};
handles.n = {};
handles.Param = {};
handles.data = {};
handles.dataCalTone = {};
handles.FileName = {};
handles.FileNameCalTone = {};
handles.fitted = {};
handles.fittedCalTone = {};
handles.haveCalToneData = {};
handles.CalTone.x0 = {};
handles.CalTone.c = {};
handles.CalTone.L = {};
handles.CalTone.Area = {};
handles.CalTone.AreaIntegrated = {};
handles.CalTone.Amp = {};
handles.cernox = {};
handles.probe = {};
handles.input6 = {};
handles.plotPoint = {};
handles.MonitorTimer = timer('ExecutionMode','fixedDelay','Period', 4.0);
handles.MonitorTimer.TimerFcn = {@MonitorCallback,hObject,handles};
set(handles.ResultsTable,'Data',{});
handles.extension = '.DAT';

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes MechanicsAnalyzer wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = MechanicsAnalyzer_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in loadDataBut.
function loadDataBut_Callback(hObject, eventdata, handles)
% hObject    handle to loadDataBut (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

LoadNewFiles(hObject,handles);
handles = guidata(hObject);
guidata(hObject, handles);

% --- Executes on button press in fitDataBut.
function fitDataBut_Callback(hObject, eventdata, handles)
% hObject    handle to fitDataBut (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
contents = cellstr(get(handles.ModelSelectionMenu,'String'));
model=contents{get(handles.ModelSelectionMenu,'Value')};
FitData(hObject,handles);
handles = guidata(hObject);
FitCalToneData(hObject,handles);

handles = guidata(hObject);
WriteDataToTable(hObject,handles);
%set(handles.ResultsTable,'Data',TableDat);

PlotResults(hObject,handles);
guidata(hObject, handles);

% --- Executes on button press in MonitorDir.
function MonitorDir_Callback(hObject, eventdata, handles)
% hObject    handle to MonitorDir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of MonitorDir
MonitorDir = get(hObject,'Value');
handles.MonitorDir = MonitorDir;
t = handles.MonitorTimer;
if (MonitorDir)
    
    start(t);
else
    stop(t);
end
guidata(hObject,handles);


% --- Executes on selection change in FileListBox.
function FileListBox_Callback(hObject, eventdata, handles)
% hObject    handle to FileListBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns FileListBox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from FileListBox
contents = cellstr(get(hObject,'String'));
FileName = contents{get(hObject,'Value')};
PathName = handles.FilePath;
FileExists = 0;
if isfield(handles,'FileName')
    for i=1:length(handles.FileName)
        if strcmp(FileName,handles.FileName{i}) || strcmp(FileName,handles.FileNameCalTone{i})
            FileExists = 1;
        end
    end
end
if ~FileExists
    
    loadData(PathName,FileName,hObject,handles);
    handles = guidata(hObject);

    %handles = guidata(hObject);
    WriteDataToTable(hObject,handles);
    %set(handles.ResultsTable,'Data',TableDat);

end
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function FileListBox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FileListBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in LoadDirBut.
function LoadDirBut_Callback(hObject, eventdata, handles)
% hObject    handle to LoadDirBut (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ~isfield(handles,'FilePath')
    FilePath = '.';
else
    FilePath = handles.FilePath;
end
FolderName = uigetdir(FilePath);
handles.FilePath = FolderName;

load_listbox(hObject, handles,FolderName);
guidata(hObject, handles);

% --- Executes on button press in AutoFitCheck.
function AutoFitCheck_Callback(hObject, eventdata, handles)
% hObject    handle to AutoFitCheck (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of AutoFitCheck


% --- Executes during object creation, after setting all properties.
function ResultsTable_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ResultsTable (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



function FileNameFormat_Callback(hObject, eventdata, handles)
% hObject    handle to FileNameFormat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of FileNameFormat as text
%        str2double(get(hObject,'String')) returns contents of FileNameFormat as a double


% --- Executes during object creation, after setting all properties.
function FileNameFormat_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FileNameFormat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes when entered data in editable cell(s) in ResultsTable.
function ResultsTable_CellEditCallback(hObject, eventdata, handles)
% hObject    handle to ResultsTable (see GCBO)
% eventdata  structure with the following fields (see UITABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)

TableDat=get(hObject,'Data'); % get the data cell array of the table
cols=get(hObject,'ColumnFormat'); % get the column formats
colNames = get(hObject,'ColumnName');
ind = eventdata.Indices;
if length(ind) >= 1
    if strcmp(cols(ind(2)),'logical') % if the column of the edited cell is logical
        if eventdata.EditData % if the checkbox was set to true
            TableDat{eventdata.Indices(1),eventdata.Indices(2)}=true; % set the data value to true
        else % if the checkbox was set to false
            TableDat{eventdata.Indices(1),eventdata.Indices(2)}=false; % set the data value to false
        end
    end
    set(hObject,'Data',TableDat); % now set the table's data to the updated data cell array
    handles.TableDat = TableDat;
    %WriteDataToTable(hObject,handles);
    guidata(hObject,handles);
    
    %handles = guidata(hObject);
    
    
    
    
    if strcmp(colNames(ind(2)),'Fitted')
        for i=1:length(handles.fitted)
            handles.fitted{i} = TableDat{i,ind(2)};
        end
    elseif strcmp(colNames(ind(2)),'Plot')
        for i=1:length(handles.plotPoint)
            handles.plotPoint{i} = TableDat{i,ind(2)};
        end
    end
    guidata(hObject,handles);
    
    row = ind(1);
    NumSpec = row;
    handles.SelectedData = NumSpec;
    data = handles.data{NumSpec};
    
    
    Freq = data(:,1);
    Amp = data(:,2);
    fitFreq = Freq;
    
    ResultsData = get(handles.ResultsTable,'Data');
    SelData = ResultsData(NumSpec,:);
    
    contents = cellstr(get(handles.ModelSelectionMenu,'String'));
    model=contents{get(handles.ModelSelectionMenu,'Value')};
    switch model
        case 'Lorentzian'
            L = SelData{3};
            a = SelData{5};
            c = SelData{4};
            x0 = SelData{2};
            fitAmp = Lorentzian(Freq,c,a,x0,L);
        case 'Mechanical susceptibility'
            L = SelData{3};
            a = SelData{5};
            c = SelData{4};
            x0 = SelData{2};
            fitAmp = MechSuscFunc(Freq,c,a,x0,L);
        case 'Squashing model'
            g = SelData{3};
            SxxMax = SelData{5};
            SxxNoise = SelData{4};
            OmegaM = SelData{2};
            fi = 0;
            GammaM = 7.8;
            fitAmp = SquashingModelFunc(Freq,SxxMax,SxxNoise,g,fi,OmegaM,GammaM);
    end
    
    axes(handles.SpectrumAxis)
    plotDataAndFit(handles,Freq,Amp,fitFreq,fitAmp);
end
guidata(hObject,handles);


% --- Executes when selected cell(s) is changed in ResultsTable.
function ResultsTable_CellSelectionCallback(hObject, eventdata, handles)
% hObject    handle to ResultsTable (see GCBO)
% eventdata  structure with the following fields (see UITABLE)
%	Indices: row and column indices of the cell(s) currently selecteds
% handles    structure with handles and user data (see GUIDATA)

ind = eventdata.Indices;
if length(ind) >= 1
    row = ind(1);
    NumSpec = row;
    handles.SelectedData = NumSpec;
    data = handles.data{NumSpec};
    
    
    Freq = data(:,1);
    Amp = data(:,2);
    
    
    ax = handles.SpectrumAxis;
    axes(ax);
    if handles.fitted{NumSpec}
        fitFreq = handles.fitFreq{NumSpec};
        fitAmp = handles.fitAmp{NumSpec};
        plotDataAndFit(handles,Freq,Amp,fitFreq,fitAmp);
        
    else
        PlotSpectrum(handles,Freq,Amp);
        
    end
    if handles.haveCalToneData{NumSpec}
        if handles.fittedCalTone{NumSpec}
            fitFreq = handles.CalTone.fitFreq{NumSpec};
            fitAmp = handles.CalTone.fitAmp{NumSpec};
            FreqCT = handles.dataCalTone{NumSpec}(:,1);
            AmpCT = handles.dataCalTone{NumSpec}(:,2);
            plotCalToneDataAndFit(handles,FreqCT,AmpCT,fitFreq,fitAmp);
            
        else
            FreqCT = handles.dataCalTone{NumSpec}(:,1);
            AmpCT = handles.dataCalTone{NumSpec}(:,2);
            PlotCalToneSpectrum(handles,FreqCT,AmpCT);
            
        end
    end
    guidata(hObject,handles);
else
    %warndlg('Bad row selected');
end

% --- Executes on button press in OptimizeFitCheck.
function OptimizeFitCheck_Callback(hObject, eventdata, handles)
% hObject    handle to OptimizeFitCheck (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of OptimizeFitCheck

if get(hObject,'Value') 
    handles.DoOptimization = true;
else
    handles.DoOptimization = false;
end
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function AxisTypeGamma_CreateFcn(hObject, eventdata, handles)
% hObject    handle to AxisTypeGamma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in AxisTypeGamma.
function AxisTypeGamma_Callback(hObject, eventdata, handles)
% hObject    handle to AxisTypeGamma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns AxisTypeGamma contents as cell array
%        contents{get(hObject,'Value')} returns selected item from AxisTypeGamma
PlotResults(hObject,handles);

% --- Executes on selection change in AxisTypeOmega.
function AxisTypeOmega_Callback(hObject, eventdata, handles)
% hObject    handle to AxisTypeOmega (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns AxisTypeOmega contents as cell array
%        contents{get(hObject,'Value')} returns selected item from AxisTypeOmega
PlotResults(hObject,handles);

% --- Executes during object creation, after setting all properties.
function AxisTypeOmega_CreateFcn(hObject, eventdata, handles)
% hObject    handle to AxisTypeOmega (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in AxisTypeArea.
function AxisTypeArea_Callback(hObject, eventdata, handles)
% hObject    handle to AxisTypeArea (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns AxisTypeArea contents as cell array
%        contents{get(hObject,'Value')} returns selected item from AxisTypeArea
PlotResults(hObject,handles);

% --- Executes during object creation, after setting all properties.
function AxisTypeArea_CreateFcn(hObject, eventdata, handles)
% hObject    handle to AxisTypeArea (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in AxisTypeSpectrum.
function AxisTypeSpectrum_Callback(hObject, eventdata, handles)
% hObject    handle to AxisTypeSpectrum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns AxisTypeSpectrum contents as cell array
%        contents{get(hObject,'Value')} returns selected item from AxisTypeSpectrum
data = handles.data{handles.SelectedData};

 
Freq = data(:,1);
Amp = data(:,2);
PlotSpectrum(handles,Freq,Amp);

% --- Executes during object creation, after setting all properties.
function AxisTypeSpectrum_CreateFcn(hObject, eventdata, handles)
% hObject    handle to AxisTypeSpectrum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in DelDataBut.
function DelDataBut_Callback(hObject, eventdata, handles)
% hObject    handle to DelDataBut (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.FileName = {};
handles.FileNameCalTone = {};
handles.Param = {};
handles.data = {};
handles.dataCalTone = {};
handles.fitted = {};
handles.fittedCalTone = {};
handles.haveCalToneData = {};
handles.NumSpec = {};
handles.OmegaM = {};
handles.SxxMax = {};
handles.SxxNoise = {};
handles.g = {};
handles.x0 = {};
handles.Amp = {};
handles.L = {};
handles.Area = {};
handles.CorrectedArea = {};
handles.c = {};
handles.n = {};
handles.AreaIntegrated = {};
handles.nIntegrated = {};
handles.CalTone.x0 = {};
handles.CalTone.c = {};
handles.CalTone.L = {};
handles.CalTone.Area = {};
handles.CalTone.AreaIntegrated = {};
handles.CalTone.Amp = {};
handles.plotPoint = {};
handles.cernox = {};
handles.probe = {};
handles.input6 = {};
guidata(hObject,handles);
WriteDataToTable(hObject,handles);

%contents = cellstr(get(handles.ModelSelectionMenu,'String'));
%model = contents{get(handles.ModelSelectionMenu,'Value')};

%switch model
%    case {'Lorentzian','Mechanical susceptibility'}
%        TableDat = [handles.Param{1:end};handles.x0{1:end};handles.L{1:end};handles.c{1:end};handles.Amp{1:end};handles.Area{1:end};handles.n{1:end};true(1,length(handles.Area))]';
%    case 'Squashing model'
%        TableDat = [handles.Param{1:end};handles.OmegaM{1:end};handles.g{1:end};handles.SxxNoise{1:end};handles.SxxMax{1:end};handles.Area{1:end};zeros(1,length(handles.Area));true(1,length(handles.Area))]';
%end
%set(handles.ResultsTable,'Data',TableDat);

guidata(hObject,handles);


% --- Executes on button press in CursorCheckBox.
function CursorCheckBox_Callback(hObject, eventdata, handles)
% hObject    handle to CursorCheckBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of CursorCheckBox
axes(handles.SpectrumAxis);
if (get(hObject,'Value'))
    dualcursor on;
    handles.CursorsOn = true;
else
    dualcursor off;
    handles.CursorsOn = false;
    
end    
guidata(hObject,handles);


% --- Executes on selection change in ModelSelectionMenu.
function ModelSelectionMenu_Callback(hObject, eventdata, handles)
% hObject    handle to ModelSelectionMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns ModelSelectionMenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from ModelSelectionMenu
contents = cellstr(get(hObject,'String'));
model = contents{get(hObject,'Value')};
ColNames = get(handles.ResultsTable,'ColumnName');
switch model
    case 'Lorentzian'
        ColNames{3} = 'Gamma';
        ColNames{4} = 'Noise floor';
        ColNames{5} = 'Amplitude';
        set(handles.ResultsTable,'ColumnName',ColNames);
    case 'Squashing model'
        ColNames{3} = 'Gain';
        ColNames{4} = 'Noise floor';
        ColNames{5} = 'Amplitude';
        set(handles.ResultsTable,'ColumnName',ColNames);
end
get(handles.ResultsTable,'ColumnName')

% --- Executes during object creation, after setting all properties.
function ModelSelectionMenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ModelSelectionMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- Executes during object creation, after setting all properties.
function TemperatureText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TemperatureText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in CalibratePSDbut.
function CalibratePSDbut_Callback(hObject, eventdata, handles)
% hObject    handle to CalibratePSDbut (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp = str2double(get(handles.TemperatureText,'String'));
calspectrumNum = handles.SelectedData;
mechfreq = handles.x0{calspectrumNum};
kb=1.3806488e-23;
hbar=1.0545717e-34;
n=kb*temp/(hbar*mechfreq);
peak = max(handles.data{calspectrumNum}(:,2));
%peak = handles.a{calspectrumNum};
handles.calfactor = 2*n/peak;
handles.havecalibration = true;
guidata(hObject,handles);
%xZPM2 = hbar/(meff*mechfreq);



function TemperatureText_Callback(hObject, eventdata, handles)
% hObject    handle to TemperatureText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of TemperatureText as text
%        str2double(get(hObject,'String')) returns contents of TemperatureText as a double



% --- Executes on button press in CalOccupationBut.
function CalOccupationBut_Callback(hObject, eventdata, handles)
% hObject    handle to CalOccupationBut (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

UseFit = get(handles.UseFitCheck,'Value'); % True to use fit, false to use intergrated area
CalculateOccupation = get(handles.CalculateOccupationCheck,'Value'); % True to calculate occupation, false to calculate temp
CorrectInitialDamping = get(handles.UseGammaCorrectionCheck,'Value'); % Correct for an initial damping, i.e. due to bolometric force or DBA
temp = str2double(get(handles.TemperatureText,'String'));
calspectrumNum = handles.SelectedData;
contents = cellstr(get(handles.ModelSelectionMenu,'String'));
model = contents{get(handles.ModelSelectionMenu,'Value')};
switch model
    case {'Lorentzian','Mechanical susceptibility'}
        mechfreq = handles.x0{calspectrumNum};
    case 'Squashing model'
        mechfreq = handles.OmegaM{calspectrumNum};
        handles.MaxSxxNoGain = handles.SxxMax;

end
if handles.haveCTCorrection
    area = handles.CorrectedArea{calspectrumNum};
else
    area = handles.Area{calspectrumNum};
end



GammaMint = str2double(get(handles.IntrinsicGammaText,'String'));
%GammaMint = 1.43e3;
kb=1.3806488e-23;
hbar=1.0545717e-34;
if (CalculateOccupation)
    n=kb*temp/(hbar*2*pi*mechfreq);
else
    n=temp;
end
if (CorrectInitialDamping)
    switch model
        case {'Lorentzian','Mechanical susceptibility'}
            n = n * GammaMint/handles.L{calspectrumNum};
        case 'Squashing model'
            GammaEff = GammaMint*(1+handles.g{calspectrumNum});
            n = n * GammaMint/GammaEff;
    end
end

if (UseFit)
    handles.occupationcalfactor = n/area;
else
    ax = handles.SpectrumAxis;
    axes(ax);
    if handles.CursorsOn
        Curs = dualcursor;
        FreqStart = Curs(1);
        FreqStop = Curs(3);
    end

    data = handles.data{calspectrumNum};
    Freq = data(:,1);
    Amp = data(:,2);
    if handles.CursorsOn
        valid = Freq > FreqStart & Freq < FreqStop;
    else
        valid = (true(1,length(Freq)));
    end
    spect = Amp(valid);
    spectMinusBG = spect-handles.c{calspectrumNum};
    area2 = sum(spectMinusBG);
    handles.occupationcalfactor = n/area2;
end
handles.haveoccupationcalibration = true;
for i=1:length(handles.Area)
    if (UseFit)
        if handles.haveCTCorrection
            handles.n{i} = handles.CorrectedArea{i}*handles.occupationcalfactor;
        else
            handles.n{i} = handles.Area{i}*handles.occupationcalfactor;
        end
    else
        Amp = handles.data{i}(:,2);
        spect = Amp(valid);
        spectMinusBG = spect-handles.c{i};
        area = sum(spectMinusBG);
        handles.n{i} = area*handles.occupationcalfactor;
    end
end
WriteDataToTable(hObject,handles);
guidata(hObject,handles);


% --- Executes on button press in FitSelectionBut.
function FitSelectionBut_Callback(hObject, eventdata, handles)
% hObject    handle to FitSelectionBut (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if (isfield(handles,'SelectedData'))
    SelInd = handles.SelectedData;
    FitSelectedData(hObject,handles,SelInd)
    handles = guidata(hObject);
    WriteDataToTable(hObject,handles);
else
    warndlg('Select a row in the Results table first');
end
handles = guidata(hObject);

%contents = cellstr(get(handles.ModelSelectionMenu,'String'));
%model=contents{get(handles.ModelSelectionMenu,'Value')};
%switch model
%    case {'Lorentzian','Mechanical susceptibility'}
%        TableDat = [handles.Param{1:end};handles.x0{1:end};handles.L{1:end};handles.c{1:end};handles.Amp{1:end};handles.Area{1:end};zeros(1,length(handles.Area));true(1,length(handles.Area))]';      
%    case 'Squashing model'   
%        TableDat = [handles.Param{1:end};handles.OmegaM{1:end};handles.g{1:end};handles.SxxNoise{1:end};handles.SxxMax{1:end};handles.Area{1:end};zeros(1,length(handles.Area));true(1,length(handles.Area))]';
%end
%set(handles.ResultsTable,'Data',TableDat);
WriteDataToTable(hObject,handles);
PlotResults(hObject,handles);
guidata(hObject, handles);



function SmoothFactorText_Callback(hObject, eventdata, handles)
% hObject    handle to SmoothFactorText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of SmoothFactorText as text
%        str2double(get(hObject,'String')) returns contents of SmoothFactorText as a double


% --- Executes during object creation, after setting all properties.
function SmoothFactorText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SmoothFactorText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function OptimizationStepsText_Callback(hObject, eventdata, handles)
% hObject    handle to OptimizationStepsText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of OptimizationStepsText as text
%        str2double(get(hObject,'String')) returns contents of OptimizationStepsText as a double


% --- Executes during object creation, after setting all properties.
function OptimizationStepsText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to OptimizationStepsText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function SumOfResText_Callback(hObject, eventdata, handles)
% hObject    handle to SumOfResText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of SumOfResText as text
%        str2double(get(hObject,'String')) returns contents of SumOfResText as a double


% --- Executes during object creation, after setting all properties.
function SumOfResText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SumOfResText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function MonitorCallback(obj, event, hObject, handles)

handles = guidata(hObject);
txt1 = ' event occurred at ';


event_type = event.Type;
event_time = datestr(event.Data.time);

msg = [event_type txt1 event_time];
disp(msg)
if ~isfield(handles,'FilePath')
    FilePath = '.';
    %stop(handles.MonitorTimer);
    %FolderName = uigetdir(FilePath);
    %handles.FilePath = FolderName;
    %start(handles.MonitorTimer);
    FolderName = FilePath;
    handles.FilePath = FolderName;
    guidata(hObject,handles);
else
    FolderName = handles.FilePath;
end

load_listbox(hObject,handles,FolderName);
handles = guidata(hObject);
LoadNewFiles(hObject,handles);
handles = guidata(hObject);
if get(handles.AutoFitCheck,'Value')
    FitData(hObject,handles);
    PlotResults(hObject,handles);
end
handles = guidata(hObject);
guidata(hObject,handles);

% --- Executes on selection change in XAxisAreaPlot.
function XAxisAreaPlot_Callback(hObject, eventdata, handles)
% hObject    handle to XAxisAreaPlot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns XAxisAreaPlot contents as cell array
%        contents{get(hObject,'Value')} returns selected item from XAxisAreaPlot


% --- Executes during object creation, after setting all properties.
function XAxisAreaPlot_CreateFcn(hObject, eventdata, handles)
% hObject    handle to XAxisAreaPlot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in CopyAreaPlotBut.
function CopyAreaPlotBut_Callback(hObject, eventdata, handles)
% hObject    handle to CopyAreaPlotBut (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
addpath('imclipboard');

% --- Executes on button press in SaveAreaPlotBut.
function SaveAreaPlotBut_Callback(hObject, eventdata, handles)
% hObject    handle to SaveAreaPlotBut (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

addpath('export_fig');
axArea = handles.AreaAxis;
[FileName, PathName] = uiputfile('.', 'Save As'); 
Name = fullfile(PathName,[FileName,'.pdf']);
export_fig(Name,axArea,'-pdf');

Fig2 = figure;
copyobj(axArea, Fig2);
hgsave(Fig2, [FileName,'.fig'] );
close(Fig2);

%[FileName, PathName] = uiputfile('*.fig', 'Save As'); 
%Name = fullfile(PathName,FileName);  
%if PathName==0, return; end    
%imwrite(img, Name, 'bmp');

% --- Executes on button press in CopyGammaPlotBut.
function CopyGammaPlotBut_Callback(hObject, eventdata, handles)
% hObject    handle to CopyGammaPlotBut (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in SaveGammaPlotBut.
function SaveGammaPlotBut_Callback(hObject, eventdata, handles)
% hObject    handle to SaveGammaPlotBut (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

addpath('export_fig');
axGamma = handles.GammaAxis;
[FileName, PathName] = uiputfile('.', 'Save As'); 
Name = fullfile(PathName,[FileName,'.pdf']); 
export_fig(Name,axGamma,'-pdf');

Fig2 = figure;
copyobj(axGamma, Fig2);
hgsave(Fig2, [FileName,'.fig'] );
close(Fig2);


% --- Executes on button press in CopyResBut.
function CopyResBut_Callback(hObject, eventdata, handles)
% hObject    handle to CopyResBut (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
TableDat=get(handles.ResultsTable,'Data');
save('TableDat');
assignin('base', 'TableDat', TableDat);
clipboard('copy',TableDat);

% --- Executes on button press in SaveResBut.
function SaveResBut_Callback(hObject, eventdata, handles)
% hObject    handle to SaveResBut (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
TableDat=get(handles.ResultsTable,'Data');
[FileName,PathName,FilterIndex] = uiputfile('.txt','Choose file name');
Name = fullfile(PathName,FileName); 
dlmwrite(Name,TableDat);



function CalToneFilenameFormat_Callback(hObject, eventdata, handles)
% hObject    handle to CalToneFilenameFormat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of CalToneFilenameFormat as text
%        str2double(get(hObject,'String')) returns contents of CalToneFilenameFormat as a double


% --- Executes during object creation, after setting all properties.
function CalToneFilenameFormat_CreateFcn(hObject, eventdata, handles)
% hObject    handle to CalToneFilenameFormat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in LoadCalToneCheckbox.
function LoadCalToneCheckbox_Callback(hObject, eventdata, handles)
% hObject    handle to LoadCalToneCheckbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of LoadCalToneCheckbox


% --- Executes on selection change in AxisTypeCalTone.
function AxisTypeCalTone_Callback(hObject, eventdata, handles)
% hObject    handle to AxisTypeCalTone (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns AxisTypeCalTone contents as cell array
%        contents{get(hObject,'Value')} returns selected item from AxisTypeCalTone


% --- Executes during object creation, after setting all properties.
function AxisTypeCalTone_CreateFcn(hObject, eventdata, handles)
% hObject    handle to AxisTypeCalTone (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in CalToneCorrectBut.
function CalToneCorrectBut_Callback(hObject, eventdata, handles)
% hObject    handle to CalToneCorrectBut (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
RefInd = handles.SelectedData; % Index to reference cal tone data
if (handles.fittedCalTone{RefInd})
    AreaCTRef = handles.CalTone.Area{RefInd};
    haveRefCT = true;
else
    haveRefCT = false;
end
if haveRefCT
    for i=1:length(handles.Area)
        if handles.fittedCalTone{i}
            AreaCT = handles.CalTone.Area{i};
            handles.CorrectedArea{i} = handles.Area{i}/AreaCT*AreaCTRef;
        end
    end
    handles.haveCTCorrection = true;
end
guidata(hObject,handles);

% --- Executes on button press in FitSelectedCalToneBut.
function FitSelectedCalToneBut_Callback(hObject, eventdata, handles)
% hObject    handle to FitSelectedCalToneBut (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if (isfield(handles,'SelectedData'))
    SelInd = handles.SelectedData;
    haveCalToneData = handles.haveCalToneData{SelInd};
    if haveCalToneData
        FitSelectedCalToneData(hObject,handles,SelInd);
        handles = guidata(hObject);
        WriteDataToTable(hObject,handles);
        %PlotResults(hObject,handles);
    end
    
else
    warndlg('Select a row in the Results table first');
end

guidata(hObject, handles);


% --- Executes on button press in CursorCheckBoxCalTone.
function CursorCheckBoxCalTone_Callback(hObject, eventdata, handles)
% hObject    handle to CursorCheckBoxCalTone (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of CursorCheckBoxCalTone
ax = handles.CalToneAxis;
axes(ax);

if (get(hObject,'Value'))
    
    %dualcursor on;
    dualcursor('on',[.05 .9;.05 .8]);
    handles.CursorsOnCalTone = true;
else
    dualcursor off;
    handles.CursorsOnCalTone = false;
    
end
PlotResults(hObject,handles);
guidata(hObject,handles);


% --- Executes on button press in IntegrateSpectraBut.
function IntegrateSpectraBut_Callback(hObject, eventdata, handles)
% hObject    handle to IntegrateSpectraBut (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

ax = handles.SpectrumAxis;
axes(ax);
if handles.CursorsOn
    Curs = dualcursor;
    FreqStart = Curs(1);
    FreqStop = Curs(3);
end

data = handles.data{1};
Freq = data(:,1);
Amp = data(:,2);
if handles.CursorsOn
    valid = Freq > FreqStart & Freq < FreqStop;
else
    valid = (true(1,length(Freq)));
end


handles.haveoccupationcalibration = true;
for i=1:length(handles.Area)
    Amp = handles.data{i}(:,2);
    spect = Amp(valid);
    spectMinusBG = spect-handles.c{i};
    area = sum(spectMinusBG);
    handles.AreaIntegrated{i} = area;
end
WriteDataToTable(hObject,handles);
guidata(hObject,handles);


% --- Executes on button press in IntegrateCalToneBut.
function IntegrateCalToneBut_Callback(hObject, eventdata, handles)
% hObject    handle to IntegrateCalToneBut (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

ax = handles.CalToneAxis;
axes(ax);
if handles.CursorsOn
    Curs = dualcursor;
    FreqStart = Curs(1);
    FreqStop = Curs(3);
end

data = handles.dataCalTone{1};
Freq = data(:,1);
%Amp = data(:,2);
if handles.CursorsOn
    valid = Freq > FreqStart & Freq < FreqStop;
else
    valid = (true(1,length(Freq)));
end


handles.haveoccupationcalibration = true;
for i=1:length(handles.Area)
    Amp = handles.dataCalTone{i}(:,2);
    spect = Amp(valid);
    spectMinusBG = spect-handles.c{i};
    area = sum(spectMinusBG);
    handles.CalTone.AreaIntegrated{i} = area;
end
WriteDataToTable(hObject,handles);
guidata(hObject,handles);

function IntrinsicGammaText_Callback(hObject, eventdata, handles)
% hObject    handle to IntrinsicGammaText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of IntrinsicGammaText as text
%        str2double(get(hObject,'String')) returns contents of IntrinsicGammaText as a double


% --- Executes during object creation, after setting all properties.
function IntrinsicGammaText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to IntrinsicGammaText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in UseGammaCorrectionCheck.
function UseGammaCorrectionCheck_Callback(hObject, eventdata, handles)
% hObject    handle to UseGammaCorrectionCheck (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(handles.UseGammaCorrectionCheck,'Value') returns toggle state of UseGammaCorrectionCheck



% --- Executes on button press in UseFitCheck.
function UseFitCheck_Callback(hObject, eventdata, handles)
% hObject    handle to UseFitCheck (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of UseFitCheck


% --- Executes on button press in CalculateOccupationCheck.
function CalculateOccupationCheck_Callback(hObject, eventdata, handles)
% hObject    handle to CalculateOccupationCheck (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of CalculateOccupationCheck


% --- Executes on button press in DeleteSelectedDataBut.
function DeleteSelectedDataBut_Callback(hObject, eventdata, handles)
% hObject    handle to DeleteSelectedDataBut (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
SelData = handles.SelectedData;
handles.FileName(SelData) = [];
handles.Param(SelData) = [];
handles.data(SelData) = [];
handles.dataCalTone(SelData) = [];
handles.fitted(SelData) = [];
handles.fittedCalTone(SelData) = [];
handles.haveCalToneData(SelData) = [];
handles.NumSpec(SelData) = [];
handles.OmegaM(SelData) = [];
handles.SxxMax(SelData) = [];
handles.SxxNoise(SelData) = [];
handles.g(SelData) = [];
handles.x0(SelData) = [];
handles.Amp(SelData) = [];
handles.L(SelData) = [];
handles.Area(SelData) = [];;
handles.CorrectedArea(SelData) = [];;
handles.c(SelData) = [];;
handles.n(SelData) = [];;
handles.AreaIntegrated(SelData) = [];;
handles.nIntegrated(SelData) = [];;
handles.CalTone.x0(SelData) = [];;
handles.CalTone.c(SelData) = [];;
handles.CalTone.L(SelData) = [];;
handles.CalTone.Area(SelData) = [];;
handles.CalTone.AreaIntegrated(SelData) = [];;
handles.CalTone.Amp(SelData) = [];;
handles.cernox(SelData) = [];;
handles.probe(SelData) = [];;
handles.input6(SelData) = [];;
guidata(hObject,handles);
WriteDataToTable(hObject,handles);


% --- Executes on button press in FitGammaCheck.
function FitGammaCheck_Callback(hObject, eventdata, handles)
% hObject    handle to FitGammaCheck (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of FitGammaCheck


% --- Executes on button press in FitNoiseFloorCheck.
function FitNoiseFloorCheck_Callback(hObject, eventdata, handles)
% hObject    handle to FitNoiseFloorCheck (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of FitNoiseFloorCheck


% --- Executes on button press in FitAmpCheck.
function FitAmpCheck_Callback(hObject, eventdata, handles)
% hObject    handle to FitAmpCheck (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of FitAmpCheck


% --- Executes on button press in FitOmegaCheck.
function FitOmegaCheck_Callback(hObject, eventdata, handles)
% hObject    handle to FitOmegaCheck (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(handles.FitOmegaCheck,'Value') returns toggle state of FitOmegaCheck


% --- Executes on button press in SaveSpectrumPlot.
function SaveSpectrumPlot_Callback(hObject, eventdata, handles)
% hObject    handle to SaveSpectrumPlot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

addpath('export_fig');
ax = handles.SpectrumAxis;
[FileName, PathName] = uiputfile('.', 'Save As'); 
Name = fullfile(PathName,FileName);
%export_fig(Name,ax,'-pdf');


Fig2 = figure;
axes(ax);
%h2=copyobj( findobj( hObject, ...
%              'tag', ['SpectrumAxis', int2str( 1 ) ] ), Fig2 ); 
ax2=axes;

%copyobj(ax, Fig2);
hgsave(Fig2, Name );
%close(Fig2);

% --- Executes on button press in AddToPlotGrid.
function AddToPlotGrid_Callback(hObject, eventdata, handles)
% hObject    handle to AddToPlotGrid (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
