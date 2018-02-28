#header
default_background_color = 128, 128, 128;
write_codes = false;
pulse_width = 5;
#active_buttons = 1;
#button_codes = 1;
no_logfile = true;
###############################################################################
#SDL portion of code
begin;

# in SDL
array {
   LOOP $i 9;
   $k = '$i + 1';
   bitmap { filename = "ffc008/annulus_$i.bmp"; };
   ENDLOOP;
} bmps_008;

array {
   LOOP $i 9;
   $k = '$i + 1';
   bitmap { filename = "ffc004/annulus_$i.bmp"; };
   ENDLOOP;
} bmps_004;

array {
   LOOP $i 9;
   $k = '$i + 1';
   bitmap { filename = "ffc002/annulus_$i.bmp"; };
   ENDLOOP;
} bmps_002;

array {
   LOOP $i 9;
   $k = '$i + 1';
   bitmap { filename = "ffc001/annulus_$i.bmp"; };
   ENDLOOP;
} bmps_001;

array {
   LOOP $i 9;
   $k = '$i + 1';
   bitmap { filename = "ffc000/annulus_$i.bmp"; };
   ENDLOOP;
} bmps_000;

text { caption = "+"; font_size = 16; font_color = 255,255,0; transparent_color = 64,64,64;
} fixcross;

picture { bitmap { filename = ""; preload = false;}; x = 0; y = 0; text fixcross; x = 0; y = 0;} pic; 

#picture { bitmap { filename = "annulus_1.bmp"; }; x = 0; y = 0;} default;
picture {text fixcross; x = 0; y = 0;} default;

trial {
	picture pic;
	time = 0;
} main_trial;
############################################################################
begin_pcl;

fixcross.set_formatted_text(true);
fixcross.set_caption("<b>X</b>");
fixcross.redraw();

int nstims = 5;
int nreps = 25;
int isi;

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
loop
	int j = 1
until j > nstims*nreps begin
	
isi = random(1000,2000);

	if whichstim[j] == 1 then
		
		loop
			int i = 1
		until i == 9 begin
			pic.set_part(1,bmps_008[i]);
			main_trial.present();
			i = i +1;
		end;
		default.present();
		wait_interval(2500);
		
	elseif whichstim[j] == 2 then
		
		loop
			int i = 1
		until i == 9 begin
			pic.set_part(1,bmps_004[i]);
			main_trial.present();
			i = i +1;
		end;
		default.present();
		wait_interval(2500);
		
	elseif whichstim[j] == 3 then
		loop
			int i = 1
		until i == 9 begin
			pic.set_part(1,bmps_002[i]);
			main_trial.present();
			i = i +1;
		end;
		default.present();
		wait_interval(2500);
		
	elseif whichstim[j] == 4 then
		loop
			int i = 1
		until i == 9 begin
			pic.set_part(1,bmps_001[i]);
			main_trial.present();
			i = i +1;
		end;
		default.present();
		wait_interval(2500);
		
	else
		loop
			int i = 1
		until i == 9 begin
			pic.set_part(1,bmps_000[i]);
			main_trial.present();
			i = i +1;
		end;
		default.present();
		wait_interval(2500);
	end;
	
	j = j +1;
end