%% Using a previous version of model_trim which includes quaternions
parameters_jd_m_g;
x0 = [15 0 0 0 0 0 1 0 0 0]';
u0 = [1050 -0.34 0.075 0.0545 0 m]';
y0 = [15 0 0 0 0 0 0 0 0 0 15]';
ix = (1:10)';
iu = [3 5 6]';
iy = [1:7 8 9 10 11]';
[x,u,y,dx,options] = trim('model_trim_prev',x0,u0,y0,ix,iu,iy);
save temp1.mat x u y dx options;

%% For a range of speeds (5, 10, 15, 20, 25, 30, 35, 40, 45)
% Using TBD
clear all; clc;
SpeedRange = (5:5:45).';
xVector = zeros(length(SpeedRange),6);
uVector = zeros(length(SpeedRange),14);
yVector = zeros(length(SpeedRange),6);
LongStabInfo = cell(length(SpeedRange),1);
LatStabInfo = cell(length(SpeedRange),1);
ControlInfo = cell(length(SpeedRange),1);
RestInfo = cell(length(SpeedRange),4);

phi0 = 0;
theta0 = 0;
y0 = [0 0 0 0 0 0]';
ix = (1:6)';
iu = [4 5 6 7 8 9 10 11 12 14]';
iy = (1:6)';

for i=1:length(SpeedRange)
    parameters_jd_m_g;
    U0 = SpeedRange(i,1);
    disp([U0 phi0 theta0]);
    x0 = [U0 0 0 0 0 0]';
    u0 = [1000*(U0/15)^2 -0.33798 0.075*U0/15 0 ...
        0.075 m U0 0 0 0 0 0 0 0]';
    [x,u,y,dx,options] = trim('model_trim',x0,u0,y0,ix,iu,iy);
    [A,B,C,D] = linmod('model_J',[x' 0 u(13)],u(1:4)');
    xVector(i,:) = x';
    uVector(i,:) = u';
    yVector(i,:) = y';
    LongStabInfo{i,1} = A([1 3 5 8],[1 3 5 8]);
    LatStabInfo{i,1} = A([2 4 6 7],[2 4 6 7]);
    ControlInfo{i,1} = B;
    RestInfo{i,1} = dx; RestInfo{i,2} = options;
    RestInfo{i,3} = C; RestInfo{i,4} = D;
    clearvars -except SpeedRange xVector uVector yVector ...
        LongStabInfo LatStabInfo ControlInfo RestInfo i phi0 theta0 y0 ix iu iy;
end
save TrimData_rangeofspeeds xVector uVector yVector LongStabInfo LatStabInfo ControlInfo RestInfo;

%% For airship speed equal to 15 m/s, using only model_trim_states
% Not successful
clear all; clc;
parameters_jd_m_g;
U0 = 15; phi0 = 0; theta0 = 0;
disp([U0 phi0 theta0]);
x0 = [U0 0 0 0 0 0 phi0 theta0]';
u0 = [1020 -0.34 0.061]';
y0 = [U0 0 0 0 0 0 phi0 theta0]';
ix = (1:8)';
iu = [];
iy = (1:8)';
[x,u,y,dx,options] = trim('model_trim_states',x0,u0,y0,ix,iu,iy);
[A,B,C,D] = linmod('model_trim_states',x,u);
save temp-15-SS.mat x u y dx options A B C D;

%% For airship speed equal to 15 m/s, using model_trim_accels and model_trim_states
clear all; clc;
parameters_f;
U0 = 45; phi0 = 0; theta0 = 0;
disp([U0 phi0 theta0]);
x0 = [U0 0 0 0 0 0]';
u0 = [1050 -0.34 0.065]';
u0 = [2 0 0]';
y0 = [0 0 0 0 0 0]';
ix = (1:6)';
iu = [];
iy = (1:6)';
[x,u,y,dx,options] = trim('model_trim_accels',x0,u0,y0,ix,iu,iy);
[A,B,C,D] = linmod('model_trim_states',[x' phi0 theta0],u');
save V45-AS-TrimJ-parf.mat x u y dx options A B C D;

%% For airship speed equal to 15 m/s, using model_trim_FnMs and model_trim_states
% The attempt with model_rhs_solve was not successful.
clear all; clc;
parameters_jd_m_g;
U0 = 15; phi0 = 0; theta0 = 0;
x0 = 0;
u0 = [1050 -0.34 0.065]';
y0 = [0 0 0 0 0 0]';
ix = 1;
iu = [];
iy = (1:6)';
[x,u,y,dx,options] = trim('model_trim_FnMs',x0,u0,y0,ix,iu,iy);
[A,B,C,D] = linmod('model_trim_states',[U0 0 0 0 0 0 phi0 theta0],u');
save temp-15-RS.mat x u y dx options A B C D;
