%% Auditory Plotter

%Define your event codes and each respective intensity value
conds = [11,12,13,14,15,16,17,18,19];
intensities = [0,0.05,0.10,0.15,0.2,0.25,0.3,0.35,0.4];

%Loading log file 
[filename, path] = uigetfile('C:\Users\lhshaw\Documents\GitHub\movingstims\IESweep\logs\*.log','Please select which AUDITORY .log file to analyze');
[struct, cond] = importPresentationLog(strcat(path,filename));

%Mining your log file
block = cond.code;                                          %block is a cell array
tempblock = [];                                             %converting block to a double array
for i = 1:size(block)                                       
    tempblock = [tempblock str2num(cell2mat(block(i)))] 
end 
block = tempblock;
block(end) = 0; 

numberhits = zeros(1,numel(conds));                         %initializing arrays for: holding number of hits, intances and detection rate
numberstims = zeros(1,numel(conds));                        %   for each stimuli
detection = zeros(1,numel(conds));
for i = 1:numel(conds)                                      %looping through each condition: finding number of hits, number of instances of that stimuli
    stimIndcs = find(block==conds(i));                      %   and dividng for the detection rate
    responses = block(stimIndcs+1);
    numberhits(i) = numel(find(responses==1));
    numberstims(i) = numel(stimIndcs);
    detection(i) = numberhits(i) / numberstims(i);
end 

fig = figure;
subplot(2,1,1);
plot(intensities, detection,'Marker','o');
title('Auditory')

%% Visual Plotter

%Define your event codes and each respective intensity value
conds = [101,102,103,104,105,106,107,108,109];
intensities = [0,0.05,0.10,0.15,0.2,0.25,0.3,0.35,0.4];

%Loading log file 
[filename, path] = uigetfile('C:\Users\lhshaw\Documents\GitHub\movingstims\IESweep\logs\*.log','Please select which VISUAL .log file to analyze');
[struct, cond] = importPresentationLog(strcat(path,filename));

%Mining your log file
block = cond.code;                                          %block is a cell array
tempblock = [];                                             %converting block to a double array
for i = 1:size(block)                                       
    tempblock = [tempblock str2num(cell2mat(block(i)))] 
end 
block = tempblock;

numberhits = zeros(1,numel(conds));                         %initializing arrays for: holding number of hits, intances and detection rate
numberstims = zeros(1,numel(conds));                        %   for each stimuli
detection = zeros(1,numel(conds));
for i = 1:numel(conds)                                      %looping through each condition: finding number of hits, number of instances of that stimuli
    stimIndcs = find(block==conds(i));                      %   and dividng for the detection rate
    responses = block(stimIndcs+1);
    numberhits(i) = numel(find(responses==1));
    numberstims(i) = numel(stimIndcs);
    detection(i) = numberhits(i) / numberstims(i);
end 

subplot(2,1,2)
plot(intensities, detection,'Marker','o');
title('Visual')

%% Save Fig
savedestination = 'C:\Users\lhshaw\Documents\GitHub\movingstims\IESweep\plots';
participant = cond.subject{1};
savefig(fig, strcat(savedestination, '\', participant, '_sweep.fig'));
saveas(fig, strcat(savedestination, '\', participant, '_sweep.png'));