clear all
close all
clc

%% Ship model
T = 72.442;
K = 0.156;

%% PD-controller
w_c = 0.1;
T_d = T;
T_f = 1/(w_c * tan(-130*(pi/180)));
K_pd = sqrt(w_c^2 + T_f^2 * w_c^4)/K;

h_0 = tf(K*K_pd, [T_f 1 0]);

%% Simulating
sim('PD_wave_disturbances');

%% Plotting
time = PD_wave_disturbances(:,1);
reference = PD_wave_disturbances(:,2);
bias = PD_wave_disturbances(:,3);
psi = PD_wave_disturbances(:,4);

figure
plot(time,reference, 'r'); hold on;
plot(time, bias, 'g'); hold on;
plot(time, psi, 'b'); grid on;

title('Wave disturbances');
xlabel('Time [sec]');
ylabel('Degrees');




