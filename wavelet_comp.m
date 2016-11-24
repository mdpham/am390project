function [f] = wavelet_comp(X,t, N, P, wname)

[coeff, l] = wavedec(X, 5, wname);

nc = wthcoef('d',coeff,l,N,P);

xcomp = waverec(nc,l,wname);

figure(1)
hold on
plot(t,X,'k-')
plot(t,xcomp,'b--')

f = xcomp;
norm(X-xcomp)
end