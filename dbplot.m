% Plot Wavelet functions
wname = 'db3';
[phi,psi,xval] = wavefun(wname, 15);
figure(1)
plot(xval,phi,'linewidth',1.5)
xlabel('t')
ylabel('\phi')
% axis([-0.5 1.5 0 1.25])
figure(2)
plot(xval,psi,'linewidth',1.5)
xlabel('t')
ylabel('\psi')
% axis([-0.5 1.5 -1.5 1.5])
