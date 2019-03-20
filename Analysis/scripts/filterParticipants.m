% Filters participants

%% Identifying Participants to Remove
%Total Hit Rate < 20% || >70%
numParticipants = length(DATA);
participant = cell(1,numParticipants);
hitrate = zeros(1,numParticipants);
for i = 1:numParticipants
    participant{i} = DATA(i).participant;
    hitrate(i) = mean(DATA(i).phaseII.detection.v)
end 
threshold_low = .2;
threshold_high = 0.7;
removeindcs = find(hitrate<threshold_low | hitrate>threshold_high);
toremove = {participant{removeindcs}}

%% Removing Them
DATA_filtered = DATA;
DATA_filtered(removeindcs) = [];

%% Cohorting Removed Individuals
DATA_removed = DATA(removeindcs);
