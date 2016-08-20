function plotCalToneDataAndFit(handles,FreqData,AmpData,FreqFit,AmpFit)

ax = handles.CalToneAxis;
axes(ax);
if handles.CursorsOnCalTone
    cursOld = dualcursor(ax);
end
%ax = axis;
if length(handles.CalTone) > 1
%    axis manual;
%    axis(ax);
end

% If calibrated y axis, correct data and fit by calibration
if handles.havecalibration
    AmpData = AmpData*handles.calfactor;
    AmpFit = AmpFit*handles.calfactor;
end
plot(FreqData,AmpData,'b',FreqFit,AmpFit,'g');
axis(ax);
if handles.CursorsOnCalTone
    dualcursor(cursOld(1:2:3)); 
end

% Get and set axis type
contents = cellstr(get(handles.AxisTypeSpectrum,'String'));
AxisTypeSpectrum = contents{get(handles.AxisTypeSpectrum,'Value')};
set(gca,'YScale',AxisTypeSpectrum);