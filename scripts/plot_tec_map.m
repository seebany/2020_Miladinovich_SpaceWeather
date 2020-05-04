% Function plot_tec_map(ax, teclon, teclat, TEC, colormax, colorlabel) plots a
% map of the world and colors the map with data field TEC (total electron content).
% This function supports script plot_Fig1cdef.m for reproducing Figures 1c, 1d, 1e, and 1f
% of Miladinovich et al., (2020).
% It requires the files mapdata.mat which contains continent boundaries, and 
% TEC data, assumed to be from files TEC_yymmdd_HHMM.mat.
%
% It does *not* require the Matlab Mapping Toolbox.
%
% See AUTHORS, LICENSE, and README files for additional information.
% Seebany Datta-Barua
% Illinois Institute of Technology
% sdattaba@iit.edu
% 16 Apr 2020

function h = plot_tec_map(ax, teclon, teclat, TEC, colormax, colorlabel, plot_title)
%figure('Visible', 'off')%get(groot,'defaultFigureVisible'))
load mapdata
hold on
axis(ax);
axis square

h = xlabel('Geographic Longitude [deg E]');
% set(h, 'FontSize', 10);
% set(h, 'FontName', 'Times');
h = ylabel('Geographic Latitude [deg N]');
% set(h, 'FontSize', 10);
% set(h, 'FontName', 'Times');
%h = title(plot_title);
% set(h, 'FontSize', 10);
% set(h, 'FontName', 'Times');

set(gcf, 'Color', [1 1 1])

H = colorbar;
    colormin = min(0,min(TEC));%100;%0*(all(TEC)>=0) + min(TEC)*(any(TEC)<0);%min(TEC); %
set(get(H,'Ylabel'),'String',colorlabel, ...
    'FontSize', 10, 'FontName', 'Times');
set(gca, 'CLim', [colormin colormax], 'FontSize',14);
% set(H,'CLim',[colormin colormax]);
tri = delaunay(teclon, teclat);
for idx = 1:length(tri)
        patch(teclon(tri(idx,:)), teclat(tri(idx,:)), TEC(tri(idx,:)), ...
            'EdgeColor', 'none'); %[0.5 0.5 0.5]);
end
plot(ll_world(:,2),ll_world(:,1),'k','LineWidth', 2.0); 

h = title(plot_title);
%set(h, 'FontSize', 10);
%set(h, 'FontName', 'Times');

