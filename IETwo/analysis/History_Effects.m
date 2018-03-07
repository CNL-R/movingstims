% Run this after section I of plot_IETwo.m 
%% Pulling Out Individual History Effects

%MINING FOR HISTORY EFFECTS
conds = [Aconds Vconds AVconds];

toclear = {'indcsplus1','numberhits','numberstims','stimIndcs'};           %Clearing up Workspace
clear(toclear{:}) 

responseIndcs = find(block == 1);
stimindcs = find(block>1 & block < 40);
nstimindcs = stimindcs;
nstimindcs(1) = [];
stims = block(nstimindcs);
stimindcsplus1 = nstimindcs+1;
stimsplus1 = block(stimindcsplus1); 
n = [stims; stimsplus1];

nm1stimindcs = stimindcs(:);
nm1stims = block(nm1stimindcs);
nm1indcsplus1 = nm1stimindcs + 1;
nm1stimsplus1 = block(nm1indcsplus1);
nm1 = [nm1stims; nm1stimsplus1];
nm1(:,end) = [];

for i=1:numel(conds)
    for j=1:numel(conds)
        numberhits(i,j) = numel(find(n(1,:)==conds(j) & n(2,:)==1 & nm1(1,:)==conds(i)));
        numberstims(i,j) = numel(find(n(1,:)==conds(j) & nm1(1,:)==conds(i)));
    end
end 
detection = numberhits ./ numberstims;

