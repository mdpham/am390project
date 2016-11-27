% script to generate presentation examples

% FT compression

threshold = [0.25 0.5 0.75 0.9]
files = {['audio/toms_diner.mp3'] ['audio/pay_no_mind.wav']}

for i = 1:length(files)	
	for j = 1:length(thresholds)
		[f,t,fs,err,er] = ft_comp(files(i),threshold(j));
		% save files somewhere

% MRA compression
wname = 'db2';
N = [5 4 3 2 1];
P = ones(1,5)

for i = 1:length(files)	
	for j = 1:length(thresholds)
		[f,t,fs,err,er] = wavelet_comp(N,P,wname*threshold(j)*100,files(i));
		% save files somewhere