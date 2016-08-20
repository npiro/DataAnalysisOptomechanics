function PlotResults(hObject,handles)
axArea = handles.AreaAxis;
axes(axArea);

% Get X data from params column and crop to length of Y data.
XAxisMenuContents = cellstr(get(handles.XAxisAreaPlot,'String'))
XAxisAreaPlot=XAxisMenuContents{get(handles.XAxisAreaPlot,'Value')}

plotPoint = cell2mat(handles.plotPoint);

contents = cellstr(get(handles.ModelSelectionMenu,'String'));
model = contents{get(handles.ModelSelectionMenu,'Value')};
switch model
    case {'Lorentzian','Mechanical susceptibility'}
        switch XAxisAreaPlot
            case 'Param'
                Xdata = cell2mat(handles.Param);
            case 'Omega'
                Xdata = cell2mat(handles.x0);
            case 'Gamma'
                Xdata = cell2mat(handles.L);
            case 'Area'
                Xdata = cell2mat(handles.Area);
            case 'Cernox'
                Xdata = cell2mat(handles.cernox);
            case 'Probe'
                Xdata = cell2mat(handles.probe);
            case 'Input 6%'
                Xdata = cell2mat(handles.input6);
            case 'Total power'
                Xdata = cell2mat(handles.input6)*16.8*1e6;
        end
    case 'Squashing model'
        switch XAxisAreaPlot
            case 'Param'
                Xdata = cell2mat(handles.Param);
            case 'Omega'
                Xdata = cell2mat(handles.Omega);
            case 'Gamma'
                Xdata = cell2mat(handles.g);
            case 'Area'
                Xdata = cell2mat(handles.Area);
            case 'Cernox'
                Xdata = cell2mat(handles.cernox);
            case 'Probe'
                Xdata = cell2mat(handles.probe);
            case 'Input 6%'
                Xdata = cell2mat(handles.input6);
            case 'Total power'
                Xdata = cell2mat(handles.input6)*16.8*1e6;
        end
end

Xdata = Xdata(1:length(cell2mat(handles.Area)));
if handles.haveCTCorrection
    Area = cell2mat(handles.CorrectedArea);
else   
    Area = cell2mat(handles.Area);
end
%[~,IMin]=min(Area);
%errorArea = cell2mat(handles.ErrorArea);
%errorAreaSelected = cell2mat(handles.ErrorArea([1,IMin]))/2;
if handles.haveoccupationcalibration
    Area = cell2mat(handles.n);
    %Area = Area*handles.occupationcalfactor;
    %errorAreaSelected = errorAreaSelected*handles.occupationcalfactor;
end
plot(Xdata(plotPoint),Area(plotPoint),'o');

%hold on;

%errorbar(Xdata([1,IMin]),Area([1,IMin]),errorAreaSelected,'or');
%hold off;
contents = cellstr(get(handles.AxisTypeArea,'String'));
AxisFormatArea = contents{get(handles.AxisTypeArea,'Value')};
set(gca,'YScale',AxisFormatArea);
set(gca,'XScale',AxisFormatArea);
set(gca,'XGrid','on');
set(gca,'YGrid','on');
if handles.haveoccupationcalibration && strcmp(AxisFormatArea,'Log');
    set(gca,'YTick',[0.1,1,10,100,1000,10000,100000]);
else 
    set(gca,'YTickMode','auto');
end

set(gca,'GridLineStyle','-')
xlabel(XAxisAreaPlot);
if handles.haveoccupationcalibration
    ylabel('n_{mode}');
else
    ylabel('Area');
end

axOmega = handles.OmegaAxis;
axes(axOmega);
Ydata = cell2mat(handles.x0);
plot(Xdata(plotPoint),Ydata(plotPoint),'o');
contents = cellstr(get(handles.AxisTypeOmega,'String'));
AxisFormatOmega = contents{get(handles.AxisTypeOmega,'Value')};
set(gca,'YScale',AxisFormatOmega);
xlabel('Param');
ylabel('Omega');

axGamma = handles.GammaAxis;
axes(axGamma);
Ydata = cell2mat(handles.L);
plot(Xdata(plotPoint),Ydata(plotPoint),'o');
contents = cellstr(get(handles.AxisTypeOmega,'String'));
AxisTypeGamma = contents{get(handles.AxisTypeGamma,'Value')};
set(gca,'YScale',AxisTypeGamma);
xlabel('Param');
ylabel('Gamma');
