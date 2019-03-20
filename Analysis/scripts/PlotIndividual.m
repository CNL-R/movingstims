individual = '10108024';
i = find(strcmp({DATA.participant},individual));

%% initial
x = DATA(i).titration.intensities;
y = DATA(i).titration.detection;
param = DATA(i).titration.fit;
t = 0:0.001:0.3;
figure;
subplot(1,2,1);
hold on;
plot(x.a, y.a, '-o');
title('Auditory Psychometric Curve');
psychometricFunc_a = sigm_fit_val(param.a.param, t);
plot(t, psychometricFunc_a);

subplot(1,2,2);
plot(x.v, y.v, '-o');
title('Visual Psychometric Curve');
hold on;
psychometricFunc_v = sigm_fit_val(param.v.param, t);
plot(t, psychometricFunc_v);

%% phase II
x = [0:0.1:1];
y = DATA(i).phaseII.detection;
figure;
hold on;
plot(x,y.a);
plot(x,y.v);
plot(x,y.av);
plot(x,y.a+y.v-y.a.*y.v);
legend({'Auditory','Visual','Audiovisual','P(A)+P(V)-P(A)P(V)'})
title(individual)