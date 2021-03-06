%% Auditory Stimuli
Amin = 0;                                                                %The range of stimuli that you want generated
Amax = 0.075;                                                               
Asupra = 0.3;

%intensities = GenerateParameters(min, max);                                %Generates stims in the range of 0 --> min --> ... --> max --> 0.3
Aintensities = [linspace(Amin,Amax,10) Asupra];

Hz = 1000;
refreshRate = 60; %in Hz
frames = 6; %length of stimuli in frames
Ttime = (1/refreshRate) * frames; %Duration of sound (seconds)
Fs = 44100;
timeVec = (1/Fs:1/Fs:Ttime);

%Generate ramp funcion
rampper = 0.005; %Duration of ramp (in seconds)
points = Fs*rampper;
rampfcn = ones(1,length(timeVec));
rampon = (1:1:points)/points;
rampoff = fliplr(rampon);
rampfcn(1:points) = rampfcn(1:points).*rampon;
rampfcn(end-points+1:end) = rampfcn(end-points+1:end).*rampoff;
rampfcn(end) = 0;
%plot(timeVec,rampfcn)
%End generate ramp

%Generation Loop
for i = 1:size(Aintensities,2)
    amp = Aintensities(i);
    filename = ['aud_' num2str(i) '.wav'];
    %%%%%%%%%%%
    wave = amp.*sin(2 * pi * timeVec * Hz);
    %plot(timeVec,wave1)
    %multiply sound by ramp
    waveprod = wave .* rampfcn;
    %plot(timeVec,waveprod)
    %test sound
    %sound(waveprod,Fs);
    %write sound
    audiowrite(filename,waveprod,Fs);
end 

%% Visual Stimuli
Vmin = .025;
Vmax = 0.125;
Vsupra = 0.3;

Vintensities = [0 linspace(Vmin,Vmax,9) Vsupra];


desired_frames = 50;

basedir = 'C:\Users\achen52\Documents\GitHub\movingstims\IEInitial\stims';
for m = 1:size(Vintensities, 2)
    foldername = ['vis_' num2str(m)];
    status = mkdir(basedir, foldername);
    status
    folderdir = [basedir '\' foldername]
    for n = 1:desired_frames
        %size of complete stimulus output (in pixels)
        sizex = 1024;
        sizey = 1024;
     
        centerx = sizex/2;
        centery = sizey/2;
        
        %stimulus coherence
        fudge = Vintensities(m);
        
        %generate some component arrays
        gaussring = zeros(sizex,sizey);
        bkgnd = repmat(0.5,sizex,sizey);
        %bkgnd = repmat(0.1,sizex,sizey);
        noise = rand(sizex,sizey);
        
        %Check noise generation
        %%%%%%%%%%%%%%%%%%%%%%%
        %imshow(noise)
        %%%%%%%%%%%%%%%%%%%%%%%
        copy = noise;
        
        %guassian ring function
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        sigma = 25; %sigma of gaussian (in pixels)
        mu = 325; %pixels from center of image where gaussian ring will reach peak
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                %guassian ring function

        
        a = 1/(sigma*sqrt(2*pi));
        for i = 1:sizex %This loop checks the distance of every pixel from the center of the image
            for j = 1:sizey %and then sets the value of the pixel to be equal to the value of the 1D gaussian fxn
                d = sqrt((i-centerx)^2 + (j-centery)^2); %with mean centered at mu pixels and a deviation of sigma
                gaussring(i,j) = gaussmf(d,[sigma mu]);
            end
        end
        
        %Check annulus generation
        %%%%%%%%%%%%%%%%%%%%%%%
        %imshow(gaussring)
        %%%%%%%%%%%%%%%%%%%%%%%
        
        %Create sinewave grating
        Amplitude = 1;
        Gabor_Diameter = 1024;
        X0 = 1:Gabor_Diameter;
        X0 = (X0 / Gabor_Diameter) - .5;
        [Xm, Ym] = meshgrid(X0, X0);
        Lambda = 60;
        theta = 90;
        Xt = Xm * cos(theta);
        Yt = Ym * sin(theta);
        orientation = Xt + Yt;
        phase = 180;
        
        grating = (1+Amplitude .* sin(orientation * Gabor_Diameter/Lambda * 2 * pi + phase))/2;
        %Check grating generation
        %%%%%%%%%%%%%%%%%%%%%%%
        %imshow(grating)
        %%%%%%%%%%%%%%%%%%%%%%%
        
        figure;
        bkg = imshow(noise); hold on;
        %bkg = imshow(bkgnd); hold on;
        bkg.CDataMapping = 'scaled';
        colormap(gray);
        
        % nze = imshow(noise);
        % nze.CDataMapping = 'scaled';
        % nze.AlphaData = gaussring;
        %
        im = imshow(grating);
        im.CDataMapping = 'scaled';
        im.AlphaData = gaussring.*fudge;
        
        final = getframe(gca);
        imageout = final.cdata;
        imageout(:,1,:) = [];
        imageout(end,:,:) = [];
        %axis('square'); box off; axis off;
        %print(strcat('annulus_',num2str(n-1)), '-dbmp');
        imwrite(imageout,strcat(folderdir,'\annulus_',num2str(n-1),'.bmp'),'bmp')
        close
        clear final
    end
end

% %% Visual Noise
% basedir = 'C:\Users\lhshaw\Desktop\movingstims\IESweep\stims\vis_noise';
% numnoises = 200;
% %size of complete stimulus output (in pixels)
% % sizex = 1024;
% % sizey = 1024;
% sizex = 683;
% sizey = 683;
% for m = 1:numnoises
%     noise = rand(sizex,sizey);
%     imwrite(noise,strcat(basedir,'\annulus_',num2str(m-1),'.bmp'),'bmp')
%     close
%     clear final
% end