
%load C:\Users\achen52\Documents\GitHub\SMART-IE-data\DATA.mat
%data = DATA;
%subplotdims = [6 3];

%data = DATA_filtered;
%subplotdims = [4 3];

% data = DATA_best;
% subplotdims = [5 1];

% data = DATA_rest;
% subplotdims = [3 3];

data = DATA_removed;
subplotdims = [5 1];

numParticipants = size(data,2);
%% initial
figure;
for i = 1:numParticipants
x = data(i).titration.intensities;
y = data(i).titration.detection;
param = data(i).titration.fit;
t = 0:0.001:0.3;
subplot(subplotdims(1),subplotdims(2),i);
hold on;
plot(x.a, y.a, '-o', 'Color','blue');
psychometricFunc_a = sigm_fit_val(param.a.param, t);
plot(t, psychometricFunc_a, 'Color','black');
hold on;
plot(x.v, y.v, '-o', 'Color','red');
title(data(i).participant);
hold on;
psychometricFunc_v = sigm_fit_val(param.v.param, t);
plot(t, psychometricFunc_v, 'Color','black'); 
legend({'Auditory Raw', 'Fit', 'Visual Raw'},'Location','southeast')
end 
set(gcf,'position',[0 0 1920 1080])

%% phaseII
figure;
for i = 1:numParticipants
x = [0:0.1:1];
y = data(i).phaseII.detection;
subplot(subplotdims(1),subplotdims(2),i);
hold on;
plot(x,y.a);
plot(x,y.v);
plot(x,y.av);
plot(x,y.a+y.v-y.a.*y.v);
title(data(i).participant);
if i == numParticipants
legend({'Auditory','Visual','Audiovisual','P(A)+P(V)-P(A)P(V)'}, 'Location', 'southeast')
end 
end 
set(gcf,'position',[0 0 1920 1080])

%% 
%SAVING as -dsvg
filename = 'RemovedIndividuals';
path = 'C:\Users\achen52\Documents\GitHub\SMART-IE-Data';
print(fullfile(path,filename), '-dsvg')