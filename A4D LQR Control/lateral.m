function[A, B, C, D, K] = lateral(C_yBeta, C_lBeta, C_nBeta, C_lp, C_np, C_lr, C_nr, C_lDelta_a, C_nDelta_a, C_yDelta_r, C_lDelta_r, C_nDelta_r, M, u, W, g, m, s, b, c_mean, rho, I_x, I_y, I_z, I_xz, Q);
%Lateral Control 
Y_Beta=Q*s*C_yBeta/m;
N_Beta=Q*s*b*C_nBeta/I_z;
N_Beta1=N_Beta/(1-I_xz^2/(I_x*I_z));
L_Beta=Q*s*b*C_lBeta/I_x;
L_Beta1=L_Beta/(1-I_xz^2/(I_x*I_z));
Y_p=0;
L_p=Q*s*b^2*C_lp/(2*I_x*u);
L_p1=L_p/(1-I_xz^2/(I_x*I_z));
N_p=Q*s*b^2*C_np/(2*I_z*u);
N_p1=N_p/(1-I_xz^2/(I_x*I_z));
Y_r=0;
L_r=Q*s*b^2*C_lr/(2*I_x*u);
L_r1=L_r/(1-I_xz^2/(I_x*I_z));
N_r=Q*s*b^2*C_nr/(2*I_x*u);
N_r1=N_r/(1-I_xz^2/(I_x*I_z));
% Y_Delta_a=Q*s*C_yDelta_a/m;
N_Delta_a=Q*s*b*C_nDelta_a/I_z;
N_Delta_a1=N_Delta_a/(1-I_xz^2/(I_x*I_z));
L_Delta_a=Q*s*b*C_lDelta_a/I_x;
L_Delta_a1=L_Delta_a/(1-I_xz^2/(I_x*I_z));
Y_Delta_r=Q*s*C_yDelta_r/m;
N_Delta_r=Q*s*b*C_nDelta_r/I_z;
N_Delta_r1=N_Delta_r/(1-I_xz^2/(I_x*I_z));
L_Delta_r=Q*s*b*C_lDelta_r/I_x;
L_Delta_r1=L_Delta_r/(1-I_xz^2/(I_x*I_z));
%State-Space Form for Lateral Control
A=[Y_Beta/u Y_p/u -(1-Y_r/u) g*cos(0.0872)/u; 
   L_Beta1+I_xz/I_x*N_Beta1 L_p1+I_xz/I_x*N_p1 L_r1+I_xz/I_x*N_r1 0;
   N_Beta1+I_xz/I_z*L_Beta1 N_p1+I_xz/I_z*L_p1 N_r1+I_xz/I_z*L_r1 0;
   0 1 0 0]
B=[0 Y_Delta_r; 
   L_Delta_a1+I_xz/I_x*N_Delta_a1 L_Delta_r1+I_xz/I_x*N_Delta_r1;
   N_Delta_a1+I_xz/I_z*L_Delta_a1 N_Delta_r1+I_xz/I_z*L_Delta_r1;
   0 0]
C=[1 0 0 0; 0 0 0 1]
D=[0 0; 0 0]
states={'beta' 'roll rate' 'yaw rate' 'phi'};
inputs={'aileron' 'rudder'};
outputs={'sideslip angle' 'bank angle'};
%LQR Control
p=10;
Q=[ 10     0     0     0;
     0     0     0     0;
     0     0     0     0;
     0     0     0    10]
R=[1 0; 0 1];
[K]=lqr(A,B,Q,R)
% sys=ss(A,B,C,D);
% % H=tf(sys)
% % Nbar=rscale(A,B,C,D,K);
% sys_cl=ss(A-B*K,B, C, D,'statename',states,...
%     'inputname',inputs,...
%     'outputname',outputs);
% G=tf(sys_cl)
syms s;
% 
I=[1 0 0 0; 0 1 0 0; 0 0 1 0; 0 0 0 1];
C=I;
T=vpa(s*I-A+B*K,2)
vpa(det(T),2)
V=vpa(adjoint(T),2)

%BetatoRoll
P=vpa(C*V*B*K,2)
H=tf([0 -11 -52 -46 12],[1 31 333 1600 2400])
SP=1.0472; %input value, if you put 1 then is the same as step(sys)
[y,t]=step(SP*H); %get the response of the system to a step with amplitude SP
sserror=abs(0-y(end))

% impulseplot(sys_cl);
% title('Closed loop Step Response: LQR Control');