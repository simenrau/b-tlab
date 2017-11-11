clear all
close all
clc

%% Precalculated variables
A1 = 29.500;
A2 = 1.50;
w1 = 0.005;
w2 = 0.05;

T = sqrt(((A2*w2)^2-(A1*w1)^2)/(A1^2*w1^4-A2^2*w2^4));
K = A1*w1*sqrt(T^2*w1^2+1);

%% Run simulink-file
sim('boat_param_step')

%% Plotting comparison between model and ship
figure
plot(boat_param_step_ship(:,1), boat_param_step_ship(:,2), 'LineWidth', 1); hold on;
plot(boat_param_step_model(:,1), boat_param_step_model(:,2), 'LineWidth', 1); grid on; 
xlabel('Time [sec]')    
ylabel('Amplitude [deg]')           %Tror dette stemmer
legend('Ship','Model','Location','Northwest')
title('Comparing step respons of model with step respons of ship')



