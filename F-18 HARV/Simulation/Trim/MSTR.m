r2d=180/pi;
k = 0.0975;
CD0 = 0.0307
CLmax = 1.7772
Vstall = m*g/(0.5*1.225*S*CLmax)
e = 0.9129;
rho = 1.225;
alpha = 20.8/r2d; 
theta = alpha;
n = 2.6576
phi = acos(1/n);
T = 71171.546
V = 112.3193
nmax = n;
CLm = 1.4913
omega = g/V*(sqrt(n^2-1))

model = 'HARV_6DoF_trim_mdl';
opspec = operspec(model);

opspec.States.Known = [0 0 1 0 0 0 0 0 0 0 0 0]';
opspec.States.SteadyState = [1 1 1 1 1 1 0 1 1 0 0 1]';
opspec.States.x = [V alpha 0 -0.0763 0.1861 0.0756 0 theta phi 0 0 0]';
opspec.States.Min = [0 -22/14 -22/14 -500 -500 -500 -22/14 -22/14 -22/14 -1e10 -1e10 -1e10]'; 
opspec.States.Max = [400 22/14 22/14 500 500 500 22/14 22/14 22/14 1e10 1e10 1e10]';

opspec.Inputs.Known = [0 0 0 0 1]';
% opspec.Inputs.Min = [-24/r2d -24/r2d -25/r2d -30/r2d 0]';
% opspec.Inputs.Max = [10.5/r2d 10.5/r2d 25/r2d 30/r2d 1]';
% opspec.Inputs.u = [0 0 0 0 1]';
opspec.Inputs.Min = [-pi/2 -pi/2 -pi/2 -pi/2 0]';
opspec.Inputs.Max = [pi/2 pi/2 pi/2 pi/2 1]';
opspec.Inputs.u = [-1.0215 -1.0215 -0.0428 -0.0125 1]';

op3 = findop(model,opspec);