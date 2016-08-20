function PlotCalToneSpectrum(handles,Freq,Amp)
ax = handles.CalToneAxis;
axes(ax);
if handles.CursorsOnCalTone
    cursOld = dualcursor(ax);
end
ax = axis;


plot(Freq,Amp,'b');

if length(handles.dataCalTone) > 1
    axis manual;
    axis(ax);
end
if handles.CursorsOnCalTone
    dualcursor(cursOld(1:2:3)); 
end
contents = cellstr(get(handles.AxisTypeCalTone,'String'));
AxisTypeCalTone = contents{get(handles.AxisTypeCalTone,'Value')};
set(gca,'YScale',AxisTypeCalTone);

ylabel('S_{VV}');
