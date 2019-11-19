k = 0.0975;
CD0 = 0.0307
CLmax = 1.7772
CLm = 1.4913
T = 71171.546
Em = 9.1451
V = 112.3193
n = 2.6576
phi = acos(1/n)
beta = 0;
r2d = 180/pi;
alpha = 20.8/r2d;
theta = alpha;
% syms theta
gamma = alpha-theta;
lookup = aero_lookup(alpha*r2d);

R = V^2*cos(gamma)/(g*tan(phi))
p = -V/R*(sin(theta))
q = V/R*(sin(phi)*cos(theta))
r = V/R*(cos(phi)*cos(theta))

% Croll = r2d*(lookup(8)*beta+lookup(9)*p+lookup(10)*r);
% Cyaw = r2d*(lookup(15)*beta+lookup(16)*p+lookup(17)*r);
% Q = 1/2*(1.225*V^2*S);
% L = b*Q*Croll;
% N = b*Q*Cyaw;
% M = c*Q*Cm
% theta = asin((1/(2*m*g))*(q*V*sin(alpha)))
Mtrx = r2d*[lookup(11) lookup(14); lookup(18) lookup(21)];
Cpr = inv(Mtrx)
CalcMtrx = [(-c2*p*q-c1*q*r)/(1/2*1.225*V^2*S*b)-(lookup(8)*r2d*beta+lookup(9)*r2d*p*b/2/V+lookup(10)*r2d*r*b/2/V);
    (c8*p*q+c2*q*r)/(1/2*1.225*V^2*S*b)-(lookup(15)*r2d*beta+lookup(16)*r2d*p*b/2/V+lookup(17)*r2d*r*b/2/V)];
delE = ((Ixz*(p^2-r^2)+(Ix-Iz)*p*r)/(1/2*1.225*V^2*S*cbar)-(lookup(30)+lookup(31)*r2d*q*cbar/2/V))/(lookup(32)*r2d+lookup(33)*r2d)
delT = 1
delAR = Cpr*CalcMtrx;
delA = delAR(1)
delR = delAR(2)