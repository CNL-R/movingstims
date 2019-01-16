% Analysis Script #1: First to run in behavioral analysis pipeline

%Plots auditory, visual and auditory psychometrics for experiment two. Be
% sure to ctrl + enter on the sections you want unless you want data files
% to be accidentally overwriteen. 
%% I: Plotting A,V & AV Psychometrics
addpath('C:\Users\Allenine\Documents\GitHub\movingstims\functions');

%Loading log file 
[filename, path] = uigetfile('C:\Users\Allenine\Documents\GitHub\movingstims\IETwo\logs\*.log','Please select which AUDITORY .log file to analyze');
%[filename, path] = uigetfile('C:\Users\achen52\Documents\GitHub\movingstims\IETwo\logs\*.log','Please select which AUDITORY .log file to analyze');
[struct, cond] = importPresentationLog(strcat(path,filename));

%AUDITORY PLOTTING
%Define your event codes and each respective intensity value
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
blockidentities = IdentifyBlocks(block)

numberhits = zeros(3,numel(Aconds));                         %initializing arrays for: holding number of hits, intances and detection rate
numberstims = zeros(3,numel(Aconds));                        %   for each stimuli
detection = zeros(3,numel(Aconds));
for i = 1:numel(Aconds)                                      %looping through each condition: finding number of hits, number of instances of that stimuli
    stimIndcs = find(block==Aconds(i));                      %   and dividng for the detection rate
    indcsplus1 = block(stimIndcs+1);
    numberhits(1,i) = numel(find(indcsplus1==1));
    numberstims(1,i) = numel(stimIndcs);
    detection(1,i) = numberhits(1,i) / numberstims(1,i);
end 

fig = figure;
hold on;
plot(Aintensities, detection(1,:),'Marker','o');
set(gca,'ylim',[0 1]);
title('Auditory')

%VISUAL PLOTTING

%Define your event codes and each respective intensity value
Vconds = [30:40];
Vintensities = [0:0.1:1];

%Mining your log file
block = cond.code;                                          %block is a cell array that contains all codes from the experiment
tempblock = [];                                             %converting block to a double array
for i = 1:size(block)                                       
    tempblock = [tempblock str2num(cell2mat(block(i)))]; 
end 
block = tempblock;
block = [block 0];

for i = 1:numel(Vconds)                                      %looping through each condition: finding number of hits, number of instances of that stimuli
    stimIndcs = find(block==Vconds(i));                      %   and dividng for the detection rate
    indcsplus1 = block(stimIndcs+1);
    numberhits(2,i) = numel(find(indcsplus1==1));
    numberstims(2,i) = numel(stimIndcs);
    detection(2,i) = numberhits(2,i) / numberstims(2,i);
end 

hold on; 
plot(Aintensities, detection(2,:),'Marker','o');
set(gca,'ylim',[0 1]);
title('Visual');

%AUDIOVISUAL PLOTTING
%Define your event codes and each respective intensity value
AVintensities = [0:0.1:1];
AVconds = [50:60];
%Mining your log file
block = cond.code;                                          %block is a cell array
tempblock = [];                                             %converting block to a double array
for i = 1:size(block)                                       
    tempblock = [tempblock str2num(cell2mat(block(i)))]; 
end 
block = tempblock;

for i = 1:numel(AVconds)                                      %looping through each condition: finding number of hits, number of instances of that stimuli
    stimIndcs = find(block==AVconds(i));                      %   and dividng for the detection rate
    indcsplus1 = block(stimIndcs+1);
    numberhits(3,i) = numel(find(indcsplus1==1));
    numberstims(3,i) = numel(stimIndcs);
    detection(3,i) = numberhits(3,i) / numberstims(3,i);
end 


hold on; 
plot(AVintensities, detection(3,:),'Marker','o');
set(gca,'ylim',[0 1]);
title('Auditory, Visual and Audiovisual Detection versus Intended Detectability');

%MODEL
sumterm = detection(1,:) + detection(2,:);
jointprobability = detection(1,:).*detection(2,:);
model = sumterm - jointprobability;
plot(AVintensities, model, 'Marker', 'o');

legend('Auditory', 'Visual', 'Audiovisual', 'Location', 'southeast', 'P(A)+P(V) - P(A)P(V)');
xlabel('Intended Detectability');
ylabel('Hit Probability');

