% V = 58; alpha = 0.50; beta = 0;
% x = [V alpha beta 0 0 0 0 0 0 0 0 0]';
% u = [-0.1; -0.1; 0; 0; 0.9]';
% y = [V alpha beta 0 0 0 0 0 0 0 0 0]';
% ix = [];
% iu = [];
% iy = (1:12)';
model = 'HARV_6DoF_trim_mdl';
% [x,u,y,dx] = trim(model,x,u,y,ix,iu,iy);
opspec = operspec(model);

opspec.States.Known = [1 0 1 1 1 1 1 1 1 0 1 0]';
opspec.States.SteadyState = [1 1 1 1 1 1 1 1 1 0 1 1]';
opspec.States.x = [100 0.3 0 0 0 0 0 0.3 0 0 0 0]';
opspec.States.Min = [0 -22/14 -22/14 -500 -500 -500 -22/14 -22/14 -22/14 -1e10 -1e10 -1e10]'; 
opspec.States.Max = [200 22/14 22/14 500 500 500 22/14 22/14 22/14 1e10 1e10 1e10]';

opspec.Inputs.Min = [-22/14 -22/14 -22/14 -22/14 0]';
opspec.Inputs.Max = [22/14 22/14 22/14 22/14 1]';

op = findop(model,opspec);
% linear_model = linmod(model, op.States.x, op.Inputs.u);
% linear_model.a
% linear_model.b
% linear_model.c
% linear_model.d
