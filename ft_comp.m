function [f_r, t, Fs, err, energy_ratio] = ft_comp(filename,P)
% filename is the file name, including the filepath
% P is hard threshold percentage for each level respective to 

[f,Fs] = audioread(filename);
f = mean(f')'; % convert signal to mono
dt = 1/Fs;
t = 0:dt:(length(f)*dt - dt);

F = fft(f);
power = sort(abs(F));
total = sum(power);
thres_idx = 1;2
thres_p = 0;

while thres_p <= P*total 
    thres_p = thres_p + power(thres_idx);
    thres_idx = thres_idx + 1;
end
thres = power(thres_idx);

F_r = F;
F_r(abs(F) < thres) = 0; % zero out any coeffs below the threshold
f_r = ifft(F_r); % reconstruct signal

err = norm(f-f_r,2);
energy_ratio = 100*(norm(f_r,2)^2)/(norm(f,2)^2);

