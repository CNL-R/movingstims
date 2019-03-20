%% Best Performers
bestParticipants = {'10108006', '10108010','10108012','10108019','10108025'};
participants = {DATA.participant};
indcs_keep = zeros(1, length(bestParticipants));
for i = 1:length(bestParticipants)
    templogicalarray = strcmp(participants, bestParticipants{i});
    indcs_keep(i) = find(templogicalarray == 1);
end
DATA_best = DATA(indcs_keep);

%% Rest Performers
%run best first
%of the 12 individuals, which ones were not of the 4 best
bestParticipants = {'10108006', '10108010','10108012','10108019','10108025'};
participants = {DATA_filtered.participant};
indcs_remove = zeros(1, length(bestParticipants));
for i = 1:length(bestParticipants)
    templogicalarray = strcmp(participants, bestParticipants{i});
    indcs_remove(i) = find(templogicalarray == 1);
end
DATA_rest = DATA_filtered;
DATA_rest(indcs_remove) = [];