% beating.m

f1=1000;
delta=5;
sf=8192;
t=[0:1/8192:3];

str1=sin(2*pi*f1*t);
input(['Press enter to play a tone at ' int2str(f1) 'Hz']);
soundsc(str1);

str2=sin(2*pi*(f1+delta)*t);
input(['Press enter to play a tone at ' int2str(f1+delta) 'Hz']);
soundsc(str2);

input('Press enter to play both tones simultaneously');
soundsc(str1+str2)