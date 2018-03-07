%% Auditory Stimuli
intensities = [1];

Hz = 1000;
refreshRate = 60; %in Hz
frames = 4;
Ttime = (1/refreshRate) * frames; %Duration of sound (seconds)
Fs = 44100;
timeVec = (1/Fs:1/Fs:Ttime);

%Generate ramp funcion
% rampper = 0.005; %Duration of ramp (in seconds)
% points = Fs*rampper;
% rampfcn = ones(1,length(timeVec));
% rampon = (1:1:points)/points;
% rampoff = fliplr(rampon);
% rampfcn(1:points) = rampfcn(1:points).*rampon;
% rampfcn(end-points+1:end) = rampfcn(end-points+1:end).*rampoff;
% rampfcn(end) = 0;
%plot(timeVec,rampfcn)
%End generate ramp

%Generation Loop
for i = 1:size(intensities,2)
    amp = intensities(i);
    filename = ['audNR_' num2str(intensities(i)*100) '.wav'];
    %%%%%%%%%%%
    wave = amp.*sin(2 * pi * timeVec * Hz);
    %plot(timeVec,wave1)
    %multiply sound by ramp
    %waveprod = wave .* rampfcn;
    waveprod = wave; 
    %plot(timeVec,waveprod)
    %test sound
    %sound(waveprod,Fs);
    %write sound
    audiowrite(filename,waveprod,Fs);
end 