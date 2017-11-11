clear all
close all
clc

%% Precalculated variables
T = 72.442;
K = 0.156;
lambda = 0.085;

%% PSD estimation
load('wave.mat');

fs = 10;
window = 4096;
noverlap = [];
nfft = [];

[est_psd, f] = pwelch(psi_w(2,:).*(pi/180),window,noverlap,nfft,fs);    %psi_w is given in degrees (translates to radians)

%converting pxx(power per Hertz) and f(Hz) to pxx(power*sec / rad) and f(rad / s) 
est_psd = est_psd./(2*pi);
omega = 2*pi.*f;

[maxValPSD, indexMaxValPSD] = max(est_psd); 
omega_0 = omega(indexMaxValPSD);
sigma = sqrt(maxValPSD);

K_w = 2*lambda*omega_0*sigma;

%% System matrices
A = [0 1 0 0 0;
     -omega_0^2, -2*lambda*omega_0, 0 0 0;
     0 0 0 1 0;
     0 0 0 -1/T, -K/T;
     0 0 0 0 0];
B = [0;0;0;K/T;0];
C = [0 1 1 0 0];

%% Observability without disturbances
A_b = [0 1;
       0 -1/T];
C_b = [1 0];
O_b = obsv(A_b,C_b)         
rank(O_b)                   %shows full rank

%% Observability with the current disturbance
A_c = [0 1 0;
       0 -1/T -K/T;
       0 0 0];
C_c = [1 0 0];
O_c = obsv(A_c,C_c)         
rank(O_c)                   %shows full rank

%% Observability with the wave disturbance
A_d = [0 1 0 0;
     -omega_0^2 -2*lambda*omega_0 0 0 ;
     0 0 0 1;
     0 0 0 -1/T];
C_d = [0 1 1 0];
O_d = obsv(A_d,C_d)         
rank(O_d)                   %shows full rank

%% Observability with both current- and wave disturbances
O_e = obsv(A,C)             
rank(O_e)                   %shows full rank






