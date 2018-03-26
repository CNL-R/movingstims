addpath('C:\Users\lhshaw\Documents\GitHub\movingstims\functions');

direc = uigetdir;                                      %get the directory containing all of the participant folders
folders = dir(direc);
id = {folders([folders(:).isdir]).name};               %get the names of the folders in the root directory, ignore anything else
id(ismember(id,{'.','..'})) = [];  

for i = 1:size(id,2)
    filename = strcat(id{1},'-IETwo','.log');
    path = strcat('D:\Smart-IE\',id{1},'\',filename);
    [struct, cond] = importPresentationLog(path);
    
    %AUDITORY PLOTTING
    %Define your event codes and each respective intensity value
    Aconds = [11,12,13];
    intensities = [.3 .6 .9];
    
    %Mining your log file
    block = cond.code;                                          %block is a cell array
    tempblock = [];                                             %converting block to a double array
    for j = 1:size(block)
        tempblock = [tempblock str2num(cell2mat(block(j)))];
    end
    block = tempblock;
    block(end) = 0;
    
    numberhits = zeros(3,numel(Aconds));                         %initializing arrays for: holding number of hits, intances and detection rate
    numberstims = zeros(3,numel(Aconds));                        %   for each stimuli
    detection = zeros(3,numel(Aconds));
    for j = 1:numel(Aconds)                                      %looping through each condition: finding number of hits, number of instances of that stimuli
        stimIndcs = find(block==Aconds(j));                      %   and dividng for the detection rate
        indcsplus1 = block(stimIndcs+1);
        numberhits(1,j) = numel(find(indcsplus1==1));
        numberstims(1,j) = numel(stimIndcs);
        detection(1,j) = numberhits(1,j) / numberstims(1,j);
    end
    
    fig = figure;
    subplot(3,1,1);
    % [param_aud, stat_aud] = sigm_fit(intensities, detection, [], [], 1);
    hold on;
    plot(intensities, detection(1,:),'Marker','o');
    set(gca,'ylim',[0 1]);
    title('Auditory')
    
    %VISUAL PLOTTING
    
    %Define your event codes and each respective intensity value
    Vconds = [21,22,23];
    intensities = [.3 .6 .9];
    
    %Mining your log file
    block = cond.code;                                          %block is a cell array that contains all codes from the experiment
    tempblock = [];                                             %converting block to a double array
    for i = 1:size(block)
        tempblock = [tempblock str2num(cell2mat(block(i)))];
    end
    block = tempblock;
    
    for i = 1:numel(Vconds)                                      %looping through each condition: finding number of hits, number of instances of that stimuli
        stimIndcs = find(block==Vconds(i));                      %   and dividng for the detection rate
        indcsplus1 = block(stimIndcs+1);
        numberhits(2,i) = numel(find(indcsplus1==1));
        numberstims(2,i) = numel(stimIndcs);
        detection(2,i) = numberhits(2,i) / numberstims(2,i);
    end
    
    subplot(3,1,2)
    % [param_vis, stat_vis] = sigm_fit(intensities, detection, [], [], 1);
    hold on;
    plot(intensities, detection(2,:),'Marker','o');
    set(gca,'ylim',[0 1]);
    title('Visual');
    
    %AUDIOVISUAL PLOTTING
    
    %Define your event codes and each respective intensity value
    AVconds = [31,32,33];
    intensities = [0.3 .6 .9];
    
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
    
    subplot(3,1,3)
    % [param_vis, stat_vis] = sigm_fit(intensities, detection, [], [], 1);
    hold on;
    plot(intensities, detection(3,:),'Marker','o');
    set(gca,'ylim',[0 1]);
    title('Audiovisual');
end