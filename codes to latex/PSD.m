load('wave.mat');
fs = 10;
window = 4096;
noverlap = [];
nfft = [];
[est_psd, f] = pwelch(psi_w(2,:).*(pi/180),window,noverlap,nfft,fs);