r2d = 180/pi;
rho = 1.225;
% alpha = 0.1;
phi = 1.0472; %Fixed
% theta = alpha;
% W = m*g;
n = 1/cos(phi);
Thrust_max = 71171.546;
% el = -.1;
% er = -.1;
% aero_out = aero_lookup(0.01*r2d);
% CD0 = aero_out(22);
% CD_q = aero_out(23)*r2d;
% CD_del = aero_out(24)*r2d;
% CD_der = aero_out(25)*r2d;
% 
% CL0 = aero_out(26);
% CL_q = aero_out(27)*r2d;
% CL_del = aero_out(28)*r2d;
% CL_der = aero_out(29)*r2d;
% CL = CL0 + CL_q*theta + CL_del*el + CL_der*er
% V = sqrt((2*n*W/S)/(rho*CL));
% beta = 0.001
% 
% D = 0.5*V^2*S*(CD0 + CD_q*theta + CD_del*el + CD_der*er);
% T = D;
% eta = T/Thrust_max;
% R = V^2/(g*(tan(phi)+T*sin(beta)/W))
V = 100
CL = 2*n*(m*g/S)/rho/V^2;
lookup = aero_lookup(0);
CD0 = lookup(22);
k = 0.0975;
CD = CD0 + k*CL^2;
D = 1/2*rho*V^2*S*CD;
T = D;
eta = T/Thrust_max;
model = 'HARV_6DoF_trim_mdl';
opspec = operspec(model);

opspec.States.Known = [1 0 1 0 0 0 0 0 1 0 0 0]';
opspec.States.SteadyState = [1 1 1 1 1 1 0 1 1 0 0 1]';
opspec.States.x = [V 0 0 0 0 0 0 0 phi 0 0 0]';
opspec.States.Min = [0 -22/14 -22/14 -500 -500 -500 -22/14 -22/14 -22/14 -1e10 -1e10 -1e10]'; 
opspec.States.Max = [200 22/14 22/14 500 500 500 22/14 22/14 22/14 1e10 1e10 1e10]';

opspec.Inputs.Known = [0 0 0 0 0]';
opspec.Inputs.Min = [-22/14 -22/14 -22/14 -22/14 0]';
opspec.Inputs.Max = [22/14 22/14 22/14 22/14 8]';
opspec.Inputs.u = [0.1 0.1 0 0 eta]';

op2 = findop(model,opspec);