%% Wavelet

% How much energy to retain [0,1]
r = 0.99;

% Signal
t = linspace(0,1,1000);
f = sin(2*pi*t) + sin(3*pi*t) + sin(4*pi*t) + sin(100*pi*t);


% Wavelet decomposition
wavelet = 'db4';
[coeffs,l] = wavedec(f,2,wavelet);

% Position in c vector for looping over detail coeffs
c = coeffs;
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

% Number of zeros in percentage
compress_zeros = 100 * sum(c==0) / length(c)
original_zeros = 100 * sum(coeffs==0) / length(coeffs)

subplot(2,1,1)
plot(t,f)
subplot(2,1,2)
plot(t,f2)
