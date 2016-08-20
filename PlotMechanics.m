function varargout = PlotMechanics(varargin)
% PLOTMECHANICS MATLAB code for PlotMechanics.fig
%      PLOTMECHANICS, by itself, creates a new PLOTMECHANICS or raises the existing
%      singleton*.
%
%      H = PLOTMECHANICS returns the handle to a new PLOTMECHANICS or the handle to
%      the existing singleton*.
%
%      PLOTMECHANICS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PLOTMECHANICS.M with the given input arguments.
%
%      PLOTMECHANICS('Property','Value',...) creates a new PLOTMECHANICS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before PlotMechanics_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to PlotMechanics_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help PlotMechanics

% Last Modified by GUIDE v2.5 14-Aug-2014 09:29:21

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @PlotMechanics_OpeningFcn, ...
                   'gui_OutputFcn',  @PlotMechanics_OutputFcn, ...
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


% --- Executes just before PlotMechanics is made visible.
function PlotMechanics_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to PlotMechanics (see VARARGIN)

% Choose default command line output for PlotMechanics
handles.output = hObject;

handles.haveData = false;
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes PlotMechanics wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = PlotMechanics_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on slider movement.
function Gamma1Slide_Callback(hObject, eventdata, handles)
% hObject    handle to Gamma1Slide (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
set(handles.Gamma1Text,'String',num2str(get(hObject,'Value')));
DoPlot(hObject,handles);

% --- Executes during object creation, after setting all properties.
function Gamma1Slide_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Gamma1Slide (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
set(hObject,'Min',0.5e4);
set(hObject,'Max',10e4);
set(hObject,'Value',30e3);

function Gamma1Text_Callback(hObject, eventdata, handles)
% hObject    handle to asdf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of asdf as text
%        str2double(get(hObject,'String')) returns contents of asdf as a double


% --- Executes during object creation, after setting all properties.
function Gamma1Text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to asdf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function Gamma2Slide_Callback(hObject, eventdata, handles)
% hObject    handle to Gamma2Slide (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
set(handles.Gamma2Text,'String',num2str(get(hObject,'Value')));
DoPlot(hObject,handles);

% --- Executes during object creation, after setting all properties.
function Gamma2Slide_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Gamma2Slide (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
set(hObject,'Min',0.5e4);
set(hObject,'Max',10e4);
set(hObject,'Value',10e3);


function Gamma2Text_Callback(hObject, eventdata, handles)
% hObject    handle to Gamma2Text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Gamma2Text as text
%        str2double(get(hObject,'String')) returns contents of Gamma2Text as a double


% --- Executes during object creation, after setting all properties.
function Gamma2Text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Gamma2Text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function Omega1Slide_Callback(hObject, eventdata, handles)
% hObject    handle to Omega1Slide (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
set(handles.Omega1Text,'String',num2str(get(hObject,'Value')));


% --- Executes during object creation, after setting all properties.
function Omega1Slide_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Omega1Slide (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
set(hObject,'Min',3e6);
set(hObject,'Max',5e6);
set(hObject,'Value',4.3e6);


function Omega1Text_Callback(hObject, eventdata, handles)
% hObject    handle to Omega1Text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Omega1Text as text
%        str2double(get(hObject,'String')) returns contents of Omega1Text as a double


% --- Executes during object creation, after setting all properties.
function Omega1Text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Omega1Text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function Omega2Slide_Callback(hObject, eventdata, handles)
% hObject    handle to Omega2Slide (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
set(handles.Omega2Text,'String',num2str(get(hObject,'Value')));
DoPlot(hObject,handles);

% --- Executes during object creation, after setting all properties.
function Omega2Slide_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Omega2Slide (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
set(hObject,'Min',4e6);
set(hObject,'Max',5e6);
set(hObject,'Value',4.577e6);


function Omega2Text_Callback(hObject, eventdata, handles)
% hObject    handle to Omega2Text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Omega2Text as text
%        str2double(get(hObject,'String')) returns contents of Omega2Text as a double


% --- Executes during object creation, after setting all properties.
function Omega2Text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Omega2Text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function a1Slide_Callback(hObject, eventdata, handles)
% hObject    handle to a1Slide (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
set(handles.a1Text,'String',num2str(get(hObject,'Value')));
DoPlot(hObject,handles);

% --- Executes during object creation, after setting all properties.
function a1Slide_CreateFcn(hObject, eventdata, handles)
% hObject    handle to a1Slide (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
set(hObject,'Min',1e-14);
set(hObject,'Max',1e-10);
set(hObject,'Value',1.4e-12);


function a1Text_Callback(hObject, eventdata, handles)
% hObject    handle to a1Text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of a1Text as text
%        str2double(get(hObject,'String')) returns contents of a1Text as a double


% --- Executes during object creation, after setting all properties.
function a1Text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to a1Text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function a2Slide_Callback(hObject, eventdata, handles)
% hObject    handle to a2Slide (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
set(handles.a2Text,'String',num2str(get(hObject,'Value')));
DoPlot(hObject,handles);

% --- Executes during object creation, after setting all properties.
function a2Slide_CreateFcn(hObject, eventdata, handles)
% hObject    handle to a2Slide (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
set(hObject,'Min',5e-14);
set(hObject,'Max',1e-11);
set(hObject,'Value',1.4e-12);


function a2Text_Callback(hObject, eventdata, handles)
% hObject    handle to a2Text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of a2Text as text
%        str2double(get(hObject,'String')) returns contents of a2Text as a double


% --- Executes during object creation, after setting all properties.
function a2Text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to a2Text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function CSlide_Callback(hObject, eventdata, handles)
% hObject    handle to CSlide (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
set(handles.CText,'String',num2str(get(hObject,'Value')));
DoPlot(hObject,handles);

% --- Executes during object creation, after setting all properties.
function CSlide_CreateFcn(hObject, eventdata, handles)
% hObject    handle to CSlide (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
set(hObject,'Min',1e-16);
set(hObject,'Max',1e-14);
set(hObject,'Value',2e-15);


function CText_Callback(hObject, eventdata, handles)
% hObject    handle to CText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of CText as text
%        str2double(get(hObject,'String')) returns contents of CText as a double


% --- Executes during object creation, after setting all properties.
function CText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to CText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in PlotBut.
function PlotBut_Callback(hObject, eventdata, handles)
% hObject    handle to PlotBut (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

DoPlot(hObject,handles)
%c = str2double(get(handles.CText,'String'));
%a1 = str2double(get(handles.a1Text,'String'));
%a2 = str2double(get(handles.a2Text,'String'));
%G1 = str2double(get(handles.asdf,'String'));
%G2 = str2double(get(handles.Gamma2Text,'String'));
%Om1 = str2double(get(handles.Omega1Text,'String'));
%Om2 = str2double(get(handles.Omega2Text,'String'));
%x1=str2double(get(handles.x1Text,'String'));
%x2=str2double(get(handles.x2Text,'String'));
%N=str2num(get(handles.NpointsText,'String'));

%xrange = linspace(x1,x2,N);
%semilogy(xrange,DoubleMechSuscFunc(G1,G2,a1,a2,c,Om1,Om2,xrange));


% --- Executes on button press in TwoModesCheck.
function TwoModesCheck_Callback(hObject, eventdata, handles)
% hObject    handle to TwoModesCheck (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of TwoModesCheck


% --- Executes on slider movement.
function x1Slider_Callback(hObject, eventdata, handles)
% hObject    handle to x1Slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
set(handles.x1Text,'String',num2str(get(hObject,'Value')));


% --- Executes during object creation, after setting all properties.
function x1Slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to x1Slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
set(hObject,'Min',3e6);
set(hObject,'Max',5e6);
set(hObject,'Value',4e6);


function x1Text_Callback(hObject, eventdata, handles)
% hObject    handle to x1Text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of x1Text as text
%        str2double(get(hObject,'String')) returns contents of x1Text as a double


% --- Executes during object creation, after setting all properties.
function x1Text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to x1Text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function x2Slider_Callback(hObject, eventdata, handles)
% hObject    handle to x2Slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
set(handles.x2Text,'String',num2str(get(hObject,'Value')));


% --- Executes during object creation, after setting all properties.
function x2Slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to x2Slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
set(hObject,'Min',4e6);
set(hObject,'Max',7e6);
set(hObject,'Value',5.5e6);


function x2Text_Callback(hObject, eventdata, handles)
% hObject    handle to x2Text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of x2Text as text
%        str2double(get(hObject,'String')) returns contents of x2Text as a double


% --- Executes during object creation, after setting all properties.
function x2Text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to x2Text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function NpointsText_Callback(hObject, eventdata, handles)
% hObject    handle to NpointsText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of NpointsText as text
%        str2double(get(hObject,'String')) returns contents of NpointsText as a double


% --- Executes during object creation, after setting all properties.
function NpointsText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NpointsText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in LoadSpectrumBut.
function LoadSpectrumBut_Callback(hObject, eventdata, handles)
% hObject    handle to LoadSpectrumBut (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[FileName,PathName,FilterIndex]=uigetfile('*.spe');

fn=fullfile(PathName,FileName);
data=ImportDataAndParseParams(fn,{});
handles.Freq = data(:,1);
handles.Amp = data(:,2);
axes(handles.Axes);
semilogy(handles.Freq,handles.Amp);
handles.haveData = true;
guidata(hObject,handles);


% --- Executes on button press in InterferenceCheck.
function InterferenceCheck_Callback(hObject, eventdata, handles)
% hObject    handle to InterferenceCheck (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of InterferenceCheck


% --- Executes on button press in FitButton.
function FitButton_Callback(hObject, eventdata, handles)
% hObject    handle to FitButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Freq = handles.Freq;
Amp = handles.Amp;
c = str2double(get(handles.CText,'String'));
a1 = str2double(get(handles.a1Text,'String'));
a2 = str2double(get(handles.a2Text,'String'));
G1 = str2double(get(handles.Gamma1Text,'String'));
G2 = str2double(get(handles.Gamma2Text,'String'));
Om1 = str2double(get(handles.Omega1Text,'String'));
Om2 = str2double(get(handles.Omega2Text,'String'));
x1=str2double(get(handles.x1Text,'String'));
x2=str2double(get(handles.x2Text,'String'));
range = Freq > x1 & Freq < x2;
FreqFit = Freq(range);
AmpFit = Amp(range);
PlotInterference=get(handles.InterferenceCheck,'Value');
TwoMode=get(handles.TwoModesCheck,'Value');
FixParams = [get(handles.FixGamma1Check,'Value') ...
    get(handles.FixGamma2Check,'Value') ...
    get(handles.Fixa1Check,'Value') ...
    get(handles.Fixa2Check,'Value') ...
    get(handles.FixCCheck,'Value') ...
    get(handles.FixOmega1Check,'Value') ...
    get(handles.FixOmega2Check,'Value')];

if (TwoMode && PlotInterference)
    StartPoint = [G1 G2 a1 a2 c Om1 Om2];
    fit = FitDoubleMechSuscInterference(FreqFit,AmpFit,StartPoint,false)
    hold on;
    plot(FreqFit,10.^fit(FreqFit),'g');
    hold off;
elseif TwoMode
    StartPoint = [G1 G2 a1 a2 c Om1 Om2];
    fit = FitDoubleMechSusc(FreqFit,AmpFit,StartPoint,false,FixParams)
    hold on;
    plot(FreqFit,10.^fit(FreqFit),'g');
    hold off;
end
G1 = fit.G1;
set(handles.Gamma1Text,'String',num2str(G1));
set(handles.Gamma1Slide,'Value',G1);
set(handles.Gamma1Slide,'Min',G1*0.1);
set(handles.Gamma1Slide,'Max',G1*10);

G2 = fit.G2;
set(handles.Gamma2Text,'String',num2str(G2));
set(handles.Gamma2Slide,'Value',G2);
set(handles.Gamma2Slide,'Min',G2*0.1);
set(handles.Gamma2Slide,'Max',G2*10);
a1 = fit.a1;
set(handles.a1Text,'String',num2str(a1));
set(handles.a1Slide,'Value',a1);
set(handles.a1Slide,'Min',a1*0.1);
set(handles.a1Slide,'Max',a1*10);
a2 = fit.a2;
set(handles.a2Text,'String',num2str(a2));
set(handles.a2Slide,'Value',a2);
set(handles.a2Slide,'Min',a2*0.1);
set(handles.a2Slide,'Max',a2*10);
c = fit.c;
set(handles.CText,'String',num2str(c));
set(handles.CSlide,'Value',c);
set(handles.CSlide,'Min',c*0.1);
set(handles.CSlide,'Max',c*10);
Om1 = fit.x01;
set(handles.Omega1Text,'String',num2str(Om1));
set(handles.Omega1Slide,'Value',Om1);
set(handles.Omega1Slide,'Min',Om1*0.1);
set(handles.Omega1Slide,'Max',Om1*10);
Om2 = fit.x02;
set(handles.Omega2Text,'String',num2str(Om2));
set(handles.Omega2Slide,'Value',Om2);
set(handles.Omega2Slide,'Min',Om2*0.1);
set(handles.Omega2Slide,'Max',Om2*10);
guidata(hObject,handles);
DoPlot(hObject,handles);


% --- Executes on button press in FixGamma1Check.
function FixGamma1Check_Callback(hObject, eventdata, handles)
% hObject    handle to FixGamma1Check (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of FixGamma1Check


% --- Executes on button press in FixGamma2Check.
function FixGamma2Check_Callback(hObject, eventdata, handles)
% hObject    handle to FixGamma2Check (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of FixGamma2Check


% --- Executes on button press in FixOmega1Check.
function FixOmega1Check_Callback(hObject, eventdata, handles)
% hObject    handle to FixOmega1Check (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of FixOmega1Check


% --- Executes on button press in FixOmega2Check.
function FixOmega2Check_Callback(hObject, eventdata, handles)
% hObject    handle to FixOmega2Check (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of FixOmega2Check


% --- Executes on button press in Fixa1Check.
function Fixa1Check_Callback(hObject, eventdata, handles)
% hObject    handle to Fixa1Check (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Fixa1Check


% --- Executes on button press in Fixa2Check.
function Fixa2Check_Callback(hObject, eventdata, handles)
% hObject    handle to Fixa2Check (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Fixa2Check


% --- Executes on button press in FixCCheck.
function FixCCheck_Callback(hObject, eventdata, handles)
% hObject    handle to FixCCheck (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of FixCCheck
