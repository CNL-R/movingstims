basePath = 'C:\Users\achen52\Documents\GitHub\movingstims\';                    %Point to movingstims

%Experiment-wide Parameters
AintensitiesInitial = [0, 0.0083, 0.0167, 0.0250, 0.0333, 0.0417, 0.0500, 0.0583, 0.0667, 0.0750, 0.3000];
VintensitiesInitial = [0, 0.0250, 0.0375, 0.0500, 0.0625, 0.0750, 0.087, 0.1000, 0.1125, 0.1250, 0.3000];

%% 10108006
i = 1;

%Phase I
path = [basePath 'IEInitial\logs\'];
filename = '10108006-IEInitial.log';
[struct, ~] = importPresentationLog(strcat(path,filename));
DATA(i).participant = '10108006';
[DATA(i).titration temp_intensities] = mineParticipant_Titration(struct);

%Phase II
path = [basePath 'IETwo\logs\'];
filename = '10108006_1-IETwo.log';
[struct1, ~] = importPresentationLog(strcat(path,filename));
filename = '10108006_2-IETwo.log'
[struct2, ~] = importPresentationLog(strcat(path,filename));
struct = [struct1 struct2];
DATA(i).phaseII = mineParticipant_PhaseII(struct);
DATA(i).phaseII.intensities = temp_intensities;

%% 10108009
i = i + 1;

%Phase I
path = [basePath 'IEInitial\logs\'];
filename = '10108009-IEInitial.log';
[struct, ~] = importPresentationLog(strcat(path,filename));
DATA(i).participant = '10108009';
[DATA(i).titration temp_intensities] = mineParticipant_Titration(struct);

%Phase II
path = [basePath 'IETwo\logs\'];
filename = '10108009-IETwo.log';
[struct1, ~] = importPresentationLog(strcat(path,filename));
filename = '10108009_2-IETwo.log'
[struct2, ~] = importPresentationLog(strcat(path,filename));
struct = [struct1 struct2];
DATA(i).phaseII = mineParticipant_PhaseII(struct);
DATA(i).phaseII.intensities = temp_intensities;

%% 10108010
i = i + 1;

%Phase I
path = [basePath 'IEInitial\logs\'];
filename = '10108010-IEInitial.log';
[struct, ~] = importPresentationLog(strcat(path,filename));
DATA(i).participant = '10108010';
[DATA(i).titration temp_intensities] = mineParticipant_Titration(struct);

%Phase II
path = [basePath 'IETwo\logs\'];
filename = '10108010_1-IETwo.log';
[struct1, ~] = importPresentationLog(strcat(path,filename));
filename = '10108010_2-IETwo.log'
[struct2, ~] = importPresentationLog(strcat(path,filename));
struct = [struct1 struct2];
DATA(i).phaseII = mineParticipant_PhaseII(struct);
DATA(i).phaseII.intensities = temp_intensities;

%% 10108011
i = i + 1;

%Phase I
path = [basePath 'IEInitial\logs\'];
filename = '10108011-IEInitial.log';
[struct, ~] = importPresentationLog(strcat(path,filename));
DATA(i).participant = '10108011';
[DATA(i).titration temp_intensities] = mineParticipant_Titration(struct);

%Phase II
path = [basePath 'IETwo\logs\'];
filename = '10108011_1-IETwo.log';
[struct1, ~] = importPresentationLog(strcat(path,filename));
filename = '10108011_2-IETwo.log'
[struct2, ~] = importPresentationLog(strcat(path,filename));
struct = [struct1 struct2];
DATA(i).phaseII = mineParticipant_PhaseII(struct);
DATA(i).phaseII.intensities = temp_intensities;

%% 10108012
i = i + 1;

%Phase I
path = [basePath 'IEInitial\logs\'];
filename = '10108012-IEInitial.log';
[struct, ~] = importPresentationLog(strcat(path,filename));
DATA(i).participant = '10108012';
[DATA(i).titration temp_intensities] = mineParticipant_Titration(struct);

%Phase II
path = [basePath 'IETwo\logs\'];
filename = '10108012_1-IETwo.log';
[struct1, ~] = importPresentationLog(strcat(path,filename));
filename = '10108012_2-IETwo.log'
[struct2, ~] = importPresentationLog(strcat(path,filename));
struct = [struct1 struct2];
DATA(i).phaseII = mineParticipant_PhaseII(struct);
DATA(i).phaseII.intensities = temp_intensities;

%% 10108013
i = i + 1;

%Phase I
path = [basePath 'IEInitial\logs\'];
filename = '10108013-IEInitial.log';
[struct, ~] = importPresentationLog(strcat(path,filename));
DATA(i).participant = '10108013';
[DATA(i).titration temp_intensities] = mineParticipant_Titration(struct);

%Phase II
path = [basePath 'IETwo\logs\'];
filename = '10108013_1-IETwo.log';
[struct1, ~] = importPresentationLog(strcat(path,filename));
filename = '10108013_2-IETwo.log'
[struct2, ~] = importPresentationLog(strcat(path,filename));
struct = [struct1 struct2];
DATA(i).phaseII = mineParticipant_PhaseII(struct);
DATA(i).phaseII.intensities = temp_intensities;

%% 10108014 - Ignore, basically fell asleep. 
% i = i + 1;
% 
% Phase I
% path = [basePath 'IEInitial\logs\'];
% filename = '10108014-IEInitial.log';
% [struct, ~] = importPresentationLog(strcat(path,filename));
% DATA(i).participant = '10108014';
% [DATA(i).titration temp_intensities] = mineParticipant_Titration(struct);
% 
% Phase II
% path = [basePath 'IETwo\logs\'];
% filename = '10108014_1-IETwo.log';
% [struct1, ~] = importPresentationLog(strcat(path,filename));
% filename = '10108014_2-IETwo.log'
% [struct2, ~] = importPresentationLog(strcat(path,filename));
% filename = '10108014_3-IETwo.log'
% [struct3, ~] = importPresentationLog(strcat(path,filename));
% struct = [struct1 struct2 struct3];
% DATA(i).phaseII = mineParticipant_PhaseII(struct);
% DATA(i).phaseII.intensities = temp_intensities;

%% 10108015
i = i + 1;

%Phase I
path = [basePath 'IEInitial\logs\'];
filename = '10108015-IEInitial.log';
[struct, ~] = importPresentationLog(strcat(path,filename));
DATA(i).participant = '10108015';
[DATA(i).titration temp_intensities] = mineParticipant_Titration(struct);

%Phase II
path = [basePath 'IETwo\logs\'];
filename = '10108015_1-IETwo.log';
[struct1, ~] = importPresentationLog(strcat(path,filename));
filename = '10108015_2-IETwo.log'
[struct2, ~] = importPresentationLog(strcat(path,filename));
struct = [struct1 struct2];
DATA(i).phaseII = mineParticipant_PhaseII(struct);
DATA(i).phaseII.intensities = temp_intensities;

%% 10108016
i = i + 1;

DATA(i).participant = '10108016';
%Phase I
path = [basePath 'IEInitial\logs\'];
filename = [DATA(i).participant '-IEInitial.log'];
[struct, ~] = importPresentationLog(strcat(path,filename));

[DATA(i).titration temp_intensities] = mineParticipant_Titration(struct);

%Phase II
path = [basePath 'IETwo\logs\'];
filename = [DATA(i).participant '_1-IETwo.log'];
[struct1, ~] = importPresentationLog(strcat(path,filename));
filename = [DATA(i).participant '_2-IETwo.log'];
[struct2, ~] = importPresentationLog(strcat(path,filename));
struct = [struct1 struct2];
DATA(i).phaseII = mineParticipant_PhaseII(struct);
DATA(i).phaseII.intensities = temp_intensities;

%% 10108017
i = i + 1;

DATA(i).participant = '10108017';
%Phase I
path = [basePath 'IEInitial\logs\'];
filename = [DATA(i).participant '-IEInitial.log'];
[struct, ~] = importPresentationLog(strcat(path,filename));

[DATA(i).titration temp_intensities] = mineParticipant_Titration(struct);

%Phase II
path = [basePath 'IETwo\logs\'];
filename = [DATA(i).participant '_1-IETwo.log'];
[struct1, ~] = importPresentationLog(strcat(path,filename));
filename = [DATA(i).participant '_2-IETwo.log'];
[struct2, ~] = importPresentationLog(strcat(path,filename));
struct = [struct1 struct2];
DATA(i).phaseII = mineParticipant_PhaseII(struct);
DATA(i).phaseII.intensities = temp_intensities;

%% 10108018
i = i + 1;

DATA(i).participant = '10108018';
%Phase I
path = [basePath 'IEInitial\logs\'];
filename = [DATA(i).participant '-IEInitial.log'];
[struct, ~] = importPresentationLog(strcat(path,filename));

[DATA(i).titration temp_intensities] = mineParticipant_Titration(struct);

%Phase II
path = [basePath 'IETwo\logs\'];
filename = [DATA(i).participant '_1-IETwo.log'];
[struct1, ~] = importPresentationLog(strcat(path,filename));
filename = [DATA(i).participant '_2-IETwo.log'];
[struct2, ~] = importPresentationLog(strcat(path,filename));
struct = [struct1 struct2];
DATA(i).phaseII = mineParticipant_PhaseII(struct);
DATA(i).phaseII.intensities = temp_intensities;

%% 10108019
i = i + 1;

DATA(i).participant = '10108019';
%Phase I
path = [basePath 'IEInitial\logs\'];
filename = [DATA(i).participant '-IEInitial.log'];
[struct, ~] = importPresentationLog(strcat(path,filename));

[DATA(i).titration temp_intensities] = mineParticipant_Titration_10108019(struct);

%Phase II
path = [basePath 'IETwo\logs\'];
filename = [DATA(i).participant '_1-IETwo.log'];
[struct1, ~] = importPresentationLog(strcat(path,filename));
filename = [DATA(i).participant '_2-IETwo.log'];
[struct2, ~] = importPresentationLog(strcat(path,filename));
struct = [struct1 struct2];
DATA(i).phaseII = mineParticipant_PhaseII(struct);
DATA(i).phaseII.intensities = temp_intensities;

%% 10108020
i = i + 1;

DATA(i).participant = '10108020';
%Phase I
path = [basePath 'IEInitial\logs\'];
filename = [DATA(i).participant '-IEInitial.log'];
[struct, ~] = importPresentationLog(strcat(path,filename));

[DATA(i).titration temp_intensities] = mineParticipant_Titration(struct);

%Phase II
path = [basePath 'IETwo\logs\'];
filename = [DATA(i).participant '_1-IETwo.log'];
[struct1, ~] = importPresentationLog(strcat(path,filename));
filename = [DATA(i).participant '_2-IETwo.log'];
[struct2, ~] = importPresentationLog(strcat(path,filename));
struct = [struct1 struct2];
DATA(i).phaseII = mineParticipant_PhaseII(struct);
DATA(i).phaseII.intensities = temp_intensities;

%% 10108021
i = i + 1;

DATA(i).participant = '10108021';
%Phase I
path = [basePath 'IEInitial\logs\'];
filename = [DATA(i).participant '-IEInitial.log'];
[struct, ~] = importPresentationLog(strcat(path,filename));

[DATA(i).titration temp_intensities] = mineParticipant_Titration(struct);

%Phase II
path = [basePath 'IETwo\logs\'];
filename = [DATA(i).participant '_1-IETwo.log'];
[struct1, ~] = importPresentationLog(strcat(path,filename));
filename = [DATA(i).participant '_2-IETwo.log'];
[struct2, ~] = importPresentationLog(strcat(path,filename));
struct = [struct1 struct2];
DATA(i).phaseII = mineParticipant_PhaseII(struct);
DATA(i).phaseII.intensities = temp_intensities;

%% 10108022
i = i + 1;

DATA(i).participant = '10108022';
%Phase I
path = [basePath 'IEInitial\logs\'];
filename = [DATA(i).participant '-IEInitial.log'];
[struct, ~] = importPresentationLog(strcat(path,filename));

[DATA(i).titration temp_intensities] = mineParticipant_Titration(struct);

%Phase II
path = [basePath 'IETwo\logs\'];
filename = [DATA(i).participant '_1-IETwo.log'];
[struct1, ~] = importPresentationLog(strcat(path,filename));
filename = [DATA(i).participant '_2-IETwo.log'];
[struct2, ~] = importPresentationLog(strcat(path,filename));
struct = [struct1 struct2];
DATA(i).phaseII = mineParticipant_PhaseII(struct);
DATA(i).phaseII.intensities = temp_intensities;

%% 10108023
i = i + 1;

DATA(i).participant = '10108023';
%Phase I
path = [basePath 'IEInitial\logs\'];
filename = [DATA(i).participant '-IEInitial.log'];
[struct, ~] = importPresentationLog(strcat(path,filename));

[DATA(i).titration temp_intensities] = mineParticipant_Titration(struct);

%Phase II
path = [basePath 'IETwo\logs\'];
filename = [DATA(i).participant '_1-IETwo.log'];
[struct1, ~] = importPresentationLog(strcat(path,filename));
filename = [DATA(i).participant '_2-IETwo.log'];
[struct2, ~] = importPresentationLog(strcat(path,filename));
struct = [struct1 struct2];
DATA(i).phaseII = mineParticipant_PhaseII(struct);
DATA(i).phaseII.intensities = temp_intensities;

%% 10108024
i = i + 1;

DATA(i).participant = '10108024';
%Phase I
path = [basePath 'IEInitial\logs\'];
filename = [DATA(i).participant '-IEInitial.log'];
[struct, ~] = importPresentationLog(strcat(path,filename));

[DATA(i).titration temp_intensities] = mineParticipant_Titration(struct);

%Phase II
path = [basePath 'IETwo\logs\'];
filename = [DATA(i).participant '_1-IETwo.log'];
[struct1, ~] = importPresentationLog(strcat(path,filename));
filename = [DATA(i).participant '_2-IETwo.log'];
[struct2, ~] = importPresentationLog(strcat(path,filename));
struct = [struct1 struct2];
DATA(i).phaseII = mineParticipant_PhaseII(struct);
DATA(i).phaseII.intensities = temp_intensities;

%% 10108025
i = i + 1;

DATA(i).participant = '10108025';
%Phase I
path = [basePath 'IEInitial\logs\'];
filename = [DATA(i).participant '-IEInitial.log'];
[struct, ~] = importPresentationLog(strcat(path,filename));

[DATA(i).titration temp_intensities] = mineParticipant_Titration(struct);

%Phase II
path = [basePath 'IETwo\logs\'];
filename = [DATA(i).participant '_1-IETwo.log'];
[struct1, ~] = importPresentationLog(strcat(path,filename));
filename = [DATA(i).participant '_2-IETwo.log'];
[struct2, ~] = importPresentationLog(strcat(path,filename));
struct = [struct1 struct2];
DATA(i).phaseII = mineParticipant_PhaseII(struct);
DATA(i).phaseII.intensities = temp_intensities;
%% SAVING DATA
path = 'C:\Users\achen52\Documents\GitHub\SMART-IE-Data'
filename = 'DATA.mat';
save(fullfile(path,filename), 'DATA')