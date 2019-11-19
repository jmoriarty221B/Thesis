% clear all; clc;
%% An airship design with a fineness ratio of 4

% Dimensions
b = 30;
c = b;
a1 = 80;
a2 = 160;
a = (a1+a2)/2;
Lh = a1+a2;
xCV = a1 + 3*(a2-a1)/8;
% Aerodynamics
% Drag
CDho = 0.025; % ok
CDfo = 0.006; % ok; 25% of hull drag
CDgo = 0.01;
CDch = 0.252;
CDcf = 2.91;
CDcg = 1;
% Lift
cl_alphaf = 2.3696;
cl_deltaf = 1.24; % Where do we get this from?
% Geometry
Vol = 4*pi*a*b*c/3;
Sh = Vol^(2/3);
Sf = Sh*0.5;
Sg = 202;
df1 = 0.96*Lh - xCV; % From CV, which is the origin in my case
df2 = 1.014*Lh - xCV;
df3 = 16;
dgx = -2.05;
dgz = 33;
% dh = 188.63; % This is defined from the airship nose!
% Hull-Fin interference
etaf = 0.6092;
etah = 1.15;
Ione = 0.146;
Ithree = -0.1912;
Jone = 1.80;
Jtwo = 0.79;
% I1 = 0.33;
% I3 = -0.69;
% J1 = 1.31;
% J2 = 0.53;
% Damping derivatives
CZq = -2;
CYr = -2;
CMq = -1;
CNr = -1;

% Atmosphere
% Mean sea level conditions
P0 = 101.325;
T0 = 15;
a0 = 340.294;
g0 = 9.80665;
d0 = 1.225;
h0 = 0;
R = 287.04;
% Tropopause
lambdat = -6.5;
Tt = -56.5;
pt = 22.632;
ht = 11;
% Between lower and upper stratosphere
Ts = -56.5;
ps = 5.4749;
lambdas = 1;
hs = 20;

% Bouyancy and Gravity
% Acceleration due to gravity
g = g0;
% Mass of fluid displaced
rho = 0.075;
% 0.075 (high altitude, 21000 m)
% 0.5 (8425 m)
% d0 (sea level)
vol = 4*pi*a*b*c/3;
m_de = rho*vol;
% CG and CB positions
bx = 0;
bz = 0;
az = 8;
ax = 0;

% Coriolis and Centrifugal

% Equations of Motion
% Lower off-diagonal terms of Mass and Inertia Matrix, Ma
Lvdot = 0; % These have to be corrected back in the EoM model
Mudot = 0;
Mwdot = 0;
Nvdot = 0;
% Upper off-diagonal terms of Mass and Inertia Matrix, Ma
Xqdot = 0;
Ypdot = 0;
Yrdot = 0;
Zqdot = 0;

% Inertia Coefficients

% Mass and Inertia
% Mass
m = m_de;
% Moment of Inertia
Ix = 15268140;
Iy = 65178400;
Iz = 49179000;
% Product of Inertia
Izx = 31808625;
% Added moment of inertia in roll
Lpdot = 0; % This has to be corrected back in the Mass and Inertia model
% Added product of inertia
Lrdot = 0; % This has to be corrected back in the Mass and Inertia model
Npdot = 0;

% Propulsive F&M
d_x = 4;
d_y = 5*b/4; % Isn't this from the CV?
d_z = 5*b/4;

load AnalytTrim_V15_f.mat;
% Initial conditions
lat0 = 0;
long0 = 0;
x0 = 0;
y0 = 0;
z0 = 21000;
u0 = 15;
v0 = 0;
w0 = 0;
p0 = 0;
q0 = 0;
r0 = 0;
phi0 = 0;
theta0 = 0;
psi0 = 0;
q0i = cos(phi0/2)*cos(theta0/2)*cos(psi0/2) + sin(phi0/2)*sin(theta0/2)*sin(psi0/2);
q1i = sin(phi0/2)*cos(theta0/2)*cos(psi0/2) - cos(phi0/2)*sin(theta0/2)*sin(psi0/2);
q2i = cos(phi0/2)*sin(theta0/2)*cos(psi0/2) + sin(phi0/2)*cos(theta0/2)*sin(psi0/2);
q3i = cos(phi0/2)*cos(theta0/2)*sin(psi0/2) - sin(phi0/2)*sin(theta0/2)*cos(psi0/2);
