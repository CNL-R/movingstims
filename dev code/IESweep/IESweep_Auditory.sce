#header
default_background_color = 128, 128, 128;
write_codes = true;
pulse_width = 5;
active_buttons = 2;
button_codes = 1, 255;
no_logfile = false;
###############################################################################
#SDL portion of code
begin;

# in SDL

text { caption = "+"; font_size = 16; font_color = 0,0,0; transparent_color = 128,128,128;
} fixcross;

picture { bitmap { filename = ""; preload = false;}; x = 0; y = 0; text fixcross; x = 0; y = 0; } pic; 

#picture { bitmap { filename = "annulus_1.bmp"; }; x = 0; y = 0;} default;
picture {text fixcross; x = 0; y = 0; } default;

wavefile {filename = "aud_0.wav"; preload = true;} tone_0;
wavefile {filename = "aud_5.wav"; preload = true;} tone_5;
wavefile {filename = "aud_10.wav"; preload = true;} tone_10;
wavefile {filename = "aud_15.wav"; preload = true;} tone_15;
wavefile {filename = "aud_20.wav"; preload = true;} tone_20;
wavefile {filename = "aud_25.wav"; preload = true;} tone_25;
wavefile {filename = "aud_30.wav"; preload = true;} tone_30;
wavefile {filename = "aud_35.wav"; preload = true;} tone_35;
wavefile {filename = "aud_40.wav"; preload = true;} tone_40;

wavefile {filename = "PinkNoise.wav"; preload = true;} isi_noise;

sound { wavefile tone_0;} aud_0;
sound { wavefile tone_5;} aud_5;
sound { wavefile tone_10;} aud_10;
sound { wavefile tone_15;} aud_15;
sound { wavefile tone_20;} aud_20;
sound { wavefile tone_25;} aud_25;
sound { wavefile tone_30;} aud_30;
sound { wavefile tone_35;} aud_35;
sound { wavefile tone_40;} aud_40;

sound { wavefile isi_noise; loop_playback = true;} isi_aud;

trial {
	monitor_sounds = false;
	trial_duration = stimuli_length;
	#picture default;
	#time = 0;
	stimulus_event {
		sound aud_0;
		port_code = 1; 					#test port code added
		code = "AV";
		parallel = true;
	} av_aud_evt;
	stimulus_event {
		picture default;
	} av_vis_evt;
} a_trl;

text { caption = "a"; font_size = 20; font_color = 0,220,205;
} counttxt1;
text { caption = "Get Ready To Start. Press The '1' Button When You Are Ready To Proceed"; font_size = 20; font_color = 0,220,200;
} breaktxt;
picture { text breaktxt; x = 0; y = 0; text counttxt1; x = 0; y = -200;} break_pic;

trial {
	trial_duration = forever;
	trial_type = correct_response;
	stimulus_event {
		picture break_pic;
		target_button = 2;
	} break_event;
} break_time;

############################################################################
begin_pcl;
############################################################################
# Some timing stuff to make the stims oh so perfectly synchronized
double period = display_device.refresh_period();
double max_scheduling_delay = 15;
double display_device_latency = 5;
double sound_card_latency = 10;
double additional_delay = 14; 		#play with this value to dial in the timing
int refresh_period_time = int(max_scheduling_delay / period) + 1;
double expected_picture_time = refresh_period_time * period;
int visoffset = int( expected_picture_time - period / 2 );
int audoffset = int( expected_picture_time + display_device_latency + additional_delay - sound_card_latency + 0.5);
#term.print_line(visoffset);
#term.print_line(audoffset);

av_vis_evt.set_time(visoffset);
av_aud_evt.set_time(audoffset);
#av_port_evt.set_time(port_offset);
############################################################################

fixcross.set_formatted_text(true);
fixcross.set_caption("<b>X</b>");
fixcross.redraw();

int nstims = 9;
int nreps = 5;
int isi;
int isi_frames;
int flex;

array<int> whichstim[nstims*nreps];

loop
	int i = 1
until i > nstims begin
	whichstim.fill(nreps*i-(nreps-1),nreps*i,i,0);
	i = i + 1;
end;

whichstim.shuffle();
break_time.present();

isi_aud.present();
default.present();
isi_frames = random(60,120);
loop
	int i = 1;
until i == isi_frames begin
		default.present();
		i = i + 1;
end;

loop
	int j = 1
until j > nstims*nreps begin
	#isi_frames = random(60,144);
	isi_frames = random(90,180);
	loop
		int i = 1;
	until i == isi_frames begin
			default.present();
			i = i + 1;
	end;
	if whichstim[j] == 1 then
		av_aud_evt.set_event_code(string(whichstim[j] + 10));
		av_aud_evt.set_port_code(whichstim[j] + 10);		
		av_aud_evt.set_stimulus(aud_0);
		a_trl.present();
	elseif whichstim[j] == 2 then	
		av_aud_evt.set_event_code(string(whichstim[j] + 10));
		av_aud_evt.set_port_code(whichstim[j] + 10);	
		av_aud_evt.set_stimulus(aud_5);
		a_trl.present();
	elseif whichstim[j] == 3 then
		av_aud_evt.set_event_code(string(whichstim[j] + 10));
		av_aud_evt.set_port_code(whichstim[j] + 10);			
		av_aud_evt.set_stimulus(aud_10);
		a_trl.present();
	elseif whichstim[j] == 4 then
		av_aud_evt.set_event_code(string(whichstim[j] + 10));
		av_aud_evt.set_port_code(whichstim[j] + 10);	
		av_aud_evt.set_stimulus(aud_15);
		a_trl.present();
	elseif whichstim[j] == 5 then
		av_aud_evt.set_event_code(string(whichstim[j] + 10));
		av_aud_evt.set_port_code(whichstim[j] + 10);	
		av_aud_evt.set_stimulus(aud_20);
		a_trl.present();
	elseif whichstim[j] == 6 then
		av_aud_evt.set_event_code(string(whichstim[j] + 10));
		av_aud_evt.set_port_code(whichstim[j] + 10);	
		av_aud_evt.set_stimulus(aud_25);
		a_trl.present();	
	elseif whichstim[j] == 7 then
		av_aud_evt.set_event_code(string(whichstim[j] + 10));
		av_aud_evt.set_port_code(whichstim[j] + 10);	
		av_aud_evt.set_stimulus(aud_30);
		a_trl.present();
	elseif whichstim[j] == 8 then
		av_aud_evt.set_event_code(string(whichstim[j] + 10));
		av_aud_evt.set_port_code(whichstim[j] + 10);	
		av_aud_evt.set_stimulus(aud_35);
		a_trl.present();
	else 	
		av_aud_evt.set_event_code(string(whichstim[j] + 10));
		av_aud_evt.set_port_code(whichstim[j] + 10);	
		av_aud_evt.set_stimulus(aud_40);
		a_trl.present();
	end;
	
	term.print_line(nstims*nreps-j);
	j = j +1;
	
	if j == nstims*nreps + 1 then
		default.present();
		isi_frames = random(60,144);
		loop
			int i = 1;
		until i == isi_frames begin
			default.present();
			i = i + 1;
		end;
		audio_device.stop(isi_aud);
	end;
end 