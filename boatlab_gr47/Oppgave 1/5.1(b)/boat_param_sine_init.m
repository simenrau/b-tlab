clear all
close all
clc

%% Loading previously generated data
load('boat_param1_sine');     %frequency 0.005
load('boat_param2_sine');     %frequency 0.05

%% Plotting
figure
subplot(2,1,1)
plot(boat_param1(:,1), boat_param1(:,2), 'LineWidth', 1); grid on; 
title('Sine input with \omega_1 = 0.005 and zero disturbances')
xlabel('Time [s]')
ylabel('sin(\omega_1t) [deg]')

subplot(2,1,2)
plot(boat_param2(:,1), boat_param2(:,2), 'LineWidth', 1); grid on;
title('Sine input with \omega_2 = 0.05 and zero disturbances')
xlabel('Time [s]')
ylabel('sin(\omega_2t) [deg]')
