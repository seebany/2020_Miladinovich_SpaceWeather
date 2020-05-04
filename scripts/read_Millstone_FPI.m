% This function reads in FPI data files of the form Millstone_FPI_yyyymmdd.txt
% obtained of the Millstone Hill high-resolution FPI from the CEDAR Madrigal website
% The function supports script plot_Fig1b.m for producing Figure 1b of 
% Miladinovich et al., (2020).
%
% See AUTHORS, LICENSE, and README files for additional information.
% Seebany Datta-Barua
% Illinois Institute of Technology
% sdattaba@iit.edu
% 16 Apr 2020

function [uwut, azm, elm, gdalt, vnu, dvnu, wind_err] = read_Millstone_FPI(filen
ame)

% Load file into matrix S.
S=load(filename);

% Each column in S corresponds to the following.
temp = 'YEAR,MONTH,DAY,HOUR,MINUTE,SECOND,GDALT,AZM,ELM,VNU,DVNU,WIND_ERR';
temp = textscan(temp,'%s%s%s%s%s%s%s%s%s%s%s%s','Delimiter', ',');
    
bad=find(isnan(S(:,10)));
        
S(bad, :)=[];

% Assign a variable name to each column e.g., year = S(:,1);
for i=1:length(temp)
    command = [lower(char(temp{i})), '=', 'S(:, i);' ];
    eval(command);
end

uwut = datenum([year month day hour minute second]);
clear temp command
