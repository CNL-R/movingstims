#header
default_background_color = 128, 128, 128;
write_codes = true;
pulse_width = 5;
#active_buttons = 1;
#button_codes = 1;
no_logfile = true;
###############################################################################
#SDL portion of code
begin;

# in SDL
array {
   LOOP $i 10;
   $k = '$i + 1';
   bitmap { filename = "vis_025/annulus_$i.bmp"; };
   ENDLOOP;
} bmps_010;

array {
   LOOP $i 10;
   $k = '$i + 1';
   bitmap { filename = "vis_020/annulus_$i.bmp"; };
   ENDLOOP;
} bmps_008;

array {
   LOOP $i 10;
   $k = '$i + 1';
   bitmap { filename = "vis_015/annulus_$i.bmp"; };
   ENDLOOP;
} bmps_006;

array {
   LOOP $i 10;
   $k = '$i + 1';
   bitmap { filename = "vis_010/annulus_$i.bmp"; };
   ENDLOOP;
} bmps_004;

array {
   LOOP $i 10;
   $k = '$i + 1';
   bitmap { filename = "vis_005/annulus_$i.bmp"; };
   ENDLOOP;
} bmps_000;

array {
   LOOP $i 150;
   $k = '$i + 1';
   bitmap { filename = "vis_black/annulus_$i.bmp"; };
   ENDLOOP;
} bmps_noise;

text { caption = "+"; font_size = 16; font_color = 0,0,0; transparent_color = 128,128,128;
} fixcross;

picture { bitmap { filename = ""; preload = false;}; x = 0; y = 0; text fixcross; x = 0; y = 0; } pic; 

#picture { bitmap { filename = "annulus_1.bmp"; }; x = 0; y = 0;} default;
picture {text fixcross; x = 0; y = 0; } default;

wavefile {filename = "aud_050.wav"; preload = true;} tone_001;
wavefile {filename = "aud_050.wav"; preload = true;} tone_005;
wavefile {filename = "aud_050.wav"; preload = true;} tone_010;
wavefile {filename = "aud_050.wav"; preload = true;} tone_015;
wavefile {filename = "aud_050.wav"; preload = true;} tone_025;
wavefile {filename = "aud_050.wav"; preload = true;} tone_050;

wavefile {filename = "pnoise1000.wav"; preload = true;} isi_noise;

sound { wavefile tone_001;} aud_001;
sound { wavefile tone_005;} aud_005;
sound { wavefile tone_010;} aud_010;
sound { wavefile tone_015;} aud_015;
sound { wavefile tone_025;} aud_025;
sound { wavefile tone_050;} aud_050;

sound { wavefile isi_noise; loop_playback = true;} isi_aud;

trial {
	monitor_sounds = false;
	picture pic;
	time = 0;
} main_trial;

trial {
	monitor_sounds = false;
	trial_duration = stimuli_length;
	#picture default;
	#time = 0;
	stimulus_event {
		sound aud_001;
		port_code = 1; 					#test port code added
		code = "AV";
		parallel = true;
	} av_aud_evt;
	stimulus_event {
		picture pic;
#		port_code = 1;				#REMEMBER: ONSET TIMES HAVE NOT BEEN DEFINED
	} av_vis_evt;
	#stimulus_event {
	#	nothing{};
	#	port_code = 1;
	#	time = 0;
	#} av_port_evt;

} av_trl;

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
#int visoffset = 12;
#int audoffset = 27;
#int port_offset = 27;

term.print_line(visoffset);
term.print_line(audoffset);

av_vis_evt.set_time(visoffset);
av_aud_evt.set_time(audoffset);
#av_port_evt.set_time(port_offset);
############################################################################

fixcross.set_formatted_text(true);
fixcross.set_caption("<b>X</b>");
fixcross.redraw();

int nstims = 5;
int nreps = 25;
int isi;
int isi_frames;

array<int> whichstim[nstims*nreps];

loop
	int i = 1
until i > nstims begin
	whichstim.fill(nreps*i-24,nreps*i,i,0);
	i = i + 1;
end;
whichstim.shuffle();


default.present();
wait_interval(3000);

isi_aud.present();

loop
	int j = 1
until j > nstims*nreps begin
	

	isi_frames = random(60,144);
	loop
		int i = 1;
		int flex
	until i == isi_frames begin
			flex = random(1,150);
			pic.set_part(1,bmps_noise[flex]);
			pic.present();
			i = i + 1;
	end;

	if whichstim[j] == 1 then
		
		loop
			int i = 1
		until i == 9 begin
			if i == 1 then
				av_aud_evt.set_stimulus(aud_050);
				pic.set_part(1,bmps_010[i]);
				av_trl.present();
				i = i + 1;
			else
				pic.set_part(1,bmps_010[i]);
				pic.present();
				i = i +1;
			end;
		end;
		
	elseif whichstim[j] == 2 then
		
		loop
			int i = 1
		until i == 9 begin
			if i == 1 then
				av_aud_evt.set_stimulus(aud_025);
				pic.set_part(1,bmps_008[i]);
				av_trl.present();
				i = i + 1;
			else
				pic.set_part(1,bmps_008[i]);
				pic.present();
				i = i +1;
			end;
		end;
		
	elseif whichstim[j] == 3 then
		loop
			int i = 1
		until i == 9 begin
			if i == 1 then
				av_aud_evt.set_stimulus(aud_015);
				pic.set_part(1,bmps_006[i]);
				av_trl.present();
				i = i + 1;
			else
				pic.set_part(1,bmps_006[i]);
				pic.present();
				i = i +1;
			end;
		end;
		
	elseif whichstim[j] == 4 then
		loop
			int i = 1
		until i == 9 begin
			if i == 1 then
				av_aud_evt.set_stimulus(aud_010);
				pic.set_part(1,bmps_004[i]);
				av_trl.present();
				i = i + 1;
			else
				pic.set_part(1,bmps_004[i]);
				pic.present();
				i = i +1;
			end;
		end;
		
	else
		loop
			int i = 1
		until i == 9 begin
			if i == 1 then
				av_aud_evt.set_stimulus(aud_005);
				pic.set_part(1,bmps_000[i]);
				av_trl.present();
				i = i + 1;
			else
				pic.set_part(1,bmps_000[i]);
				pic.present();
				i = i +1;
			end;
		end;
	end;
	
	j = j +1;
end