%% Abrupt change in signal frequency
clear all; close all;

Fs = 1000;                    % Sampling Frequency
dt = 1/Fs;                    % Sampling Period
duration = 10;                % Sound duration
t = (0:dt:duration-dt)';      % Time domain
N = size(t,1);                % Length of signal


f1 = sin(2*pi*440*t(1:end/2));
f2 = sin(2*pi*880*t((end/2)+1:end));
f1 = sin(2*pi*10*t(1:end/2));
f2 = sin(2*pi*20*t((end/2)+1:end));
f = [f1;f2];

% g = sin(2*pi*10*t) + sin(2*pi*20*t);
g = sin(2*pi*440*t) + sin(2*pi*880*t);

fft_f = fftshift(fft(f));
fft_g = fftshift(fft(g));
dw = Fs/N;
w = -Fs/2:dw:Fs/2-dw;           % Frequency domain

% figure(1)
% plot(t,f)
% xlabel('Time t')
% ylabel('f(t)')
% title('f')
% 
% figure(2)
% plot(t,g)
% xlabel('Time t')
% ylabel('g(t)')
% title('g')
% 

subplot(2,1,1)
plot(w,abs(fft_f/N))
xlabel('Frequency \omega (Hz)')
ylabel('|F(\omega)|')
title('Magnitude Response f (abrupt change)')

subplot(2,1,2)
plot(w,abs(fft_g/N))
xlabel('Frequency \omega (Hz)')
ylabel('|G(\omega)|')
title('Magnitude Response g (superposition)')

input('Play f: sound(f,Fs)')
sound(f, Fs)

input('Play g: sound(g,Fs)')
sound(g, Fs)