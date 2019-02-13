function [TITRATION, PHASEII_INTENSITIES] = mineParticipant_Titration(struct)
%Takes struct from importPresentationLog as input

%assume port codes and intensities are identical for all participants in
%titration phase. 
AcondsInitial = [11:21];
AintensitiesInitial = [0, 0.0083, 0.0167, 0.0250, 0.0333, 0.0417, 0.0500, 0.0583, 0.0667, 0.0750, 0.3000];
VcondsInitial = [101:111];
VintensitiesInitial = [0, 0.0250, 0.0375, 0.0500, 0.0625, 0.0750, 0.087, 0.1000, 0.1125, 0.1250, 0.3000];

%Isolating codes and RTs cells
codes = {struct.code};
RTs = {struct.ttime};
removeIndices = cellfun('isempty', codes);
codes(removeIndices) = [];
RTs(removeIndices) = [];
codes{1,end+1} = '0';                         %Solve indexing error with stimsp1 increasing above max size of array
RTs{1,end+1} = 0;
RTs = cell2mat(RTs)./10;
%% AUDITORY: FINDING HITS & RTs

%FINDING HITS
for i = 1:size(AcondsInitial,2)
    stims(i,:) = find(strcmp(codes,num2str(AcondsInitial(i))));
    stimsp1(i,:) = stims(i,:)+1;
    hits{i} = find(strcmp(codes(stimsp1(i,:)),'1'));
end 

% FINDING PHYSIOLOGICALLY IMPOSSIBLE HITS 
%threshold = 100;
threshold = 0; %(WE DO NOT CALC SIGMOID FROM CORRECTED DATA ONLINE)
for i = 1:size(AcondsInitial,2)
    hits_RT{i} = RTs(stimsp1(i,hits{i}));
    pastThreshold = find(hits_RT{i}<threshold);
    hits_RT{i}(pastThreshold) = [];
    hits{i}(pastThreshold) = [];
    %At this point, hits and hits_RT are aligned. Due to removing of
    %sub-threshold stimuli, other matrices will not match up with these
    %two. 
end 

%RTs
for i = 1:size(AcondsInitial,2)
    if numel(hits_RT{i}) > 0
        mean_RTs{i} = mean(hits_RT{i});
        RTs_SD{i} = std(hits_RT{i});
    else 
        mean_RTs{i} = 0;
        RTs_SD{i} = 0;
    end
end 

%% VISUAL: FINDING HITS & RTs

for i = size(AcondsInitial,2)+1:size(AcondsInitial,2) + size(VcondsInitial,2)
    stims(i,:) = find(strcmp(codes,num2str(VcondsInitial(i-size(VcondsInitial,2)))));
    stimsp1(i,:) = stims(i,:)+1;
    hits{i} = find(strcmp(codes(stimsp1(i,:)),'1'));
end 

% %FINDING PHYSIOLOGICALLY IMPOSSIBLE HITS
%threshold = 100;
threshold = 0; %(WE DO NOT CALC SIGMOID FROM CORRECTED DATA ONLINE)
for i = size(AcondsInitial,2)+1:size(AcondsInitial,2)+size(VcondsInitial,2)
    hits_RT{i} = RTs(stimsp1(i,hits{i}));
    pastThreshold = find(hits_RT{i}<threshold);
    hits_RT{i}(pastThreshold) = [];
    hits{i}(pastThreshold) = [];
    %At this point, hits and hits_RT are aligned. Due to removing of
    %sub-threshold stimuli, other matrices will not match up with these
    %two. 
end 

%RTs
for i = size(AcondsInitial,2)+1:size(AcondsInitial,2)+size(VcondsInitial,2)
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

%% SIGMOID FIT
[param_aud, TITRATION.fit.a] = sigm_fit(AintensitiesInitial, detection(1:length(AcondsInitial)), [], [], 1);
[param_vis, TITRATION.fit.v] = sigm_fit(VintensitiesInitial, detection(length(AcondsInitial) + 1:length(AcondsInitial)+length(VcondsInitial)), [], [], 1);

%% GENERATING PHASEII INTENSITIES
timeunit = 0.000001;
x = 0:timeunit:1;
audSigmoid = sigm_fit_val(param_aud, x);
visSigmoid = sigm_fit_val(param_vis, x);

detectabilities = [.10,.20,.30,.40,.50,.60,.70,.80,.90];
PHASEII_INTENSITIES.a = [];
PHASEII_INTENSITIES.v = [];
for i = 1:9
tempAgreater = find(audSigmoid >= detectabilities(i));
PHASEII_INTENSITIES.a = [PHASEII_INTENSITIES.a tempAgreater(1) * timeunit];

tempVgreater = find(visSigmoid >= detectabilities(i));
PHASEII_INTENSITIES.v = [PHASEII_INTENSITIES.v tempVgreater(1) * timeunit];
end 
%% ORGANIZING OUTPUT
TITRATION.detection.a = detection(1:length(AcondsInitial));
TITRATION.detection.v = detection(length(AcondsInitial) + 1:length(AcondsInitial)+length(VcondsInitial));
TITRATION.RT_mean.a = cell2mat(mean_RTs(1:length(AcondsInitial)));
TITRATION.RT_mean.v = cell2mat(mean_RTs(length(AcondsInitial) + 1:length(AcondsInitial)+length(VcondsInitial)));
TITRATION.RT_SD.a = cell2mat(RTs_SD(1:length(AcondsInitial)));
TITRATON.RT_SD.v = cell2mat(RTs_SD(length(AcondsInitial) + 1:length(AcondsInitial)+length(VcondsInitial)));
TITRATION.intensities.a = AintensitiesInitial;
TITRATION.intensities.v = VintensitiesInitial;
end 
