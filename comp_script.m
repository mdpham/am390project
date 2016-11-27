wname = 'db2';
N = [5 4 3 2 1];
filename = '/audio/violin.wav'

err = [];
energy = [];
retained = [];
reduced = [];
p = 0:5:100;
for i = 1:length(p)
    P = ones(1,5)*p(i);
    [xcomp,t, er, ener, ret, red] = wavelet_comp(N,P,wname,filename);
    err = [err er];
    energy = [energy ener];
    retained = [retained ret];
    reduced = [reduced red];
end

wname

[p' 100*reduced' 100*err' energy']