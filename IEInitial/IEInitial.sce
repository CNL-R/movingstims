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
array {
   LOOP $i 50;
   $k = '$i + 1';
   bitmap { filename = "vis_1/annulus_$i.bmp"; };
   ENDLOOP;
} bmps_1;

array {
   LOOP $i 50;
   $k = '$i + 1';
   bitmap { filename = "vis_2/annulus_$i.bmp"; };
   ENDLOOP;
} bmps_2;

array {
   LOOP $i 50;
   $k = '$i + 1';
   bitmap { filename = "vis_3/annulus_$i.bmp"; };
   ENDLOOP;
} bmps_3;

array {
   LOOP $i 50;
   $k = '$i + 1';
   bitmap { filename = "vis_4/annulus_$i.bmp"; };
   ENDLOOP;
} bmps_4;
array {
   LOOP $i 50;
   $k = '$i + 1';
   bitmap { filename = "vis_5/annulus_$i.bmp"; };
   ENDLOOP;
} bmps_5;

array {
   LOOP $i 50;
   $k = '$i + 1';
   bitmap { filename = "vis_6/annulus_$i.bmp"; };
   ENDLOOP;
} bmps_6;

array {
   LOOP $i 50;
   $k = '$i + 1';
   bitmap { filename = "vis_7/annulus_$i.bmp"; };
   ENDLOOP;
} bmps_7;

array {
   LOOP $i 50;
   $k = '$i + 1';
   bitmap { filename = "vis_8/annulus_$i.bmp"; };
   ENDLOOP;
} bmps_8;

array {
   LOOP $i 50;
   $k = '$i + 1';
   bitmap { filename = "vis_9/annulus_$i.bmp"; };
   ENDLOOP;
} bmps_9;

array {
   LOOP $i 50;
   $k = '$i + 1';
   bitmap { filename = "vis_10/annulus_$i.bmp"; };
   ENDLOOP;
} bmps_10;
array {
   LOOP $i 50;
   $k = '$i + 1';
   bitmap { filename = "vis_11/annulus_$i.bmp"; };
   ENDLOOP;
} bmps_11;


array {
   LOOP $i 150;
   $k = '$i + 1';
   bitmap { filename = "vis_noise/annulus_$i.bmp"; };
   ENDLOOP;
} bmps_noise;

text { caption = "+"; font_size = 16; font_color = 0,0,0; transparent_color = 128,128,128;
} fixcross;

picture { bitmap { filename = ""; preload = false;}; x = 0; y = 0; text fixcross; x = 0; y = 0; } pic; 

#picture { bitmap { filename = "annulus_1.bmp"; }; x = 0; y = 0;} default;
picture {text fixcross; x = 0; y = 0; } default;

wavefile {filename = "aud_1.wav"; preload = true;} tone_1;
wavefile {filename = "aud_2.wav"; preload = true;} tone_2;
wavefile {filename = "aud_3.wav"; preload = true;} tone_3;
wavefile {filename = "aud_4.wav"; preload = true;} tone_4;
wavefile {filename = "aud_5.wav"; preload = true;} tone_5;
wavefile {filename = "aud_6.wav"; preload = true;} tone_6;
wavefile {filename = "aud_7.wav"; preload = true;} tone_7;
wavefile {filename = "aud_8.wav"; preload = true;} tone_8;
wavefile {filename = "aud_9.wav"; preload = true;} tone_9;
wavefile {filename = "aud_10.wav"; preload = true;} tone_10;
wavefile {filename = "aud_11.wav"; preload = true;} tone_11;

wavefile {filename = "PinkNoise.wav"; preload = true;} isi_noise;
wavefile {filename = "silence1000.wav"; preload = true;} isi_silence;

sound { wavefile tone_1;} aud_1;
sound { wavefile tone_2;} aud_2;
sound { wavefile tone_3;} aud_3;
sound { wavefile tone_4;} aud_4;
sound { wavefile tone_5;} aud_5;
sound { wavefile tone_6;} aud_6;
sound { wavefile tone_7;} aud_7;
sound { wavefile tone_8;} aud_8;
sound { wavefile tone_9;} aud_9;
sound { wavefile tone_10;} aud_10;
sound { wavefile tone_11;} aud_11;

sound { wavefile isi_noise; loop_playback = true;} isi_aud;
sound { wavefile isi_silence; loop_playback = true;} isi_vis;

trial {
	monitor_sounds = false;
	trial_duration = stimuli_length;
	#picture default;
	#time = 0;
	stimulus_event {
		sound aud_1;
		port_code = 1; 					#test port code added
		code = "AV";
		parallel = true;
	} a_aud_evt;
	stimulus_event {
		picture default;
	} a_vis_evt;
} a_trl;

trial {
	monitor_sounds = false;
	trial_duration = stimuli_length;
	#picture default;
	#time = 0;
	stimulus_event {
		sound aud_1;
		port_code = 1; 					#test port code added
		code = "AV";
		parallel = true;
	} v_aud_evt;
	stimulus_event {
		picture pic;
	} v_vis_evt;
} v_trl;

text { caption = "Take a short break, press the '1' button when you are ready to proceed"; font_size = 20; font_color = 0,255,255;
} breaktxt;
text { caption = "a"; font_size = 20; font_color = 0,255,255;
} counttxt1;
picture { text breaktxt; x = 0; y = 0; text counttxt1; x = 0; y = -200;} break_pic;

trial {
	trial_duration = forever;
	trial_type = specific_response;
	terminator_button = 2;
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

a_vis_evt.set_time(visoffset);
a_aud_evt.set_time(audoffset);
v_vis_evt.set_time(visoffset);
v_aud_evt.set_time(audoffset);
#av_port_evt.set_time(port_offset);
############################################################################

fixcross.set_formatted_text(true);
fixcross.set_caption("<b>X</b>");
fixcross.redraw();

int nstims = 11;
int nreps = 5;
int isi;
int isi_frames;
int flex;
array<int> whichstim[nstims*nreps];

array<int> blockorder[] = {1,1,1,1,1,1,1,1,1,2,2,2,2,2,2,2,2,2};
blockorder.shuffle();

int stimpoolsize = 50;
loop
	int blocknum = 0;
until
	blocknum == blockorder.count()+1
begin
	blocknum = blocknum + 1;

	if blocknum < blockorder.count()+1 then
		counttxt1.set_caption( "You are about to start block " + string(blocknum) + " out of " + string(blockorder.count()) + " blocks" );
		counttxt1.redraw();
		term.print_line("Break Time");
		break_time.present();
	end;
	
	whichstim.fill(1, nstims*nreps, 0, 0);
	loop
		int i = 1
	until i > nstims begin
		whichstim.fill(nreps*i-(nreps-1),nreps*i,i,0);
		i = i + 1;
	end;
	whichstim.shuffle();

	default.present();
	wait_interval(3000);
	
	# If Audio Block
	if blockorder[blocknum] == 1 then
		isi_aud.present();
		default.present();
		isi_frames = random(90,168);
		loop
			int i = 1;
		until i == isi_frames begin
			default.present();
			i = i + 1;
		end;

		loop
			int j = 1
		until j > nstims*nreps begin
			isi_frames = random(90,168);
			loop
				int i = 1;
			until i == isi_frames begin
					default.present();
					i = i + 1;
			end;
			if whichstim[j] == 1 then
				a_aud_evt.set_event_code(string(whichstim[j] + 10));
				a_aud_evt.set_port_code(whichstim[j] + 10);		
				a_aud_evt.set_stimulus(aud_1);
				a_trl.present();
			elseif whichstim[j] == 2 then
				a_aud_evt.set_event_code(string(whichstim[j] + 10));
				a_aud_evt.set_port_code(whichstim[j] + 10);		
				a_aud_evt.set_stimulus(aud_2);
				a_trl.present();
			elseif whichstim[j] == 3 then	
				a_aud_evt.set_event_code(string(whichstim[j] + 10));
				a_aud_evt.set_port_code(whichstim[j] + 10);	
				a_aud_evt.set_stimulus(aud_3);
				a_trl.present();
			elseif whichstim[j] == 4 then
				a_aud_evt.set_event_code(string(whichstim[j] + 10));
				a_aud_evt.set_port_code(whichstim[j] + 10);			
				a_aud_evt.set_stimulus(aud_4);
				a_trl.present();
			elseif whichstim[j] == 5 then
				a_aud_evt.set_event_code(string(whichstim[j] + 10));
				a_aud_evt.set_port_code(whichstim[j] + 10);	
				a_aud_evt.set_stimulus(aud_5);
				a_trl.present();
			elseif whichstim[j] == 6 then
				a_aud_evt.set_event_code(string(whichstim[j] + 10));
				a_aud_evt.set_port_code(whichstim[j] + 10);	
				a_aud_evt.set_stimulus(aud_6);
				a_trl.present();
				
			elseif whichstim[j] == 7 then
				a_aud_evt.set_event_code(string(whichstim[j] + 10));
				a_aud_evt.set_port_code(whichstim[j] + 10);	
				a_aud_evt.set_stimulus(aud_7);
				a_trl.present();	
			elseif whichstim[j] == 8 then
				a_aud_evt.set_event_code(string(whichstim[j] + 10));
				a_aud_evt.set_port_code(whichstim[j] + 10);	
				a_aud_evt.set_stimulus(aud_8);
				a_trl.present();
			elseif whichstim[j] == 9 then
				a_aud_evt.set_event_code(string(whichstim[j] + 10));
				a_aud_evt.set_port_code(whichstim[j] + 10);	
				a_aud_evt.set_stimulus(aud_9);
				a_trl.present();
			elseif whichstim[j] == 10 then	
				a_aud_evt.set_event_code(string(whichstim[j] + 10));
				a_aud_evt.set_port_code(whichstim[j] + 10);	
				a_aud_evt.set_stimulus(aud_10);
				a_trl.present();
			elseif whichstim[j] == 11 then	
				a_aud_evt.set_event_code(string(whichstim[j] + 10));
				a_aud_evt.set_port_code(whichstim[j] + 10);	
				a_aud_evt.set_stimulus(aud_11);
				a_trl.present();
			end;
			
			term.print_line(nstims*nreps-j);
			j = j +1;
			
			if j == nstims*nreps + 1 then
				default.present();
				isi_frames = random(90,168);
				loop
					int i = 1;
				until i == isi_frames begin
					default.present();
					i = i + 1;
				end;
				audio_device.stop(isi_aud);
			end;		
		end;	
#If Visual Block
	elseif blockorder[blocknum] == 2 then
		isi_vis.present();
		isi_frames = random(90,168);
		loop
			int i = 1;
		until i == isi_frames begin
				flex = random(1,150);
				pic.set_part(1,bmps_noise[flex]);
				pic.present();
				i = i + 1;
		end;
		loop
			int j = 1
		until j > nstims*nreps begin
			isi_frames = random(90,168);
			loop
				int i = 1;
			until i == isi_frames begin
					flex = random(1,150);
					pic.set_part(1,bmps_noise[flex]);
					pic.present();
					i = i + 1;
			end;
			
			if whichstim[j] == 1 then
				v_aud_evt.set_event_code(string(whichstim[j] + 100));
				v_aud_evt.set_port_code(whichstim[j] + 100);		
				loop
					int i = 1
				until i == 6 begin
					if i == 1 then
						flex = random(1,stimpoolsize);
						pic.set_part(1,bmps_1[flex]);
						v_trl.present();
						i = i + 1;
					else
						flex = random(1,stimpoolsize);
						pic.set_part(1,bmps_1[flex]);
						pic.present();
						i = i +1;
					end;
				end;
			elseif whichstim[j] == 2 then	
				v_aud_evt.set_event_code(string(whichstim[j] + 100));
				v_aud_evt.set_port_code(whichstim[j] + 100);		
				loop
					int i = 1
				until i == 6 begin
					if i == 1 then
						flex = random(1,stimpoolsize);
						pic.set_part(1,bmps_2[flex]);
						v_trl.present();
						i = i + 1;
					else
						flex = random(1,stimpoolsize);
						pic.set_part(1,bmps_2[flex]);
						pic.present();
						i = i +1;
					end;
				end;
			elseif whichstim[j] == 3 then
				v_aud_evt.set_event_code(string(whichstim[j] + 100));
				v_aud_evt.set_port_code(whichstim[j] + 100);		
				loop
					int i = 1
				until i == 6 begin
					if i == 1 then
						flex = random(1,stimpoolsize);
						pic.set_part(1,bmps_3[flex]);
						v_trl.present();
						i = i + 1;
					else
						flex = random(1,stimpoolsize);
						pic.set_part(1,bmps_3[flex]);
						pic.present();
						i = i +1;
					end;
				end;
			elseif whichstim[j] == 4 then
				flex = random(1,stimpoolsize);
				v_aud_evt.set_event_code(string(whichstim[j] + 100));
				v_aud_evt.set_port_code(whichstim[j] + 100);		
				loop
					int i = 1
				until i == 6 begin
					if i == 1 then
						flex = random(1,stimpoolsize);
						pic.set_part(1,bmps_4[flex]);
						v_trl.present();
						i = i + 1;
					else
						flex = random(1,stimpoolsize);
						pic.set_part(1,bmps_4[flex]);
						pic.present();
						i = i +1;
					end;
				end;
			elseif whichstim[j] == 5 then
				v_aud_evt.set_event_code(string(whichstim[j] + 100));
				v_aud_evt.set_port_code(whichstim[j] + 100);		
				loop
					int i = 1
				until i == 6 begin
					if i == 1 then
						flex = random(1,stimpoolsize);
						pic.set_part(1,bmps_5[flex]);
						v_trl.present();
						i = i + 1;
					else
						flex = random(1,stimpoolsize);
						pic.set_part(1,bmps_5[flex]);
						pic.present();
						i = i +1;
					end;
				end;
				
			elseif whichstim[j] == 6 then
				v_aud_evt.set_event_code(string(whichstim[j] + 100));
				v_aud_evt.set_port_code(whichstim[j] + 100);		
				loop
					int i = 1
				until i == 6 begin
					if i == 1 then
						flex = random(1,stimpoolsize);
						pic.set_part(1,bmps_6[flex]);
						v_trl.present();
						i = i + 1;
					else
						flex = random(1,stimpoolsize);
						pic.set_part(1,bmps_6[flex]);
						pic.present();
						i = i +1;
					end;
				end;
			elseif whichstim[j] == 7 then
				v_aud_evt.set_event_code(string(whichstim[j] + 100));
				v_aud_evt.set_port_code(whichstim[j] + 100);		
				loop
					int i = 1
				until i == 6 begin
					if i == 1 then
						flex = random(1,stimpoolsize);
						pic.set_part(1,bmps_7[flex]);
						v_trl.present();
						i = i + 1;
					else
						flex = random(1,stimpoolsize);
						pic.set_part(1,bmps_7[flex]);
						pic.present();
						i = i +1;
					end;
				end;
			elseif whichstim[j] == 8 then
				v_aud_evt.set_event_code(string(whichstim[j] + 100));
				v_aud_evt.set_port_code(whichstim[j] + 100);		
				loop
					int i = 1
				until i == 6 begin
					if i == 1 then
						flex = random(1,stimpoolsize);
						pic.set_part(1,bmps_8[flex]);
						v_trl.present();
						i = i + 1;
					else
						flex = random(1,stimpoolsize);
						pic.set_part(1,bmps_8[flex]);
						pic.present();
						i = i +1;
					end;
				end;
			elseif whichstim[j] == 9 then
				v_aud_evt.set_event_code(string(whichstim[j] + 100));
				v_aud_evt.set_port_code(whichstim[j] + 100);		
				loop
					int i = 1
				until i == 6 begin
					if i == 1 then
						flex = random(1,stimpoolsize);
						pic.set_part(1,bmps_9[flex]);
						v_trl.present();
						i = i + 1;
					else
						flex = random(1,stimpoolsize);
						pic.set_part(1,bmps_9[flex]);
						pic.present();
						i = i +1;
					end;
				end;
			elseif whichstim[j] == 10 then	
				v_aud_evt.set_event_code(string(whichstim[j] + 100));
				v_aud_evt.set_port_code(whichstim[j] + 100);		
				loop
					int i = 1
				until i == 6 begin
					if i == 1 then
						flex = random(1,stimpoolsize);
						pic.set_part(1,bmps_10[flex]);
						v_trl.present();
						i = i + 1;
					else
						flex = random(1,stimpoolsize);
						pic.set_part(1,bmps_10[flex]);
						pic.present();
						i = i +1;
					end;
				end;
			elseif whichstim[j] == 11 then
				v_aud_evt.set_event_code(string(whichstim[j] + 100));
				v_aud_evt.set_port_code(whichstim[j] + 100);		
				loop
					int i = 1
				until i == 6 begin
					if i == 1 then
						flex = random(1,stimpoolsize);
						pic.set_part(1,bmps_11[flex]);
						v_trl.present();
						i = i + 1;
					else
						flex = random(1,stimpoolsize);
						pic.set_part(1,bmps_11[flex]);
						pic.present();
						i = i +1;
					end;
				end;
			end;			
			term.print_line(nstims*nreps-j);
			j = j +1;
			
			if j == nstims*nreps + 1 then
				isi_frames = random(90,168);
				loop
					int i = 1;
				until i == isi_frames begin
						flex = random(1,150);
						pic.set_part(1,bmps_noise[flex]);
						pic.present();
						i = i + 1;
				end;
				audio_device.stop(isi_aud);
			end;
		end; 
	end;
end;
