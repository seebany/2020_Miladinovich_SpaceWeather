% This script plots Figure 1a of Miladinovich et al., 2020.
% It plots Provisional Dst data vs time.
% The Dst data are in a text file Dst_provisional_201503.txt copied and pasted
% from http://wdc.kugi.kyoto-u.ac.jp/dst_provisional/201503/index.html on
% 15 October 2018.
%
% See AUTHORS, LICENSE, and README files for additional information.
% Seebany Datta-Barua 
% Illinois Institute of Technology
% sdattaba@iit.edu
% 16 April 2020

% Clear and set paths.
clear all
close all
addpath(genpath(cd));

% Set time of interest as UTC start and end 
% [year, month, day, hour, minute, second].
t0 = [2015 3 16 0 0 0];
tf = [2015 3 22 0 0 0];

% Gather provisional Dst data.
filename = 'data/Dst_provisional_201503.txt';
[provtime, provdst] = read_Dst_provisional(filename);

% Plot the Dst data.
h = plot(provtime, provdst, 'k-');

% Figure settings.
grid on
set(gca, 'FontSize',12);
set(h, 'LineWidth',2);

% Figure limits.
axislim = axis;
axis([datenum(t0), datenum(tf) axislim(3:4)]);
datetick('x','dd','keeplimits')

% Figure labels.
xlabel('UT Day of March 2015');
ylabel('Dst index [nT]', 'FontSize',12)
title(['(a) Provisional Dst index ' datestr(t0, 'dd') ...
    '-' datestr(datenum(tf)-1, 'dd mmmm yyyy')]);
% Title specifies through date March 21st, but last time plotted is
% midnight on March 22nd.  That is why datenum(tf)-1 is used in the title.

