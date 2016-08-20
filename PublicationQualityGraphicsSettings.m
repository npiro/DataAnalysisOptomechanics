function f = PublicationQualityGraphicsSettings(ax)

LineWidth = 1.5;
AxesLineWidth = 1;
FontSize = 16;
FigureWidth = 640;
FigureHeight = 480;
FontType = 'Arial';

f = gcf;
set(0,'defaultAxesFontName', FontType);
set(0,'DefaultAxesFontSize',FontSize);
position = [ 0 0 FigureWidth FigureHeight ];
set(0, 'DefaultFigurePosition', position);
set (ax,'LineWidth',AxesLineWidth);
set(f,'DefaultLineLineWidth',LineWidth)
set (ax,'FontName',FontType);



