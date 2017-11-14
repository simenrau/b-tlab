clear all
close all
clc

%% Loading previously generated data
load('boat_param1_sine_noise');     %frequency 0.005
load('boat_param2_sine_noise');     %frequency 0.05

%% Plotting
figure
subplot(2,1,1)
plot(boat_param1_noise(:,1), boat_param1_noise(:,2), 'LineWidth', 1); grid on; 
title('Sine input with \omega_1 = 0.005, waves and noise turned on')
xlabel('Time [s]')
ylabel('sin(\omega_1t) [deg]')

subplot(2,1,2)
plot(boat_param2_noise(:,1), boat_param2_noise(:,2), 'LineWidth', 1); grid on;
title('Sine input with \omega_2 = 0.05, waves and noise turned on')
xlabel('Time [s]')
ylabel('sin(\omega_2t) [deg]')
