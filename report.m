%% FT compression of non-stationary signals

Fs = 1000;
dt = 1/Fs;
t = 0:dt:(1-dt);
N = numel(t);
% 
% f = sin(2*pi*10*t.^2);
% 
f1 = sin(2*pi*10*t(1:(end/2)));
f2 = sin(2*pi*20*t((end/2)+1:end));
f = [f1 f2];
% 
f = sin(2*pi*10*t)+sin(2*pi*20*t); %only two frequency components

F = fft(f);
power = sort(abs(F));
total = sum(power);
r = 0.25;
thres_idx = 1;
thres_p = 0;
while thres_p <= r*total 
    thres_p = thres_p + power(thres_idx);
    thres_idx = thres_idx + 1;
end
thres = power(thres_idx);

F_r = F;
F_r(abs(F) < thres) = 0;
f_r = ifft(F_r);

err = norm(f-f_r,2);
energy_ratio = 100*(norm(f_r,2)^2)/(norm(f,2)^2);
{err, energy_ratio};

plot(t,f,'-',t,f_r,'--')
title(['r = ' num2str(r) ' , error = ' num2str(err)])
xlabel('t')
ylabel('f')

%% Wavelet compression
wname = 'db2'


