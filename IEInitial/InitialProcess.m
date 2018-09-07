%Plotter for A & V Initial Psych Curves. Be sure to ctrl+enter instead of
%just hitting run unless you want to save the data! (Be careful of
%overwriting)

%% A & V Psychometric Plotting
%IF YOU'VE CHANGED the intensity values from what is normally used in the
%experiment change the intensities variables! 
addpath('C:\Users\lhshaw\Documents\GitHub\movingstims\functions');

%AUDITORY PLOTTER

%Define your event codes and each respective intensity value
Aconds = [11,12,13,14,15,16,17,18,19,20,21,22];
intensities = [0,0.0075,0.015,0.0225,0.03,0.0375,0.045,0.0525,0.06,0.0675,0.075,0.3]; %%CHANGE THIS if you change the stim intensities

%Loading log file 
[filename, path] = uigetfile('C:\Users\lhshaw\Documents\GitHub\movingstims\IEInitial\logs\*.log','Please select which AUDITORY .log file to analyze');
[struct, cond] = importPresentationLog(strcat(path,filename));

%Mining your log file
block = cond.code;                                                         %block is a cell array
tempblock = [];                                                            %converting block to a double array
for i = 1:size(block)                                       
    tempblock = [tempblock str2num(cell2mat(block(i)))];
end 
block = tempblock;
block(end) = 0;                                                            %sometimes the end of the block array is a nondouble, so we make it 0 to prevent errors

numberhits = zeros(2,numel(Aconds));                                       %initializing arrays for: holding number of hits, instances and detection rate
numberstims = zeros(2,numel(Aconds));                                      %   for each stimuli
detection = zeros(2,numel(Aconds));
for i = 1:numel(Aconds)                                                    %looping through each condition: finding number of hits, number of instances of that stimuli
    stimIndcs = find(block==Aconds(i));                                    %   and dividng for the detection rate
    responses = block(stimIndcs+1);
    numberhits(1,i) = numel(find(responses==1));
    numberstims(1,i) = numel(stimIndcs);
end 
detection(1,:) = numberhits(1,:) ./ numberstims(1,:);
fig = figure;
subplot(2,1,1);
[param_aud, stat_aud] = sigm_fit(intensities, detection(1,:), [], [], 1);  %sigmoid fitting function
hold on;
plot(intensities, detection(1,:),'Marker','o');
set(gca,'ylim',[0 1]);
title('Auditory')

%VISUAL PLOTTING

%Define your event codes and each respective intensity value
Vconds = [101,102,103,104,105,106,107,108,109,110,111,112];
intensities = [0,0.0250000000000000,0.0333333333333333,0.0416666666666667,0.0500000000000000,0.0583333333333333,0.0666666666666667,0.0750000000000000,0.0833333333333333,0.0916666666666667,0.100000000000000,0.300000000000000];

%Mining your log file
block = cond.code;                                          %block is a cell array
tempblock = [];                                             %converting block to a double array
for i = 1:size(block)                                       
    tempblock = [tempblock str2num(cell2mat(block(i)))]; 
end 
block = tempblock;

for i = 1:numel(Vconds)                                      %looping through each condition: finding number of hits, number of instances of that stimuli
    stimIndcs = find(block==Vconds(i));                      %   and dividng for the detection rate
    responses = block(stimIndcs+1);
    numberhits(2,i) = numel(find(responses==1));
    numberstims(2,i) = numel(stimIndcs);
    detection(2,i) = numberhits(2,i) / numberstims(2,i);
end 

subplot(2,1,2)
[param_vis, stat_vis] = sigm_fit(intensities, detection(2,:), [], [], 1);
hold on; 
plot(intensities, detection(2,:),'Marker','o');
set(gca,'ylim',[0 1]);
title('Visual');
%print('Allen','-dsvg')
%% Save Figs
savedestination = 'C:\Users\lhshaw\Documents\GitHub\movingstims\IEInitial\plots';
participant = cond.subject{1};
savefig(fig, strcat(savedestination, '\', participant, '_initial.fig'));
saveas(fig, strcat(savedestination, '\', participant, '_initial.png'));

%% Calculating 25-50
x = 0:0.00001:1;
audOutput = sigm_fit_val(param_aud, x);
visOutput = sigm_fit_val(param_vis, x);

aud25greater = find(audOutput>=.25);                                        %All elements greater than 0.3 in audOutput
aud25 = aud25greater(1) * .00001                                           %The first element of aud25greater is the smallest element greater or equal to 0.3
aud50greater = find(audOutput>=.5);
aud50 = aud50greater(1) * .00001

vis25greater = find(visOutput>=.25);
vis25 = vis25greater(1) * .00001
vis50greater = find(visOutput>=.5);
vis50 = vis50greater(1) * .00001
