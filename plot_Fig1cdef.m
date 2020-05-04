% This script plots Figures 1c, 1d, 1e, and 1f of Miladinovich et al.,
% 2020.
% It plots maps of IDA4D output ionospheric electron densities, vertically 
% integrated as total electron content.
% The IDA4D TEC data are in files  TEC_yymmdd_HHMM.mat and were created
% from the outputs of the study shown in Miladinovich et al., 2020.
%
% The following Matlab warning may arise and was ignored by authors.
% Warning: Duplicate data points have been detected and removed. Some point
% indices will not be referenced by the triangulation.
% > In plot_tec_map (line 28)
%   In plot_Fig1cdef (line 53)
%
% See AUTHORS, LICENSE, and README for additional information.
% Seebany Datta-Barua
% Illinois Institute of Technology
% sdattaba@iit.edu
% 16 Apr 2020

clear
close all
addpath(genpath(cd));

% Hardcode the times of each subplot.
t = datenum([2015 3 17 16 0 0;
	2015 3 17 20 0 0;
	2015 3 18 0  0 0;
	2015 3 18 4  0 0]);

ax = [-180 180 -80 80];
colormax = 80;
colorlabel = 'Vertical TEC [TECU]';

% Loop through production of each plot.
for i = 1:numel(t)
    figure
    plot_title = ['IDA4D Vertically Integrated Ne, \newline' ...
        datestr(t(i), 'dd mmmm yyyy, HHMM UT')];
    
    load(['data/TEC_' datestr(t(i), 'yymmdd_HHMM') '.mat'],'TEC','t', 'avail_lat', 'avail_lon');
    
    plot_tec_map(ax, avail_lon*180/pi  - 360*(avail_lon > pi), ...
        avail_lat*180/pi, TEC, colormax, colorlabel, plot_title);
    axis image
    axis(ax);
end
