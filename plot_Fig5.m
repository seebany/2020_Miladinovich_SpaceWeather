% This script plots the subplots of Figure 5 of Miladinovich et al., 2020,
% each as a single figure.
% It plots the EMPIRE-estimated storm time northern hemisphere potential
% over the north pole (the sum of the background Weimer 2000 potential and
% the EMPIRE correction) at 1610 UT, 2010 UT on 17 March 2015, and 0010 UT,
% and 0410 UT on 18 Mar 2015.
%
% The potential data are in files potential_yymmdd_HHMM.mat created from
% the outputs of Run 3 as discussed in the paper.
% This script requires the use of the Matlab Mapping Toolbox.
%
% See AUTHORS, LICENSE, and README files for additional information.
% Seebany Datta-Barua
% Illinois Institute of Technology
% sdattaba@iit.edu
% 16 Apr 2020

clear
close all

% Set plot times.
t = datenum([2015 3 17 16 10 0;
    2015 3 17 20 10 0;
    2015 3 18 0 10 0;
    2015 3 18 4 10 0;]);
% Loop through loading data and plotting.
for i = 1:numel(t)
    load(['data/potential_' datestr(t(i) ,'yymmdd_HHMM')])
    % Plot.
    fig = figure;
    axesm('MapProjection', 'ortho','origin', [90, 0], 'meridianlabel', 'on',...
        'parallellabel','on','grid','on', 'mlabelparallel',0,'labelrotation','on',...
        'fontsize',15,'fontweight','bold','labelformat','none');
    hold on
    pcolorm(glat,glon,potential);
    framem
    cbhl = colorbar;
    title(['EMPIRE-corrected Electric Potential in kV at ' datestr(t(i), 'mmm dd, yyyy, HH:MM') ' UT'])
    for j = 1:numel(ISRlat)
        plotm(ISRlat(j), ISRlon(j),'mo','MarkerSize', 5, 'LineWidth', 2);
    end
    plotm(fpilat, fpilon, 'm.','MarkerSize',10, 'LineWidth',2)
    
    coastline = load('coast');
    plotm(coastline.lat, coastline.long,'w')
    
    C = contourm(glat,glon,potential,'k','LevelStep',5);
end
