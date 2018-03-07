%% Auditory Plotter

%Define your event codes and each respective intensity value
Aconds = [11,12,13];
intensities = [0.0311 0.0382 0.0440];

%Loading log file 
[filename, path] = uigetfile('C:\Users\lhshaw\Documents\GitHub\movingstims\IETwo\logs\*.log','Please select which AUDITORY .log file to analyze');
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
detection = zeros(1,numel(Aconds));
for i = 1:numel(Aconds)                                      %looping through each condition: finding number of hits, number of instances of that stimuli
    stimIndcs = find(block==Aconds(i));                      %   and dividng for the detection rate
    responses = block(stimIndcs+1);
    numberhits(i) = numel(find(responses==1));
    numberstims(i) = numel(stimIndcs);
    detection(i) = numberhits(i) / numberstims(i);
end 

fig = figure;
subplot(3,1,1);
% [param_aud, stat_aud] = sigm_fit(intensities, detection, [], [], 1);
hold on;
plot(intensities, detection,'Marker','o');
title('Auditory')

%VISUAL PLOTTING

%Define your event codes and each respective intensity value
Vconds = [21,22,23];
intensities = [0.0471 .0563 0.0643];

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

subplot(3,1,2)
% [param_vis, stat_vis] = sigm_fit(intensities, detection, [], [], 1);
hold on; 
plot(intensities, detection,'Marker','o');

title('Visual');

%AUDIOVISUAL PLOTTING

%Define your event codes and each respective intensity value
Vconds = [31,32,33];
intensities = [0.3 .70 .9];

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

subplot(3,1,3)
% [param_vis, stat_vis] = sigm_fit(intensities, detection, [], [], 1);
hold on; 
plot(intensities, detection,'Marker','o');

title('Audiovisual');
% %% Save Fig
% savedestination = 'C:\Users\lhshaw\Documents\GitHub\movingstims\IEInitial\plots';
% participant = cond.subject{1};
% savefig(fig, strcat(savedestination, '\', participant, '_initial.fig'));
% saveas(fig, strcat(savedestination, '\', participant, '_initial.png'));
