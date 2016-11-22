%% Chirp/sweep signal
clear all; close all;

Fs = 1600;                    % Sampling Frequency
dt = 1/Fs;                    % Sampling Period
duration = 15;                % Sound duration
t = (0:dt:duration-dt)';      % Time domain
N = size(t,1);                % Length of signal

freq = 10;
signal_chirp = sin(2*pi*freq*t.^2);
fft_chirp = fftshift(fft(signal_chirp));
dw = Fs/N;
w_chirp = -Fs/2:dw:Fs/2-dw;           % Frequency domain

figure(1)
plot(t,signal_chirp)
xlabel('Time t')
ylabel('f(t)')
title('f(t) = sin(2\pi10t^2)')

figure(2)
plot(w_chirp,abs(fft_chirp/N))
xlabel('Frequency \omega (Hz)')
ylabel('|F(\omega)|')
title('Magnitude Response f(t) = sin(2\pi10t^2)')

sound(signal_chirp,Fs)