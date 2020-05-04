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

%load runs and store relevant data
datadir = 'data/';
rundir{1} = 'Run1_';
rundir{2} = 'Run2_';
rundir{3} = 'Run3_';
filename = 'StormTimeIonDrifts170010_182330.mat';

%Run 3
load([datadir rundir{3} filename],'vs');
vs3 = vs; clear vs;
%Run 2
load([datadir rundir{2} filename],'vs');
vs2 = vs; clear vs;
%Run 1, from which the drift measurement locations selectloc,
%model drifts vm and ISR drifts vISR are also loaded. Those
%variables are identical in all runs.
load([datadir rundir{1} filename],'vs','selectloc', ...
    'xtime', 'vm', 'vISR');%,'utc');
vs1 = vs;% clear vs;

%plotting time interval for Figure 4
t1start = datenum([2015,03,17,13,00,00]);
t1end = datenum([2015,03,18,13,00,00]);
btime = datestr(t1start, 'ddHHMM');
etime = datestr(t1end, 'ddHHMM');

% Plotting time interval for Figure 3
t2start = datenum([2015,03,17,0,00,00]);
t2end = datenum([2015,03,19,0,00,00]);

% selectloc contains both MHISR look directions so selectloc is 1x2 struct.
for sitenum = 1:2
tarlon = selectloc(sitenum).lon;%E
tarlat = selectloc(sitenum).lat;%N
tarht = selectloc(sitenum).ht;
for i = 1:xtime
    
    % Find the closest EMPIRE grid location to the desired location.
    X1 = vs(sitenum,i).long_v;
    X2 = vs(sitenum,i).latg_v;
    X3 = vs(sitenum,i).htg_v;
    disttar = sqrt((X1-tarlon).^2+(X2-tarlat).^2+(X3-tarht).^2);
    inds = find(disttar == min(disttar));
   
    % Find the closest background model grid location to the desired
    % location. This point should be identical to the
    % EMPIRE gridpoint found above.
   X1 = vm(sitenum,i).long_v;
   X2 = vm(sitenum,i).latg_v;
   X3 = vm(sitenum,i).htg_v;
    
   disttar = sqrt((X1-tarlon).^2+(X2-tarlat).^2+(X3-tarht).^2);
   indm2(i) = find(disttar == min(min(min(disttar))));
   indm = indm2(i); 

    time(i) = vs(sitenum,i).time;
    
    % Collect stormtime drift components for Run 1. 
    vszon1(sitenum,i) = vs1(sitenum,i).vZonm(inds);
    vspara1(sitenum,i) = vs1(sitenum,i).vParam(inds);
    vsmerid1(sitenum,i) = vs1(sitenum,i).vMeridm(inds);
    
    % Estimated drift components for Run 2.
    vszon2(sitenum,i) = vs2(sitenum,i).vZonm(inds);
    vspara2(sitenum,i) = vs2(sitenum,i).vParam(inds);
    vsmerid2(sitenum,i) = vs2(sitenum,i).vMeridm(inds);
    
    % Drift components for Run 3.
    vszon3(sitenum,i) = vs3(sitenum,i).vZonm(inds);
    vspara3(sitenum,i) = vs3(sitenum,i).vParam(inds);
    vsmerid3(sitenum,i) = vs3(sitenum,i).vMeridm(inds);
   
    % Model drift components.
   vmzon(sitenum,i) = vm(sitenum,i).zon(indm);
   vmpara(sitenum,i) = vm(sitenum,i).para(indm);
   vmmerid(sitenum,i) = vm(sitenum,i).merid(indm);
    
%    errzon(sitenum,i) = vs(sitenum,i).P(1);
%    errpara(sitenum,i) = vs(sitenum,i).P(2);
%    errmerid(sitenum,i) = vs(sitenum,i).P(3);
    
end
end

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

% Select the data to be plotted for Figure 4. Choose location1 (47 N, 89 W) for zonal and location2 for
% others.
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

%y1errzon = errzon(1, ind1s:ind1e);
%%y1errpara = errpara(1, ind1s:ind1e);
%y1errmerid = errmerid(2, ind1s:ind1e);

y1mzon = vmzon(1, ind1s:ind1e);
%y1mpara = vmpara(1, ind1s:ind1e);
y1mmerid = vmmerid(2, ind1s:ind1e);


% Select the data to be plotted for Figure 3. Choose location1 (47 N, 89 W) for all components.
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

%y2errzon = errzon(1, ind2s:ind2e);
%y2errpara = errpara(1, ind2s:ind2e);
%y2errmerid = errmerid(1, ind2s:ind2e);

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
    ['Loc: Lon = ' num2str(selectloc(1).lon) ' Lat = ' num2str(selectloc(1).lat)]})
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
