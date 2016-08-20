function [  ] = MakeGrid( ax )
%PLACE Summary of this function goes here
%   Detailed explanation goes here

GridGreyLevel = 0.7;

grid on;
set(ax, 'GridLineStyle', '-');
gl=GridGreyLevel;
set(ax,'Xcolor',[gl gl gl]);
set(ax,'Ycolor',[gl gl gl]);
Caxes = copyobj(ax,gcf);
set(Caxes, 'color', 'none', 'xcolor', 'k', 'xgrid', 'off', 'ycolor','k', 'ygrid','off');


end

