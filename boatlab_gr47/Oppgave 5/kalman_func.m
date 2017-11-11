function [psi, b] = kalman_func(u, y, m)

persistent init_flag A B C D E Q R P_minus x_minus I

if isempty(init_flag)
init_flag=1;

A = m.A;
B = m.B;
C = m.C;
D = m.D; 
E = m.E;
Q = m.Q;
R = m.R;
P_minus = m.P_0;
x_minus = m.x_0;
I = m.I;
end

L = P_minus*C'*(C*P_minus*C' + R)^-1;
P = (I - L*C)*P_minus*(I - L*C)' + L*R*L';
x = x_minus + L*(y - C*x_minus);
x_minus = A*x + B*u;
P_minus = A*P*A' + E*Q*E';

psi = x(3); 
b = x(5);
end