r2d = 180/pi;
alpha = 0.1; %Initial Guess
phi = 1.0472; %Fixed
Beta = 0 %Fixed
theta = alpha;
W = m*g;
L = W/cos(phi);
Thrust_max = 71171.546;
el = 0.1;
er = 0.1;
aero_out = aero_lookup(0.01*r2d);
CD0 = aero_out(22);
CD_q = aero_out(23)*r2d;
CD_del = aero_out(24)*r2d;
CD_der = aero_out(25)*r2d;

CL0 = aero_out(26);
CL_q = aero_out(27)*r2d;
CL_del = aero_out(28)*r2d;
CL_der = aero_out(29)*r2d;

qdynS = L/(CL0 + CL_del*el + CL_der*er)
V = sqrt(qdynS/(1/2*1.225*S)) %Fixed

D = qdynS*(CD0 + CD_del*el + CD_der*er);
T = D;
eta = T/Thrust_max;

model = 'HARV_6DoF_turn_mdl';
opspec = operspec(model);

opspec.States.Known = [0 1 1 0 0 0 0 0 1 0 0 0]';
opspec.States.SteadyState = [1 1 1 1 1 1 0 1 1 0 0 1]';
opspec.States.x = [V alpha 0 0 0 0 0 theta phi 0 0 0]';
opspec.States.Min = [0 -22/14 -22/14 -500 -500 -500 -22/14 -22/14 -22/14 -1e10 -1e10 -1e10]'; 
opspec.States.Max = [200 22/14 22/14 500 500 500 22/14 22/14 22/14 1e10 1e10 1e10]';

opspec.Inputs.Known = [0 0 0 0 0]';
opspec.Inputs.Min = [-22/14 -22/14 -22/14 -22/14 0]';
opspec.Inputs.Max = [22/14 22/14 22/14 22/14 8]';
opspec.Inputs.u = [0.1 0.1 0 0 eta]';

op1 = findop(model,opspec);