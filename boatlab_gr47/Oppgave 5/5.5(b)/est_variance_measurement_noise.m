close all
clear all

%% PSD estimation
load('wave.mat');

fs = 10;
window = 4096;
noverlap = [];
nfft = [];

[est_psd, f] = pwelch(psi_w(2,:).*(pi/180),window,noverlap,nfft,fs);    %psi_w is given in degrees (translates to radians)

est_psd = est_psd*(1/(2*pi));   %converting pxx [power per Hz] to pxx [(power*sec)/rad] 
omega = f.*(2*pi);      %converting f [Hz] to f [rad/s]

[maxValPSD, indexMaxValPSD] = max(est_psd);
omega_0 = omega(indexMaxValPSD);
sigma = sqrt(maxValPSD);

%% Precalculated variables
T = 72.442;
K = 0.156;
lambda = 0.085;
K_w = 2*lambda*omega_0*sigma;

%% System matrices

A = [0 1 0 0 0;
     -omega_0^2 -2*lambda*omega_0 0 0 0;
     0 0 0 1 0;
     0 0 0 -1/T -K/T;
     0 0 0 0 0];
B = [0;0;0;K/T;0];
C = [0 1 1 0 0];
D = 1;
E = [0 0; K_w 0;0 0;0 0;0 1];

%% Discretization
f = 10;
T_s = 1/f;
[A_d, B_d] = c2d(A,B,T_s);
[A_d, E_d] = c2d(A,E,T_s);
C_d = C;
D_d = D;

%% Estimating variance of the measurement noise
sim('measurement_noise');

variance = var(measurement_noise(:,2).*pi/180);







