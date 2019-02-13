function [PHASEII] = mineParticipant_PhaseII(struct)
%Takes struct from importPresentationLog as input


AcondsPhaseII = [10:20];
VcondsPhaseII = [30:40];
AVcondsPhaseII = [50:60];

%Isolating codes and RTs cells
codes = {struct.code};
RTs = {struct.ttime};
removeIndices = cellfun('isempty', codes);
codes(removeIndices) = [];
RTs(removeIndices) = [];
codes{1,end+1} = '0';                         %Solve indexing error with stimsp1 increasing above max size of array
RTs{1,end+1} = 0;
RTs = cell2mat(RTs)./10;
%% AUDITORY: EXTRACTING HITS & RTs

%FINDING HITS
for i = 1:size(AcondsPhaseII,2)
    stims(i,:) = find(strcmp(codes,num2str(AcondsPhaseII(i))));
    stimsp1(i,:) = stims(i,:)+1;
    hits{i} = find(strcmp(codes(stimsp1(i,:)),'1'));
end 

% FINDING PHYSIOLOGICALLY IMPOSSIBLE HITS 
threshold = 100; %remove all RTs <100 ms 
for i = 1:size(AcondsPhaseII,2)
    hits_RT{i} = RTs(stimsp1(i,hits{i}));
    pastThreshold = find(hits_RT{i}<threshold);
    hits_RT{i}(pastThreshold) = [];
    hits{i}(pastThreshold) = [];
    %At this point, hits and hits_RT are aligned. Due to removing of
    %sub-threshold stimuli, other matrices will not match up with these
    %two. 
end 

%RTs
for i = 1:size(AcondsPhaseII,2)
    if numel(hits_RT{i}) > 0
        mean_RTs{i} = mean(hits_RT{i});
        RTs_SD{i} = std(hits_RT{i});
    else 
        mean_RTs{i} = 0;
        RTs_SD{i} = 0;
    end
end 

%% VISUAL: EXTRACTING HITS & RTs

for i = size(AcondsPhaseII,2)+1:size(AcondsPhaseII,2) + size(VcondsPhaseII,2)
    stims(i,:) = find(strcmp(codes,num2str(VcondsPhaseII(i-size(VcondsPhaseII,2)))));
    stimsp1(i,:) = stims(i,:)+1;
    hits{i} = find(strcmp(codes(stimsp1(i,:)),'1'));
end 

% %FINDING PHYSIOLOGICALLY IMPOSSIBLE HITS
%threshold = 100;
threshold = 0; %(WE DO NOT CALC SIGMOID FROM CORRECTED DATA ONLINE)
for i = size(AcondsPhaseII,2)+1:size(AcondsPhaseII,2)+size(VcondsPhaseII,2)
    hits_RT{i} = RTs(stimsp1(i,hits{i}));
    pastThreshold = find(hits_RT{i}<threshold);
    hits_RT{i}(pastThreshold) = [];
    hits{i}(pastThreshold) = [];
    %At this point, hits and hits_RT are aligned. Due to removing of
    %sub-threshold stimuli, other matrices will not match up with these
    %two. 
end 

%RTs
for i = size(AcondsPhaseII,2)+1:size(AcondsPhaseII,2)+size(VcondsPhaseII,2)
    if numel(hits_RT{i}) > 0
        mean_RTs{i} = mean(hits_RT{i});
        RTs_SD{i} = std(hits_RT{i});
    else 
        mean_RTs{i} = 0;
        RTs_SD{i} = 0;
    end
end

%% AUDIOVISUAL: EXTRACTING HITS & RTs

for i = size(AcondsPhaseII,2) + size(VcondsPhaseII,2)+1:size(AcondsPhaseII,2) + size(VcondsPhaseII,2)+ size(AVcondsPhaseII,2)
    stims(i,:) = find(strcmp(codes,num2str(AVcondsPhaseII(i-size(AcondsPhaseII,2)-size(VcondsPhaseII,2)))));
    stimsp1(i,:) = stims(i,:)+1;
    hits{i} = find(strcmp(codes(stimsp1(i,:)),'1'));
end 

% %FINDING PHYSIOLOGICALLY IMPOSSIBLE HITS
%threshold = 100;
threshold = 0; %(WE DO NOT CALC SIGMOID FROM CORRECTED DATA ONLINE)
for i = size(AcondsPhaseII,2) + size(VcondsPhaseII,2)+1:size(AcondsPhaseII,2) + size(VcondsPhaseII,2)+ size(AVcondsPhaseII,2)
    hits_RT{i} = RTs(stimsp1(i,hits{i}));
    pastThreshold = find(hits_RT{i}<threshold);
    hits_RT{i}(pastThreshold) = [];
    hits{i}(pastThreshold) = [];
    %At this point, hits and hits_RT are aligned. Due to removing of
    %sub-threshold stimuli, other matrices will not match up with these
    %two. 
end 

%RTs
for i = size(AcondsPhaseII,2) + size(VcondsPhaseII,2)+1:size(AcondsPhaseII,2) + size(VcondsPhaseII,2)+ size(AVcondsPhaseII,2)
    if numel(hits_RT{i}) > 0
        mean_RTs{i} = mean(hits_RT{i});
        RTs_SD{i} = std(hits_RT{i});
    else 
        mean_RTs{i} = 0;
        RTs_SD{i} = 0;
    end
end
%% CALCULATING DETECTION
%CALCULATING DETECTION
numstims = size(stims,2);
numhits = cellfun(@numel, hits);
detection = numhits/numstims;

%%
%ORGANIZING OUTPUT
PHASEII.detection.a = detection(1:length(AcondsPhaseII));
PHASEII.detection.v = detection(length(AcondsPhaseII) + 1:length(AcondsPhaseII)+length(VcondsPhaseII));
PHASEII.detection.av = detection(size(AcondsPhaseII,2) + size(VcondsPhaseII,2)+1:size(AcondsPhaseII,2) + size(VcondsPhaseII,2)+ size(AVcondsPhaseII,2))
PHASEII.RT_mean.a = cell2mat(mean_RTs(1:length(AcondsPhaseII)));
PHASEII.RT_mean.v = cell2mat(mean_RTs(length(AcondsPhaseII) + 1:length(AcondsPhaseII)+length(VcondsPhaseII)));
PHASEII.RT_mean.av = cell2mat(mean_RTs(size(AcondsPhaseII,2) + size(VcondsPhaseII,2)+1:size(AcondsPhaseII,2) + size(VcondsPhaseII,2)+ size(AVcondsPhaseII,2)))
PHASEII.RT_SD.a = cell2mat(RTs_SD(1:length(AcondsPhaseII)));
PHASEII.RT_SD.v = cell2mat(RTs_SD(length(AcondsPhaseII) + 1:length(AcondsPhaseII)+length(VcondsPhaseII)));
PHASEII.RT_SD.av = cell2mat(RTs_SD(size(AcondsPhaseII,2) + size(VcondsPhaseII,2)+1:size(AcondsPhaseII,2) + size(VcondsPhaseII,2)+ size(AVcondsPhaseII,2)))
end 
