function PlotSpectrum(handles,Freq,Amp)
ax = handles.SpectrumAxis;
axes(ax);
if handles.CursorsOn
    cursOld = dualcursor(ax);
end
if handles.havecalibration
    Amp = Amp*handles.calfactor;
end
ax = axis;

plot(Freq,Amp,'b');
if length(handles.data) > 1
    axis manual;
    axis(ax);
end
if handles.CursorsOn
    dualcursor(cursOld(1:2:3));
    
end

contents = cellstr(get(handles.AxisTypeSpectrum,'String'));
AxisTypeSpectrum = contents{get(handles.AxisTypeSpectrum,'Value')};
set(gca,'YScale',AxisTypeSpectrum);
if handles.havecalibration
    ylabel('S_{xx}/S_{xx}^{SQL}');
else
    ylabel('S_{VV}');
end