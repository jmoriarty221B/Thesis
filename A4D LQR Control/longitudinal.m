function[] = longitudinal(C_L0, C_D0, C_Lalpha, C_Dalpha, C_Malpha, C_Malpha_dot, C_M_q, C_LdeltaE, C_MdeltaE, M, u, W, g, m, s, b, c_mean, rho, I_x, I_y, I_z, I_xz, Q);
X_u=-(2*C_D0)*Q*s/(u*m);
Z_u=-(2*C_L0)*Q*s/(u*m);
M_u=0;
X_w=-(C_Dalpha-C_L0)*Q*s/(u*m);
Z_w=-(C_Lalpha+C_D0)*Q*s/(u*m);
M_w=C_Malpha*Q*s*c_mean/(u*I_y);
X_w_dot=0;
Z_w_dot=0;
M_w_dot=C_Malpha_dot*c_mean/(2*u)*Q*s*c_mean/(u*I_y);
X_q=0;
Z_q=0;
Z_delta=-0.08;
M_q=C_M_q*c_mean/(2*u)*Q*s*c_mean/I_y;
M_delta=C_MdeltaE*Q*s*c_mean/(I_y);
M_wdot=C_Malpha_dot*c_mean/(2*u*u*I_y)*Q*s*c_mean;
%State-Space form for Longitudinal Control
A=[X_u  X_w 0 -g; Z_u Z_w u 0; M_u+M_w_dot*Z_u M_w+M_w_dot*Z_w M_q+M_w_dot*u 0; 0 0 1 0]
B=[0; 0; M_delta+M_wdot*Z_delta; 0]
C=[0 0 0 -1]
D=0
co=ctrb(A,B);
controllabilty=rank(co);
states={'X-velocity' 'Z-velocity' 'Pitch rate' 'Pitch Angle'};
% LQR Control
p=50;
Q=p*C'*C
R=10;
[K]=lqr(A,B,Q,R)
% Nbar=rscale(A,B,C,D,K)
% sys_cl=ss(A-B*K,B, C, D)
% t=0:0.1:10;
% step(0.2*sys_cl);
% ylabel('Pitch Angle(rad)');
% title('Closed loop Step Response: LQR Control');

