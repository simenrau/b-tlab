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
sim('p5p3b');

%% Plotting
figure
plot(PD_measurement_noise(:,1),PD_measurement_noise(:,2),'r','LineWidth', 1); hold on;
plot(PD_measurement_noise(:,1),PD_measurement_noise(:,3),'Color',[0 0.75 0.75],'LineWidth', 1); hold on;
plot(PD_measurement_noise(:,1),PD_measurement_noise(:,4),'b','LineWidth', 1); grid on;
title('Measurement noise with PD-regulator');
xlabel('Time [s]');
ylabel('Angle [deg]');
legend('Reference','Rudder angle','Compass course');
axis([0 500 -20 50]);



