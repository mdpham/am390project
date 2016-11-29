% Script to generate presentation examples

% FT compression
threshold = [0.25 0.5 0.75 0.9];
folder = 'audio/';
files = {['toms_diner.mp3'] ['pay_no_mind.mp3']};

for i = 1:length(files)	
	for j = 1:length(threshold)
		[f,t,fs,err,er] = ft_comp(char(strcat(folder,files(i))),threshold(j));
		filename = char(strcat(folder,files(i),'_ft_',int2str(threshold(j)*100),'.wav'));
		audiowrite(filename,f,fs);
	end
end

% MRA compression
wname = 'db2';
N = [5 4 3 2 1];
P = ones(1,5);

for i = 1:length(files)	
	for j = 1:length(threshold)
		P_current = P*threshold(j)*100;
		[f,t,err,energy,retained,reduced] = wavelet_comp(N,P_current,wname,char(strcat(folder,files(i))));
		filename = char(strcat(folder,files(i),'_mra_',int2str(threshold(j)*100),'.wav'));
		audiowrite(filename,f,fs);
        
        % Smooth
        sigma = 1;
        size = 10;
        gx = linspace(-size / 2, size / 2, size);
        gaussfilter = exp(-gx .^ 2 / (2 * sigma ^ 2));
        gaussfilter = gaussfilter / sum (gaussfilter);
        f_smooth = conv(f, gaussfilter, 'same');

        filename_smooth = char(strcat(folder,files(i),'_mra_',int2str(threshold(j)*100),'_smooth','.wav'));
        audiowrite(filename_smooth,f_smooth ,fs);
        
	end
end

% generate table of compression amounts