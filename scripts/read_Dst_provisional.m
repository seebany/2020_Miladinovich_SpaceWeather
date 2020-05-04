% function [time, data] = read_Dst_provisional(filename)
% reads and returns the timestamps as datenums and Dst index data as downloaded from
% http://wdc.kugi.kyoto-u.ac.jp/ 
% on 15 Oct 2018 and stored in Dst_provisional_201503.txt.
%
% The function supports script plot_Fig1a.m for plotting Figure 1a of Miladinovich
% et al., (2020).
%
% See AUTHORS, LICENSE, and README files for additional information.
% Seebany Datta-Barua
% Illinois Institute of Technology
% sdattaba@iit.edu
% 16 April 2020

function [longtime, longdata] = read_Dst_provisional(filename)

longtime = [];
longdata = [];

% Read the year and month from the input file name string.
utc.year = str2num(filename(end-9:end-6));
utc.mon = str2num(filename(end-5:end-4));

fid = fopen(filename, 'r');
% Skip past header.
line = fgetl(fid);
while(~strcmp(line, 'DAY'))
    line = fgetl(fid);
end
while ~feof(fid)
    line = fgetl(fid);
    % parse each line of the file for the hour and Dst index values.
    if ~isempty(line)
    day = str2num(line(1:3));
    for i = 0:7%23;
        hour(i+1) = i;
        data(i+1) = str2num(line(4*(1+i):(4*(1+i)+3))); %Get 4-7, 8-11, etc.
    end
    for i = 8:15%23;
        hour(i+1) = i;
        data(i+1) = str2num(line(4*(1+i)+1:(4*(1+i)+4))); %Get 4-7, 8-11, etc.
    end
    for i = 16:23;
        hour(i+1) = i;
        data(i+1) = str2num(line(4*(1+i)+2:(4*(1+i)+5))); %Get 4-7, 8-11, etc.
    end

% Convert times to datenum.
time = datenum(utc.year, utc.mon, day, hour, 0, 0);
longtime = [longtime; time'];
longdata = [longdata; data'];
    end
end

fclose('all');    

