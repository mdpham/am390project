function [f] = wavelet_comp(N, P, wname)
% N is vector of what levels [1 2 3 4 5] to threshold
% P is vector of threshold percentages for each level respective to N
% wname is name of wavelet family to use

% Get original signal
[X,Fs] = audioread('/audio/violin.wav');
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

% Plot for comparison
figure(1)
hold on
plot(t,X,'k-');
plot(t,xcomp,'b--');

% Need to figure out error measure other than norm
norm(X-xcomp, 2)
(sum(nc == 0) - sum(coeff == 0)) / length(coeff)
end