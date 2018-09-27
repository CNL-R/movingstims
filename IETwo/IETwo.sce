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

wavefile {filename = "aud_0.wav"; preload = true;} tone_0;
wavefile {filename = "aud_1.wav"; preload = true;} tone_1;
wavefile {filename = "aud_2.wav"; preload = true;} tone_2;
wavefile {filename = "aud_3.wav"; preload = true;} tone_3;

wavefile {filename = "PinkNoise.wav"; preload = true;} isi_noise;
wavefile {filename = "silence1000.wav"; preload = true;} isi_silence;

sound { wavefile tone_0;} aud_0;
sound { wavefile tone_1;} aud_1;
sound { wavefile tone_2;} aud_2;
sound { wavefile tone_3;} aud_3;

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
		code = "A";
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
		sound aud_0;
		port_code = 1; 					#test port code added
		code = "V";
		parallel = true;
	} v_aud_evt;
	stimulus_event {
		picture pic;
	} v_vis_evt;
} v_trl;

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
	} av_aud_evt;
	stimulus_event {
		picture pic;
	} av_vis_evt;
} av_trl;

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
	
trial { nothing{}; time = 0; port_code = 253;} pause_off;
trial { nothing{}; time = 0; port_code = 254;} pause_on;
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
av_vis_evt.set_time(visoffset);
av_aud_evt.set_time(audoffset);
#av_port_evt.set_time(port_offset);
############################################################################

fixcross.set_formatted_text(true);
fixcross.set_caption("<b>X</b>");
fixcross.redraw();

int nstims = 2; #true stimuli (not catch trial or supra catch)

int ncatches = 5; #number of catches per block. (if ncatches = 5, there will be 5 supraliminal catchse and 5 zero catch trials in a block)
int nreps = 25;
int ntrials = nstims*nreps+2*ncatches;
int isi;
int isi_frames;
int flex;
array<int> temparr[ncatches];
array<int> whichstim[nstims*nreps];
term.print_line(whichstim.count());
#array<int> blockorder[] = {3,3,3,3,3,3,3,3,3,3,3,3,1,1,1,1,1,1,1,1,1,1,1,1,2,2,2,2,2,2,2,2,2,2,2,2};
array<int> blockorder[] = {1,1,2,2,3,3};
#array<int>bloclorder[] = {1,1,1,1,1,1,1,1,2,2,2,2,2,2,2,2,3,3,3,3,3,3,3,3} # 8 of each block. 25*8 = 200reps of stims. 40 catches 40 supra catches. 

blockorder.shuffle();

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
	term.print_line(whichstim.count());
	
	loop
		int i = nstims + 1
	until i > nstims + 2 begin
		temparr.fill(1,ncatches,i,0);
		whichstim.append(temparr);
		i = i + 1;
	end;
	
	term.print_line(whichstim.count());
	term.print_line(whichstim);
	whichstim.shuffle();
	
	pause_off.present();
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
		until j > ntrials begin
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
			else
				a_aud_evt.set_event_code(string(10));
				a_aud_evt.set_port_code(0 + 10);	
				a_aud_evt.set_stimulus(aud_0);
				a_trl.present();
			end;
			
			term.print_line(ntrials-j);
			j = j +1;
			
			if j == ntrials + 1 then
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
		until j > ntrials begin
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
				v_aud_evt.set_event_code(string(whichstim[j] + 20));
				v_aud_evt.set_port_code(whichstim[j] + 20);	
				loop
					int i = 1;
				until i == 6 begin
					if i == 1 then
						flex = random(1,50);	
						pic.set_part(1,bmps_1[flex]);
						v_trl.present();
						i = i + 1;
					else
						flex = random(1,50);
						pic.set_part(1,bmps_1[flex]);
						pic.present();
						i = i +1;
					end;
				end;
			elseif whichstim[j] == 2 then	
				v_aud_evt.set_event_code(string(whichstim[j] + 20));
				v_aud_evt.set_port_code(whichstim[j] + 20);		
				loop
					int i = 1;
				until i == 6 begin
					if i == 1 then
						flex = random(1,50);
						pic.set_part(1,bmps_2[flex]);
						v_trl.present();
						i = i + 1;
					else
						flex = random(1,50);
						pic.set_part(1,bmps_2[flex]);
						pic.present();
						i = i +1;
					end;
				end;
			elseif whichstim[j] == 3 then
				v_aud_evt.set_event_code(string(whichstim[j] + 20));
				v_aud_evt.set_port_code(whichstim[j] + 20);		
				loop
					int i = 1;
				until i == 6 begin
					if i == 1 then
						flex = random(1,50);
						pic.set_part(1,bmps_3[flex]);
						v_trl.present();
						i = i + 1;
					else
						flex = random(1,50);
						pic.set_part(1,bmps_3[flex]);
						pic.present();
						i = i +1;
					end;
				end;
			else
				v_aud_evt.set_event_code(string(20));
				v_aud_evt.set_port_code(0 + 20);		
				loop
					int i = 1;
				until i == 6 begin
					if i == 1 then
						flex = random(1,150);
						pic.set_part(1,bmps_noise[flex]);
						v_trl.present();
						i = i + 1;
					else
						flex = random(1,150);
						pic.set_part(1,bmps_noise[flex]);
						pic.present();
						i = i +1;
					end;
				end;
			end;
			term.print_line(ntrials-j);
			j = j +1;
			
			if j == ntrials + 1 then
				isi_frames = random(90,168);
				loop
					int i = 1;;
				until i == isi_frames begin
					flex = random(1,150);
					pic.set_part(1,bmps_noise[flex]);
					pic.present();
					i = i + 1;
				end;
					audio_device.stop(isi_vis);
			end; 
		end;
	else  #AV Block
		isi_aud.present();
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
			int j = 1;
		until j > ntrials begin
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
				loop
					int i = 1;
				until i == 6 begin
					if i == 1 then
						flex = random(1,50);
						av_aud_evt.set_event_code(string(whichstim[j] + 30));
						av_aud_evt.set_port_code(whichstim[j] + 30);	
						av_aud_evt.set_stimulus(aud_1);
						pic.set_part(1,bmps_1[flex]);
						av_trl.present();
						i = i + 1;
					else
						flex = random(1,50);
						pic.set_part(1,bmps_1[flex]);
						pic.present();
						i = i +1;
					end;
				end;
			elseif whichstim[j] == 2 then	
				loop
					int i = 1;
				until i == 6 begin
					if i == 1 then
						flex = random(1,50);
						av_aud_evt.set_event_code(string(whichstim[j] + 30));
						av_aud_evt.set_port_code(whichstim[j] + 30);	
						av_aud_evt.set_stimulus(aud_2);
						pic.set_part(1,bmps_2[flex]);
						av_trl.present();
						i = i + 1;
					else
						flex = random(1,50);
						pic.set_part(1,bmps_2[flex]);
						pic.present();
						i = i +1;
					end;
				end;
			elseif whichstim[j] == 3 then
				loop
					int i = 1;
				until i == 6 begin
					if i == 1 then
						flex = random(1,50);
						av_aud_evt.set_event_code(string(whichstim[j] + 30));
						av_aud_evt.set_port_code(whichstim[j] + 30);	
						av_aud_evt.set_stimulus(aud_3);
						pic.set_part(1,bmps_3[flex]);
						av_trl.present();
						i = i + 1;
					else
						flex = random(1,50);
						pic.set_part(1,bmps_3[flex]);
						pic.present();
						i = i +1;
					end;
				end; 
			else 
				loop
					int i = 1;
				until i == 6 begin
					if i == 1 then
						av_aud_evt.set_event_code(string(0 + 30));
						av_aud_evt.set_port_code(0 + 30);	
						av_aud_evt.set_stimulus(aud_0);
						flex = random(1,150);
						pic.set_part(1,bmps_noise[flex]);
						av_trl.present();
						i = i + 1;
					else
						flex = random(1,150);
						pic.set_part(1,bmps_noise[flex]);
						pic.present();
						i = i +1;
					end;					
				end;				
			end;
			term.print_line(ntrials-j);
			j = j +1;
		end;
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
	
	pause_on.present();
end;
