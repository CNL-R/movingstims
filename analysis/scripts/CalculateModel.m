function [detection, model] = CalculateModel(path, filename)
addpath('C:\Users\Allenine\Documents\GitHub\movingstims\functions');

%Loading log file 
%[filename, path] = uigetfile('C:\Users\Allenine\Documents\GitHub\movingstims\IETwo\logs\*.log','Please select which AUDITORY .log file to analyze');
%[filename, path] = uigetfile('C:\Users\achen52\Documents\GitHub\movingstims\IETwo\logs\*.log','Please select which AUDITORY .log file to analyze');
[struct, cond] = importPresentationLog(strcat(path,filename));

%AUDITORY PLOTTING
%intensities = [0 .25 .5 1];
Aconds = [10:20];
Aintensities = [0 0.1, .20, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9 1.00];

%Mining your log file
block = cond.code;                                          %block is a cell array
tempblock = [];                                             %converting block to a double array
for i = 1:size(block)                                       
    tempblock = [tempblock str2num(cell2mat(block(i)))];
end 
block = tempblock;
block(end) = 0; 

%Calculating Auditory Detection
numberhits = zeros(3,numel(Aconds));                         %initializing arrays for: holding number of hits, intances and detection rate
numberstims = zeros(3,numel(Aconds));                        %   for each stimuli
detection = zeros(3,numel(Aconds));
for h = 1:3
    for i = 1:numel(Aconds)                                      %looping through each condition: finding number of hits, number of instances of that stimuli
        stimIndcs = find(block==Aconds(i));                      %   and dividng for the detection rate
        indcsplus1 = block(stimIndcs+1);
        numberhits(h,i) = numel(find(indcsplus1==1));
        numberstims(h,i) = numel(stimIndcs);
        detection(h,i) = numberhits(h,i) / numberstims(h,i);
    end
end

%Calculating Model
sumterm = detection(1,:) + detection(2,:);
jointprobability = detection(1,:).*detection(2,:);
model = sumterm - jointprobability;
end 

