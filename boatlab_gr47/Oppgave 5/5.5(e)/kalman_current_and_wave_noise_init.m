clear all
close all
clc

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
lambda = 0.087;
K_w = 2*lambda*omega_0*sigma;

%% PD-controller
w_c = 0.1;
T_d = T;
T_f = 1/(w_c * tan(-130*(pi/180)));
K_pd = sqrt(w_c^2 + T_f^2 * w_c^4)/K;

%% System matrices
A = [0 1 0 0 0;
     -omega_0^2 -2*lambda*omega_0 0 0 0;
     0 0 0 1 0;
     0 0 0 -1/T -K/T;
     0 0 0 0 0];
B = [0;0;0;K/T;0];
C = [0 1 1 0 0];
D = 0;
E = [0 0; K_w 0;0 0;0 0;0 1];

%% Discretization
f = 10;     %frequency [Hz]
T_s = 1/f;  %sampling frequency (0.1 sec)

[A_d, B_d] = c2d(A,B,T_s);
[A_d, E_d] = c2d(A,E,T_s);
C_d = C;
D_d = D;

%% Kalman-filter variables
P_0_minus=[1 0 0 0 0;
           0 0.013 0 0 0;
           0 0 pi^2 0 0;
           0 0 0 1 0;
           0 0 0 0 2.5e-3];
       
x_0_minus = [0; 0; 0; 0; 0];
Q = [30 0;0 1e-6];
I = eye(5);
R = (6.1614e-7)/T_s;

% struct for Kalman filter
m = struct('A', A_d, 'B', B_d, 'C', C_d, 'D', D, 'E', E_d,'Q' , Q, 'R', R, 'P_0',P_0_minus, 'x_0', x_0_minus, 'I', I);  

%% Simulating
sim('kalman_current_and_wave_noise');

%% Plotting
load('PD_wave_disturbances.mat');

figure
subplot(2,1,1)
plot(kalman_current_and_wave_noise(:,1),kalman_current_and_wave_noise(:,2), 'r','LineWidth',1); hold on;
plot(kalman_current_and_wave_noise(:,1),kalman_current_and_wave_noise(:,3), 'Color',[0 0.75 0.75],'LineWidth',1); hold on;
plot(kalman_current_and_wave_noise(:,1),kalman_current_and_wave_noise(:,4), 'b','LineWidth',1); grid on;
title('Current and wave disturbances with Kalman filter');
xlabel('Time [s]');
ylabel('Course angle [deg]');     %??????
legend('Reference','Rudder angle','Compass course');
axis([0 500 -20 50]);

subplot(2,1,2)
plot(PD_wave_disturbances(:,1),PD_wave_disturbances(:,2), 'r','LineWidth',1); hold on;
plot(PD_wave_disturbances(:,1),PD_wave_disturbances(:,3), 'Color',[0 0.75 0.75],'LineWidth',1); hold on;
plot(PD_wave_disturbances(:,1),PD_wave_disturbances(:,4), 'b','LineWidth',1); grid on;
title('Current and wave disturbances without Kalman filter');
xlabel('Time [s]');
ylabel('Course angle [deg]');     %??????
legend('Reference','Rudder angle','Compass course');
axis([0 500 -20 50]);   










