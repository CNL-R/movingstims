% Run this after section I of plot_IETwo.m 
%% Pulling Out Individual History Effects

%MINING FOR HISTORY EFFECTS
conds = [Aconds Vconds AVconds];

toclear = {'indcsplus1','numberhits','numberstims','stimIndcs'};           %Clearing up Workspace
clear(toclear{:}) 

block = [block 0]; %adding a throwaway 0 at the end so code does not crash from exceeding matrix dimensions
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
nm1detection = numberhits ./ numberstims;
%% 
participantcounter = 1;
% %% Save
% columns = {'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Z','AA','AB','AC'};
% columncounter = 1;
% xlsfilename = 'C:\Users\achen52\Documents\GitHub\movingstims\IETwo\analysis\GroupBehavior.xlsx';
% xlswrite(xlsfilename, cond.subject(1), 'Group', 'A2');
% for i = 1:3
%     for j = 1:3 %j = row number
%            columncounter = columncounter + 1;
%            xlswrite(xlsfilename, detection(j,1:3), 'Group', strcat(columns{columncounter}, num2str(participantcounter + 1),':',columns{columncounter + 3},num2str(participantcounter + 1)));
%     end
% end

