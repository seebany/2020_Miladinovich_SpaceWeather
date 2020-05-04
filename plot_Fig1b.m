% This script plots Figure 1b of Miladinovich et al., 2020.
% It plots Millstone Hill FPI measurements vs time.
% The Millstone Hill FPI data are in a text file Millstone_FPI_yyyymmdd.txt
% and were obtained from the CEDAR Madrigal website.
%
% See AUTHORS, LICENSE, and README files for additional information.
% Seebany Datta-Barua
% Illinois Institute of Technology
% sdattaba@iit.edu
% 16 Apr 2020

clear all
close all
addpath(genpath(cd));

% Initialize structures for storage of measurements.
long_wind_meas.south.vel = [];long_wind_meas.south.time = [];long_wind_meas.south.xtick = []; long_wind_meas.south.err = []; 
long_wind_meas.north.vel = [];long_wind_meas.north.time = [];long_wind_meas.north.xtick = []; long_wind_meas.north.err = []; 
long_wind_meas.east.vel = [];long_wind_meas.east.time = [];long_wind_meas.east.xtick = []; long_wind_meas.east.err = []; 
long_wind_meas.west.vel = [];long_wind_meas.west.time = [];long_wind_meas.west.xtick = []; long_wind_meas.west.err = []; 

% Read in data files.
for t_datenum = datenum([2015 3 17]):datenum([2015 3 18]);
    
    filename = ['data/Millstone_FPI_' datestr(t_datenum, 'yyyymmdd') '.txt'];
    [uwut, uwaz, uwelv, uwalt, inwind, dinwind, winderr] = read_Millstone_FPI(filename);

    % List all the possible azimuths at which measurements are taken.         
    uni_uwaz = unique(uwaz);
    
    % Loop through azimuths and sort by look direction for assigning to
    % variables for plotting.
    for i = 1:numel(uni_uwaz)

        %have to determine what directions it is facing within limits
        %north
        if uni_uwaz(i) >= -10 && uni_uwaz(i) <= 10  %NORTH 0 deg
            inds = find(uwaz == uni_uwaz(i));
            
            direction = 'north';
        end
        if uni_uwaz(i) >= 80 && uni_uwaz(i) <= 100  %east 90 deg
            inds = find(uwaz == uni_uwaz(i));
            
            direction = 'east';
        end
        if uni_uwaz(i) >= -100 && uni_uwaz(i) <= -80  %west -90 deg
            inds = find(uwaz == uni_uwaz(i));
            
            direction = 'west';
        end
        if abs(uni_uwaz(i)) >= 170  %SOUTH  can be -180 or 180 deg
            inds = find(uwaz == uni_uwaz(i));
            
            direction = 'south';
        end
        if exist('direction','var') == 0
            warning(['FPI sensor direction for this point is assumed not facing N,S,E, or W. ' ...
                'the azimuth angle for this run is' num2str(uni_uwaz(i)) ' it will not be plotted please see compare_to_fpi.m'])
        end
                
            
        %% store the measured wind values
        %e.g. long_wind_meas.north = [long_wind_meas.north; inwinds(inds)];
        cmd = ['long_wind_meas.' direction '.vel = [long_wind_meas.' direction '.vel; inwind(inds)];']; %store measured winds
        eval(cmd);
        cmd = ['long_wind_meas.' direction '.time = [long_wind_meas.' direction '.time; uwut(inds)];']; %store times 
        eval(cmd);
        cmd = ['long_wind_meas.' direction '.xtick = [long_wind_meas.' direction '.xtick; datenum(datestr(uwut(inds)/86400,''HH:MM:SS''), ''HH:MM:SS'')];'];
        eval(cmd);
        cmd = ['long_wind_meas.' direction '.err = [long_wind_meas.' direction '.err; dinwind(inds)];'];
        eval(cmd);
        
    end
end    
    
    
%% Now plotting
%specify styles for each direction
northStyle = ' ''Color'', ''r''';
southStyle = ' ''Color'', [0.000,  0.498,  0.000] ';
eastStyle = ' ''Color'', [204/255, 204/255, 0/255] ';
westStyle = ' ''Color'', ''m'' ';
measStyle = ' ''.'',''Marker'',''.'', ''MarkerSize'', 12.0, ''LineWidth'', 1.5 ';
dateFormat = 'dd/HH';

h = figure;
set(gca,'XTickLabel','')
hold on

eval(['errorbar(long_wind_meas.north.time,long_wind_meas.north.vel, long_wind_meas.north.err,  ' measStyle ', ' northStyle ')'])

xmin = t_datenum-1; 
xmax = t_datenum+1; 
legend('northLOS'); 
xlim([xmin xmax])
xlabel('Time, Day/Hour [UTC]')
ylabel('Velocity [m/s]')
ylim([-175 125])
grid on
title([ datestr(t_datenum-1, 'yymmdd HH:MM') ' to ' ...
 datestr(t_datenum+1, 'yymmdd HH:MM') ' UT \newline ' ...
 '(b) Millstone Hill FPI line-of-sight Winds']);
datetick('x',dateFormat,'keeplimits')
hold off


fig = gcf;
fig.PaperPosition = [0 0 6 3];
