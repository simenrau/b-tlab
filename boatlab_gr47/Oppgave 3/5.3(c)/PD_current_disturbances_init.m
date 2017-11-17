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
sim('PD_current_disturbances');

%% Plotting
figure
plot(PD_current_disturbances(:,1),PD_current_disturbances(:,2),'r','LineWidth', 1); hold on;
plot(PD_current_disturbances(:,1),PD_current_disturbances(:,3),'Color',[0 0.75 0.75],'LineWidth', 1); hold on;
plot(PD_current_disturbances(:,1),PD_current_disturbances(:,4),'b','LineWidth', 1); grid on;
title('Current disturbances with PD-regulator');
xlabel('Time [s]');
ylabel('Angle [deg]');     %??????
legend('Reference','Rudder angle','Compass course');
axis([0 500 -20 50]);



