%% Chirping example
% Nyquist sampling: Fs > 2*freq*duration
% since the frequency at T_end will be largest frequency component
clear all; close all;
Fs = 10000;                    % Sampling Frequency
dt = 1/Fs;                    % Sampling Period
duration = 5;                % Sound duration
t = (0:dt:duration-dt)';      % Time domain
N = size(t,1);                % Length of signal

freq = 10;

a = sin(2*pi*440*t);
b = sin(2*pi*880*t);
c = a + b;

signal_chirp = sin(2*pi*freq*t.^2);

fft_chirp = fftshift(fft(signal_chirp));
dw = Fs/N;
w_chirp = -Fs/2:dw:Fs/2-dw;           % Frequency domain

figure;
plot(w_chirp,abs(fft_chirp)/N);
xlabel('Frequency (Hz)');
title('Magnitude Response');

% sound(signal_chirp,Fs)

%% Similar power spectrum example

%% Wavelet

% How much energy to retain [0,1]
r = 0.99;

% Signal
t = linspace(0,1,1000);
f = sin(2*pi*t);

% Wavelet decomposition
wavelet = 'haar';
[c,l] = wavedec(f,2,wavelet);

% Position in c vector for looping over detail coeffs
d_idx = l(2);
for i = 2:length(l)-1
    stride = l(i);
    dtl = c(d_idx:d_idx+stride);
    dtl_energy = sort(abs(dtl));
    thres_idx = floor(length(dtl_energy) * r);
    dtl_thres = dtl_energy(thres_idx);
    dtl(abs(dtl) < dtl_thres) = 0;
    c(d_idx:d_idx+stride) = dtl;
    d_idx = d_idx+stride;
end

f2 = waverec(c,l,wavelet);

% Energy ratio: 100*(norm(compressed)^2)/(norm(original)^2)
energy_ratio = 100*(norm(f2,2)^2)/(norm(f,2)^2)

subplot(2,1,1)
plot(t,f)
subplot(2,1,2)
plot(t,f2)
