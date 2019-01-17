plotmode = 2; %1: STD Shadow 2: SEM Shadow 3:STD Error Bars 4:SEM Error Bars
numbersubjects = 13;
alldetections = zeros(numbersubjects,3,11);
allmodels = zeros(numbersubjects,11);

%Participant 1 (10108007)
Plot_IETwo_Model_10108007
alldetections(1,:,:) = detection;
allmodels(1,:) = model;

%Participant 2 (10108008)
Plot_IETwo_Model_10108008
alldetections(2,:,:) = detection;
allmodels(2,:) = model;

%Participants 3-4 (10108006, 10108004)
path = 'C:\Users\Allenine\Documents\GitHub\movingstims\IETwo\logs\';
filenames = {'10108006_2-IETwo.log','10108004_2-IETwo.log'};
for i=3:4
    [alldetections(i,:,:), allmodels(i,:)] = CalculateModel(path, filenames{i-2});
end 

%Participant 5 (10108009)
Plot_IETwo_Model_10108009
alldetections(5,:,:) = detection;
allmodels(5,:) = model;

%Participant 6 (10108010)
Plot_IETwo_Model_10108010
alldetections(6,:,:) = detection;
allmodels(6,:) = model;

%Participant 7
Plot_IETwo_Model_10108011
alldetections(7,:,:) = detection;
allmodels(7,:) = model;

%Participant 8
Plot_IETwo_Model_10108012
alldetections(8,:,:) = detection;
allmodels(8,:) = model;

%Participant 9
Plot_IETwo_Model_10108013
alldetections(9,:,:) = detection;
allmodels(9,:) = model;

%Participant 10
Plot_IETwo_Model_10108014
alldetections(10,:,:) = detection;
allmodels(10,:) = model;

%Participant 11
Plot_IETwo_Model_10108015
alldetections(11,:,:) = detection;
allmodels(11,:) = model;

%Participant 12
Plot_IETwo_Model_10108016
alldetections(12,:,:) = detection;
allmodels(12,:) = model;

%Participant 13
Plot_IETwo_Model_10108017
alldetections(13,:,:) = detection;
allmodels(13,:) = model;
%% 
close('all')

%Average
colors = {[31,120,180],[166,206,227];
          [227,26,28], [251,154,153];
          [255,127,0], [253,191,111];
          [84,39,136], [128,115,172]};
figure;
plot_variance = @(x,lower,upper,color) set(fill([x,x(end:-1:1)],[upper,lower(end:-1:1)],color),'EdgeColor','none', 'FaceAlpha', 0.25, 'HandleVisibility', 'off');

if plotmode == 1
    for i = 1:3 %STD
        hold on;
        plot(AVintensities, mean(squeeze(alldetections(:,i,:)),1), 'Marker', 'o', 'Color', colors{i,1}./255);
        plot_variance(AVintensities,mean(squeeze(alldetections(:,i,:)))-std(squeeze(alldetections(:,i,:))),mean(squeeze(alldetections(:,i,:)))+std(squeeze(alldetections(:,i,:))),colors{i,2}./255);
    end
    plot(AVintensities, mean(allmodels(:,:),1), 'Marker', 'o', 'Color', colors{4,1}./255);
    plot_variance(AVintensities,mean(allmodels(:,:),1) - std(allmodels(:,:),1),mean(allmodels(:,:),1) + std(allmodels(:,:),1),colors{4,2}./255);
    legend('Auditory', 'Visual', 'Audiovisual', 'Location', 'southeast', 'P(A)+P(V) - P(A)P(V)');
    xlabel('Intended Detectability');
    ylabel('Hit Probability');
    set(gca,'ylim',[0 1]);
elseif plotmode == 2
    for i = 1:3 %SEM
        hold on;
        plot(AVintensities, mean(squeeze(alldetections(:,i,:)),1), 'Marker', 'o', 'Color', colors{i,1}./255);
        plot_variance(AVintensities,mean(squeeze(alldetections(:,i,:)))-(std(squeeze(alldetections(:,i,:)))/sqrt(numbersubjects)),mean(squeeze(alldetections(:,i,:)))+(std(squeeze(alldetections(:,i,:)))/sqrt(numbersubjects)),colors{i,2}./255);
    end
    plot(AVintensities, mean(allmodels(:,:),1), 'Marker', 'o', 'Color', colors{4,1}./255);
    plot_variance(AVintensities,mean(allmodels(:,:),1) - (std(allmodels(:,:),1)/sqrt(numbersubjects)),mean(allmodels(:,:),1) + (std(allmodels(:,:),1)/sqrt(numbersubjects)),colors{4,2}./255);
    legend('Auditory', 'Visual', 'Audiovisual', 'Location', 'southeast', 'P(A)+P(V) - P(A)P(V)');
    xlabel('Intended Detectability');
    ylabel('Hit Probability');
    set(gca,'ylim',[0 1]);
elseif plotmode == 3
    capsize = 15;
    for i = 1:3 %STD
        hold on;
        errorbar(AVintensities, mean(squeeze(alldetections(:,i,:)),1), std(squeeze(alldetections(:,i,:))), 'Marker', 'o', 'Color', colors{i,1}./255, 'CapSize', capsize);
    end
    errorbar(AVintensities, mean(allmodels(:,:),1),std(squeeze(alldetections(:,i,:))), 'Marker', 'o', 'Color', colors{4,1}./255, 'CapSize', capsize);
    legend('Auditory', 'Visual', 'Audiovisual', 'Location', 'southeast', 'P(A)+P(V) - P(A)P(V)');
    xlabel('Intended Detectability');
    ylabel('Hit Probability');
    set(gca,'ylim',[0 1]);
elseif plotmode == 4
    capsize = 15;
    for i = 1:3 %SEM
        hold on;
        errorbar(AVintensities, mean(squeeze(alldetections(:,i,:)),1), std(squeeze(alldetections(:,i,:)))/sqrt(numbersubjects), 'Marker', 'o', 'Color', colors{i,1}./255, 'CapSize', capsize);
    end
    errorbar(AVintensities, mean(allmodels(:,:),1),std(squeeze(alldetections(:,i,:)))/sqrt(numbersubjects), 'Marker', 'o', 'Color', colors{4,1}./255, 'CapSize', capsize);
    legend('Auditory', 'Visual', 'Audiovisual', 'Location', 'southeast', 'P(A)+P(V) - P(A)P(V)');
    xlabel('Intended Detectability');
    ylabel('Hit Probability');
    set(gca,'ylim',[0 1]);
end

title('')