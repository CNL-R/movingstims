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

%.log file processing
%Aconds = [10,11,12,13];
%intensities = [0 .25 .5 1];
Aconds = [10:20];
Aintensities = [0 0.1, .20, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9 1.00];
Vconds = [30:40];
Vintensities = [0:0.1:1];
AVintensities = [0:0.1:1];
AVconds = [50:60];

%Mining your log file
block = cond.code;                                          %block is a cell array
tempblock = [];                                             %converting block to a double array
for i = 1:size(block)                                       
    tempblock = [tempblock str2num(cell2mat(block(i)))];
end 
block = tempblock;
block(end) = 0; 
block = [block 255];    
blockstarts = find(block==255);
output = repmat(zeros(3,11),1,1,10); %output(modality, stimulus type, block)
a = 0;
v = 0;
av = 0;
                                    %so code can operate on last block. 
for i = 1:numel(blockstarts) - 1
    codes = block(blockstarts(i):blockstarts(i+1)-1);       %all codes in between 255 press and next 255 press (excluding 255 press)
    responses = find(codes == 1);
    stims = codes; stims(responses) = [];
    numberhits = zeros(1,numel(Aconds));
    numberstims = zeros(1,numel(Aconds)); 
    detection = zeros(1,numel(Aconds));
    codes = [codes 0];
    if 10 < median(stims)&& median(stims) < 20
        a = a + 1;
        for j = 1:numel(Aconds)                                      %looping through each condition: finding number of hits, number of instances of that stimuli
            stimIndcs = find(codes==Aconds(j));                      %   and dividng for the detection rate
            indcsplus1 = codes(stimIndcs+1);
            numberhits(1,j) = numel(find(indcsplus1==1));
            numberstims(1,j) = numel(stimIndcs);
            detection(1,j) = numberhits(1,j) / numberstims(1,j);
        end
    output(1,:,a) = detection;
        
    elseif 30 < median(stims) && median(stims) < 40
        v = v + 1;
        for j = 1:numel(Vconds)                                      %looping through each condition: finding number of hits, number of instances of that stimuli
            stimIndcs = find(codes==Vconds(j));                      %   and dividng for the detection rate
            indcsplus1 = codes(stimIndcs+1);
            numberhits(1,j) = numel(find(indcsplus1==1));
            numberstims(1,j) = numel(stimIndcs);
            detection(1,j) = numberhits(1,j) / numberstims(1,j);
        end
        output(2,:,v) = detection;

    elseif 50 < median(stims) && median(stims) < 60
        av = av + 1;
        for j = 1:numel(AVconds)                                      %looping through each condition: finding number of hits, number of instances of that stimuli
            stimIndcs = find(codes==AVconds(j));                      %   and dividng for the detection rate
            indcsplus1 = codes(stimIndcs+1);
            numberhits(1,j) = numel(find(indcsplus1==1));
            numberstims(1,j) = numel(stimIndcs);
            detection(1,j) = numberhits(1,j) / numberstims(1,j);
        end
        output(3,:,av) = detection;
    end 
end 

fig = figure;
%subplot(3,1,1);
% [param_aud, stat_aud] = sigm_fit(intensities, detection, [], [], 1);
hold on;
plot(1:a, squeeze(mean(output(1,:,:),2)),'Marker','o');
plot(1:v, squeeze(mean(output(2,:,:),2)),'Marker','o');
plot(1:av, squeeze(mean(output(3,:,:),2)),'Marker','o');
plot(1:10,repmat(0.5,1,10), 'LineStyle', '-', 'Marker', 'none', 'Color', 'black');
set(gca,'ylim',[0 1]);
xlabel('nth block');
ylabel('Mean performance on nth block');
legend('Auditory','Visual','Audiovisual', 'Expected');
title('Performance Over Time');
 %% II: Save Fig
 savedestination = 'C:\Users\Allenine\Documents\GitHub\movingstims\IETwo\plots';
 participant = cond.subject{1};
 savefig(fig, strcat(savedestination, '\', participant, '_IETwo_CoPlot.fig'));
 saveas(fig, strcat(savedestination, '\', participant, '_IETwo_CoPlot.png'));

 
 % notes - code could be written to be more efficient, but currently works.
 %  code currently reloads the log file for every modality. It could just
 %  do it once and reuse that variable...
