% This script plots Figures 4 and 3, respectively, of Miladinovich et al.,
% 2020.
% It plots Millstone Hill incoherent scatter radar measurements of ion 
% drifts, Weimer model drifts, and EMPIRE-estimated drifts for Runs 1, 2, 
% and 3 as discussed in the paper (Figure 4).
% It plots Weimer model drifts and EMPIRE-estimated drifts for Runs 1, 2,
% and 3 as discussed in the paper (Figure 3). 
% The figures may differ from the ones in the paper in placement of the 
% legend, which was manually adjusted.
%
% See AUTHORS, LICENSE, and README for additional information.
% Seebany Datta-Barua
% Illinois Institute of Technology
% sdattaba@iit.edu

clear
close all

%plotting time interval for Figure 4
t1start = datenum([2015,03,17,13,00,00]);
t1end = datenum([2015,03,18,13,00,00]);
btime = datestr(t1start, 'ddHHMM');
etime = datestr(t1end, 'ddHHMM');

% Plotting time interval for Figure 3
t2start = datenum([2015,03,17,0,00,00]);
t2end = datenum([2015,03,19,0,00,00]);

load('data/Figs3and4_results.mat');

LineWidthsMean = 2;
LineWidthsStDev = 1;
colors = get(groot,'defaultAxesColorOrder');

%==========================================================================
%Filter the times for each direction (MODEL)(2dirs)
%==========================================================================
ind1s = find(abs(t1start - time) == min(abs(t1start - time)));
ind1e = find(abs(t1end - time) == min(abs(t1end - time)));
ind2s = find(abs(t2start - time) == min(abs(t2start - time)));
ind2e = find(abs(t2end - time) == min(abs(t2end - time)));

%=========================================================================
% Select data to be plotted in each figure.
%=========================================================================
% Select the data to be plotted for Figure 4. Choose location1 (47 N, 89 W) 
% for zonal and location2 (53 N, 75 W) for meridional.
x1 = time(ind1s:ind1e);
y1szon1 = vszon1(1,ind1s:ind1e);
%y1spara1 = vspara1(1,ind1s:ind1e);
y1smerid1 = vsmerid1(2,ind1s:ind1e);

y1szon2 = vszon2(1,ind1s:ind1e);
%y1spara2 = vspara2(1,ind1s:ind1e);
y1smerid2 = vsmerid2(2,ind1s:ind1e);

y1szon3 = vszon3(1,ind1s:ind1e);
%y1spara3 = vspara3(1, ind1s:ind1e);
y1smerid3 = vsmerid3(2, ind1s:ind1e);

y1mzon = vmzon(1, ind1s:ind1e);
%y1mpara = vmpara(1, ind1s:ind1e);
y1mmerid = vmmerid(2, ind1s:ind1e);


% Select the data to be plotted for Figure 3. Choose location1 (47 N, 89 W) for 
% all components.
x2 = time(ind2s:ind2e);
y2szon1 = vszon1(1,ind2s:ind2e);
y2spara1 = vspara1(1, ind2s:ind2e);
y2smerid1 = vsmerid1(1, ind2s:ind2e);

y2szon2 = vszon2(1, ind2s:ind2e);
y2spara2 = vspara2(1, ind2s:ind2e);
y2smerid2 = vsmerid2(1, ind2s:ind2e);

y2szon3 = vszon3(1, ind2s:ind2e);
y2spara3 = vspara3(1, ind2s:ind2e);
y2smerid3 = vsmerid3(1, ind2s:ind2e);

y2mzon = vmzon(1, ind2s:ind2e);
y2mpara = vmpara(1, ind2s:ind2e);
y2mmerid = vmmerid(1, ind2s:ind2e);


%==========================================================================
% Figure 4, comparison to ISR.
%==========================================================================

%first axis
fig = figure('Visible','on');
ax1 = subplot(2,1,1);
hold on
hd = errorbar(vISR.time,vISR.vzon, vISR.vzonerr, 'Color','black',...
    'LineWidth',LineWidthsMean,'LineStyle','-');
h1 = plot(x1,y1szon1,'Color',colors(1,:),'LineWidth',LineWidthsMean+2);
h2 = plot(x1,y1szon2,'Color',colors(2,:),'LineWidth',LineWidthsMean+2);
h3 = plot(x1,y1szon3,'Color',colors(3,:),'LineWidth',LineWidthsMean);
% Include the Weimer model drifts on the plots.
hm = plot(x1,y1mzon, 'Color',colors(4,:),'LineWidth',LineWidthsMean/1, ...
    'LineStyle','--');
grid on
grid minor
axis tight
ax = axis;
axis([datenum([2015 3 17 15 0 0]), datenum([2015 3 18 12 0 0]), ax(3:4)]);

ax2 = subplot(2,1,2);
hold on
hd = errorbar(vISR.time,vISR.vmer, vISR.vmererr, 'Color','black',...
    'LineWidth',LineWidthsMean,'LineStyle','-');
h1 = plot(x1,y1smerid1,'Color',colors(1,:),'LineWidth',LineWidthsMean+2);
h2 = plot(x1,y1smerid2,'Color',colors(2,:),'LineWidth',LineWidthsMean+2);
h3 = plot(x1,y1smerid3,'Color',colors(3,:),'LineWidth',LineWidthsMean);

% Include Weimer model drifts.
hm = plot(x1, y1mmerid, 'Color',colors(4,:), 'LineWidth', LineWidthsMean/1, ...
    'LineStyle','--');
grid on
grid minor
axis tight
ax = axis;
axis([datenum([2015 3 17 15 0 0]), datenum([2015 3 18 12 0 0]), ax(3:4)]);

ylabel(ax1, 'Field-perpendicular \newline Zonal Drift [m/s]')
ylabel(ax2, 'Field-perpendicular \newline Meridional Drift [m/s]')
xlabel(ax2, 'Time, Day/Hour [UTC]')
set(ax1,'Xticklabel',[])
set(ax2,'Xticklabel',[])
datetick(ax2,'x','DD/HH','keeplimits')
datetick(ax1,'x','DD/HH','keeplimits')

title(ax1, {'(a) Ion Drifts in Field Aligned Frame'; ...
    ['Loc: Lon = ' num2str(selectloc(1).lon) ' Lat = ' num2str(selectloc(1).lat)
]})
title(ax2, ['(b) Loc: Lon = ' num2str(selectloc(2).lon) ' Lat = ' ...
    num2str(selectloc(2).lat)]);
h = legend(ax2,'ISR Measurements','No FPI, Correct V', 'No FPI, Correct V and uN', ...
    'Ingest FPI N, Correct V and uN', 'Background model', 'Location',...
   'best');

%==========================================================================
% Plot Figure 3: three ion drift components over time for three runs, 
% compared to model drift.
%==========================================================================

%first axis
fig = figure('Visible','on');
ax1 = subplot(3,1,1);
hold on
h1 = plot(x2,y2szon1,'Color',colors(1,:),'LineWidth',LineWidthsMean+2);
h2 = plot(x2,y2szon2,'Color',colors(2,:),'LineWidth',LineWidthsMean+2);
h3 = plot(x2,y2szon3,'Color',colors(3,:),'LineWidth',LineWidthsMean);
hm = plot(x2,y2mzon,'Color',colors(4,:),'LineWidth',LineWidthsMean, ...
    'LineStyle','--');
grid on
grid minor
axis tight
ax = axis;
axis([t2start t2end ax(3:4)])

ax2 = subplot(3,1,2);
hold on
h1 = plot(x2,y2smerid1,'Color',colors(1,:),'LineWidth',LineWidthsMean+2);
h2 = plot(x2,y2smerid2,'Color',colors(2,:),'LineWidth',LineWidthsMean+2);
h3 = plot(x2,y2smerid3,'Color',colors(3,:),'LineWidth',LineWidthsMean);
hm = plot(x2, y2mmerid,'Color',colors(4,:),'LineWidth',LineWidthsMean, ...
    'LineStyle','--');
grid on
grid minor
axis tight
ax = axis;
axis([t2start t2end ax(3:4)])

ax3 = subplot(3,1,3);
hold on
h1 = plot(x2,y2spara1,'Color',colors(1,:),'LineWidth',LineWidthsMean+2);
h2 = plot(x2,y2spara2,'Color',colors(2,:),'LineWidth',LineWidthsMean+2);
h3 = plot(x2,y2spara3,'Color',colors(3,:),'LineWidth',LineWidthsMean);
hm = plot(x2,y2mpara,'Color',colors(4,:),'LineWidth',LineWidthsMean, ...
    'LineStyle','--');
grid on
grid minor
axis tight
ax = axis;
axis([t2start t2end ax(3:4)])

ylabel(ax1, 'Field-perpendicular \newline Zonal Drift [m/s]')
ylabel(ax2, 'Field-perpendicular \newline Meridional Drift [m/s]')
ylabel(ax3, 'Field- parallel Drift [m/s]')
xlabel(ax3, 'Time, Day/Hour [UTC]')
ax3.XTickLabelRotation = 0;
datetick(ax1,'x','DD/HH','keeplimits')
datetick(ax2,'x','DD/HH','keeplimits')
datetick(ax3,'x','DD/HH','keeplimits')
set(ax1,'Xticklabel',[])
set(ax2,'Xticklabel',[])


title(ax1, {'Ion Drifts In Field Aligned Frame'; ...
    ['Loc: Lon = ' num2str(selectloc(1).lon) ...
    ' Lat = ' num2str(selectloc(1).lat)]})

legh = legend(ax2,'No FPI, Correct V', 'No FPI, Correct V and uN', ...    
    'Ingest FPI N, Correct V and uN', 'Background model', 'Location','best');
set(legh, 'Position',[0.6, 0.5, 0.3156, 0.0910]);
