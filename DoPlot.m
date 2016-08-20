function DoPlot(hObject,handles)

c = str2double(get(handles.CText,'String'));
a1 = str2double(get(handles.a1Text,'String'));
a2 = str2double(get(handles.a2Text,'String'));
G1 = str2double(get(handles.Gamma1Text,'String'));
G2 = str2double(get(handles.Gamma2Text,'String'));
Om1 = str2double(get(handles.Omega1Text,'String'));
Om2 = str2double(get(handles.Omega2Text,'String'));
x1=str2double(get(handles.x1Text,'String'));
x2=str2double(get(handles.x2Text,'String'));
N=str2num(get(handles.NpointsText,'String'));
axes(handles.Axes);
ok = handles.Freq > x1 & handles.Freq < x2;
semilogy(handles.Freq(ok),handles.Amp(ok));


PlotInterference=get(handles.InterferenceCheck,'Value');
TwoMode=get(handles.TwoModesCheck,'Value');
hold on;
xrange = linspace(x1,x2,N);
if TwoMode && PlotInterference
    semilogy(xrange,DoubleMechSuscFunc(G1,G2,a1,a2,c,Om1,Om2,xrange),'r');
elseif TwoMode
    semilogy(xrange,MechSuscFunc(xrange,c,a1,Om1,G1)+MechSuscFunc(xrange,0,a2,Om2,G2),'r');
else
    semilogy(xrange,MechSuscFunc(xrange,c,a1,Om1,G1),'r');
end
hold off;