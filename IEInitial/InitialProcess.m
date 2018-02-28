%% Auditory Plotter

%Define your event codes and each respective intensity value
Aconds = [11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26];
intensities = [0,0.005,0.01,0.02125,0.0325,0.038125,0.04375,0.049375,0.055,0.060625,0.06625,0.071875,0.0775,0.08875,0.1,0.3];

%Loading log file 
[filename, path] = uigetfile('C:\Users\lhshaw\Desktop\movingstims\IEInitial\logs\*.log','Please select which AUDITORY .log file to analyze');
[struct, cond] = importPresentationLog(strcat(path,filename));

%Mining your log file
block = cond.code;                                          %block is a cell array
tempblock = [];                                             %converting block to a double array
for i = 1:size(block)                                       
    tempblock = [tempblock str2num(cell2mat(block(i)))];
end 
block = tempblock;
block(end) = 0; 

numberhits = zeros(1,numel(Aconds));                         %initializing arrays for: holding number of hits, intances and detection rate
numberstims = zeros(1,numel(Aconds));                        %   for each stimuli
numberstims(:,:) = 40;
detection = zeros(1,numel(Aconds));
for i = 1:numel(Aconds)                                      %looping through each condition: finding number of hits, number of instances of that stimuli
    stimIndcs = find(block==Aconds(i));                      %   and dividng for the detection rate
    responses = block(stimIndcs+1);
    numberhits(i) = numel(find(responses==1));
    %numberstims(i) = numel(stimIndcs);
    detection(i) = numberhits(i) / numberstims(i);
end 

fig = figure;
subplot(2,1,1);
[param_aud, stat_aud] = sigm_fit(intensities, detection, [], [], 1);
hold on;
plot(intensities, detection,'Marker','o');
title('Auditory')

%VISUAL PLOTTING

%Define your event codes and each respective intensity value
Vconds = [101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116];
intensities = [0,0.005,0.01,0.02125,0.0325,0.038125,0.04375,0.049375,0.055,0.060625,0.06625,0.071875,0.0775,0.08875,0.1,0.3];

%Mining your log file
block = cond.code;                                          %block is a cell array
tempblock = [];                                             %converting block to a double array
for i = 1:size(block)                                       
    tempblock = [tempblock str2num(cell2mat(block(i)))]; 
end 
block = tempblock;

numberhits = zeros(1,numel(Vconds));                         %initializing arrays for: holding number of hits, intances and detection rate
numberstims = zeros(1,numel(Vconds));                        %   for each stimuli
detection = zeros(1,numel(Vconds));
for i = 1:numel(Vconds)                                      %looping through each condition: finding number of hits, number of instances of that stimuli
    stimIndcs = find(block==Vconds(i));                      %   and dividng for the detection rate
    responses = block(stimIndcs+1);
    numberhits(i) = numel(find(responses==1));
    numberstims(i) = numel(stimIndcs);
    detection(i) = numberhits(i) / numberstims(i);
end 

subplot(2,1,2)
[param_vis, stat_vis] = sigm_fit(intensities, detection, [], [], 1);
hold on; 
plot(intensities, detection,'Marker','o');

title('Visual');

%% Save Fig
savedestination = 'C:\Users\lhshaw\Documents\GitHub\movingstims\IEInitial\plots';
participant = cond.subject{1};
savefig(fig, strcat(savedestination, '\', participant, '_initial.fig'));
saveas(fig, strcat(savedestination, '\', participant, '_initial.png'));

%% Pulling out 30-60-90
x = 0:0.00001:1;
audOutput = sigm_fit_val(param_aud, x);
visOutput = sigm_fit_val(param_vis, x);

aud30greater = find(audOutput>=.3);
aud30 = aud30greater(1) * .00001
aud70greater = find(audOutput>=.7);
aud70 = aud70greater(1) * .00001
aud90greater = find(audOutput>=.9);
aud90 = aud90greater(1) * .00001

vis30greater = find(visOutput>=.3);
vis30 = vis30greater(1) * .00001
vis70greater = find(visOutput>=.7);
vis70 = vis70greater(1) * .00001
vis90greater = find(visOutput>=.9);
vis90 = vis90greater(1) * .00001