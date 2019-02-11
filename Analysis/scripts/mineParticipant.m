input = struct;
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
RTs{1,end+1} = '0';

%% Auditory
%DETECTION
for i = 1:size(AcondsInitial,2)
    stims(i,:) = find(strcmp(codes,num2str(AcondsInitial(i))));
    stimsp1(i,:) = stims(i,:)+1;
    hits{i} = find(strcmp(codes(stimsp1(i,:)),'1'));
end 
numstims = size(stims,2);
numhits = cellfun(@numel, hits);
detection = numhits/numstims;

%RTs
for i = 1:size(AcondsInitial,2)
    if numel(RTs(stimsp1(i,hits{:,i}))) > 0
        mean_RTs{i} = mean(cell2mat(RTs(stimsp1(i,hits{:,i}))));
        RTs_SD{i} = std(cell2mat(RTs(stimsp1(i,hits{:,i}))));
    else 
        mean_RTs{i} = 0;
        RTs_SD{i} = 0;
    end
end 