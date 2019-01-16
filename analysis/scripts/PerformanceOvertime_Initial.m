% Analysis Script #1: First to run in behavioral analysis pipeline

%Plots auditory, visual and auditory psychometrics for experiment two. Be
% sure to ctrl + enter on the sections you want unless you want data files
% to be accidentally overwriteen. 
%% I: Plotting A,V 
addpath('C:\Users\Allenine\Documents\GitHub\movingstims\functions');

%Loading log file 
[filename, path] = uigetfile('C:\Users\Allenine\Documents\GitHub\movingstims\IEInitial\logs\*.log','Please select which AUDITORY .log file to analyze');
%[filename, path] = uigetfile('C:\Users\achen52\Documents\GitHub\movingstims\IETwo\logs\*.log','Please select which AUDITORY .log file to analyze');
[struct, cond] = importPresentationLog(strcat(path,filename));

%.log file processing
%Aconds = [10,11,12,13];
%intensities = [0 .25 .5 1];
Aconds = [11:21];
Amin = 0;                                                                %The range of stimuli that you want generated
Amax = 0.075;                                                               
Asupra = 0.3;                            
Aintensities = [linspace(Amin,Amax,10) Asupra];

Vconds = [101:111];
Vmin = .025;
Vmax = 0.125;
Vsupra = 0.3;
Vintensities = [0 linspace(Vmin,Vmax,9) Vsupra];

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
output = repmat(zeros(2,11),1,1,9); %output(modality, stimulus type, block)
a = 0;
v = 0;

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
       
    elseif 100 < median(stims) && median(stims) < 110
        v = v + 1;
        for j = 1:numel(Vconds)                                      %looping through each condition: finding number of hits, number of instances of that stimuli
            stimIndcs = find(codes==Vconds(j));                      %   and dividng for the detection rate
            indcsplus1 = codes(stimIndcs+1);
            numberhits(1,j) = numel(find(indcsplus1==1));
            numberstims(1,j) = numel(stimIndcs);
            detection(1,j) = numberhits(1,j) / numberstims(1,j);
        end
        output(2,:,v) = detection;
    end 
end 

fig = figure;
%subplot(3,1,1);
% [param_aud, stat_aud] = sigm_fit(intensities, detection, [], [], 1);
hold on;
plot(1:a, squeeze(mean(output(1,:,:),2)),'Marker','o');
plot(1:v, squeeze(mean(output(2,:,:),2)),'Marker','o');
set(gca,'ylim',[0 1]);
xlabel('nth block');
ylabel('Mean performance on nth block');
legend('Auditory','Visual','Expected');
title('Performance Over Time');
%  %% II: Save Fig
%  savedestination = strcat('C:\Users\Allenine\Documents\GitHub\movingstims\analysis\plots',participant);
%  participant = cond.subject{1};
%  savefig(fig, strcat(savedestination, '\', participant, '_IEInitial_performanceovertime.fig'));
%  saveas(fig, strcat(savedestination, '\', participant, '_IETwo_performanceovertime.png'));

 
 % notes - code could be written to be more efficient, but currently works.
 %  code currently reloads the log file for every modality. It could just
 %  do it once and reuse that variable...
