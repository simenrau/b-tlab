clear all
close all
clc

%% Variables
w1 = 0.005;
w2 = 0.05;
A1 = 29.359;
A2 = 0.831;
A1_noise = 29.500;
A2_noise = 1.50;

% Boat parameters
T = sqrt(((A2*w2)^2-(A1*w1)^2)/(A1^2*w1^4-A2^2*w2^4));
K = A1*w1*sqrt(T^2*w1^2+1);
T_noise = sqrt(((A2_noise*w2)^2-(A1_noise*w1)^2)/(A1_noise^2*w1^4-A2_noise^2*w2^4));
K_noise = A1_noise*w1*sqrt(T_noise^2*w1^2+1);

%% Running simulink file
sim('p5p1d')

%% Plotting comparison between model and ship
figure
plot(boat_param_step_ship(:,1), boat_param_step_ship(:,2), 'LineWidth', 1); hold on;
plot(boat_param_step_model(:,1), boat_param_step_model(:,2), 'LineWidth', 1); hold on; 
plot(boat_param_step_model_noise(:,1), boat_param_step_model_noise(:,2),'--','LineWidth', 1); grid on; 
xlabel('Time [s]')    
ylabel('Amplitude [deg]')
legend('Ship','Model','Model with noise','Location','Northwest')
title('Comparing step respons of ship with step response of model')



