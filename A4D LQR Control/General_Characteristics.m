%Data For Fighter Aircraft A4D%
%Longitudinal
C_L0=0.28;
C_D0=0.03;
C_Lalpha=3.45;
C_Dalpha=0.30;
C_Malpha=-0.38;
C_Malpha_dot=-1.1;
C_M_q=-3.6;
C_LdeltaE=0.36;
C_MdeltaE=-0.50;
%Lateral
C_yBeta=-0.98;
C_lBeta=-0.12;
C_nBeta=0.25;
C_lp=-0.26;
C_np=0.022;
C_lr=0.14;
C_nr=-0.35;
C_lDelta_a=0.08;
C_nDelta_a=0.06;
C_yDelta_r=0.17;
C_lDelta_r=-0.105;
C_nDelta_r=0.032;
%General Characteristics
M=0.4;
u=136.116;
W=78190.84;
g=9.8;
m=W/g;
s=24.155;
b=8.382;
c_mean=3.292;
rho=1.225;
I_x=10968.567;
I_y=35115.685;
I_z=39589.884;
I_xz=1762.563;
Q=0.5*rho*u*u;
% longitudinal(C_L0, C_D0, C_Lalpha, C_Dalpha, C_Malpha, C_Malpha_dot, C_M_q, C_LdeltaE, C_MdeltaE, M, u, W, g, m, s, b, c_mean, rho, I_x, I_y, I_z, I_xz, Q);
[A, B, C, D, Kgain]=lateral(C_yBeta, C_lBeta, C_nBeta, C_lp, C_np, C_lr, C_nr, C_lDelta_a, C_nDelta_a, C_yDelta_r, C_lDelta_r, C_nDelta_r, M, u, W, g, m, s, b, c_mean, rho, I_x, I_y, I_z, I_xz, Q);

