function [f,t, err, energy, retained, reduced] = wavelet_comp(N, P, wname, filename)
% N is vector of what levels [1 2 3 4 5] to threshold
% P is vector of threshold percentages for each level respective to N
% filename is the file name, including the filepath

% Get original signal
[X,Fs] = audioread(filename);
X = mean(X')';
dt = 1/Fs;
t = 0:dt:(length(X)*dt - dt);

% Decomposition to five levels
[coeff, l] = wavedec(X, 5, wname);
% Threshold based on provided N,P
nc = wthcoef('d',coeff,l,N,P);
% Reconstruction
xcomp = waverec(nc,l,wname);
f = xcomp;

% % Plot for comparison
figure(1)
subplot(2,1,1)
plot(t,X,'-');
ylabel('compressed')
subplot(2,1,2)
plot(t,X-xcomp,'--')
ylabel('original - compressed')
xlabel('Time (secs)')

% Scores
% Percentage of coefficients zeroed
reduced = 100*(sum(nc==0) - sum(coeff==0))/length(X)
% Error
err = 100*norm(X-xcomp,2)/norm(X,2)
% Energy ratio
energy = 100*(norm(xcomp,2)^2)/(norm(X,2)^2)
% Retained energy
retained = 100*(norm(nc,2)^2)/(norm(X,2)^2)

% Smooth
sigma = 1;
size = 10;
gx = linspace(-size / 2, size / 2, size);
gaussfilter = exp(-gx .^ 2 / (2 * sigma ^ 2));
gaussfilter = gaussfilter / sum (gaussfilter);
xcompsmooth = conv(xcomp, gaussfilter, 'same');

% Play
sound(xcompsmooth,Fs)
end
