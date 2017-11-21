clear all
close all
clc

%% PSD estimation
load('wave.mat');

fs = 10;
window = 4096;
noverlap = [];
nfft = [];

[est_psd, f] = pwelch(psi_w(2,:).*(pi/180),window,noverlap,nfft,fs);    


est_psd = est_psd*(1/(2*pi));   %converting pxx [power per Hz] to pxx [(power*sec)/rad] 
omega = f.*(2*pi);              %converting f [Hz] to f [rad/s]

[maxValPSD, indexMaxValPSD] = max(est_psd); 
omega_0 = omega(indexMaxValPSD);
sigma = sqrt(maxValPSD);

lambda = 0.045:0.020:0.125;
K_w = 2*lambda.*omega_0*sigma;
psd = (omega.*K_w).^2./(omega.^4 + omega_0^4 + 2*omega_0^2*omega.^2*(2*lambda.^2-1));

%% Plotting
%Finding omega_0 and sigma from this plot
figure
plot(omega,est_psd, 'LineWidth',1); grid on;
title('Estimate of Power Spectral Density (PSD)');
xlabel('\omega [rad/s]');
ylabel('Power');
axis([0 2 0 1.6e-3]);

%Finding appropriate lambda value
figure
subplot(2,1,1)
plot(omega,est_psd,'Linewidth',1); hold on;
plot(omega,psd,'--'); grid
title('Finding \lambda by trial and error')
xlabel('\omega [rad/s]');
ylabel('Power');
legend('Estimate of PSD','Analytical PSD with \lambda = 0.045','Analytical PSD with \lambda = 0.065',...
    'Analytical PSD with \lambda = 0.085','Analytical PSD with \lambda = 0.105','Analytical PSD with \lambda = 0.125');
axis([0 2 0 1.6e-3]);

%A closer look at previous plot
subplot(2,1,2)
plot(omega,est_psd,'Linewidth',1); hold on;
plot(omega,psd,'--'); grid on;
xlabel('\omega [rad/s]');
ylabel('Power');
axis([0.55 1.05 0 1.6e-3]);