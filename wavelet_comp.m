function [f] = wavelet_comp(N, P, wname)

[X,Fs] = audioread('/audio/violin.wav');
X = mean(X')';
dt = 1/Fs;
t = 0:dt:(length(X)*dt - dt);

[coeff, l] = wavedec(X, 5, wname);



nc = wthcoef('d',coeff,l,N,P);

xcomp = waverec(nc,l,wname);

figure(1)
hold on
plot(t,X,'k-');
plot(t,xcomp,'b--');

f = xcomp;
norm(X-xcomp)   
sum(coeff == 0)
sum(nc == 0)

(sum(nc == 0) - sum(coeff == 0)) / length(coeff)
end