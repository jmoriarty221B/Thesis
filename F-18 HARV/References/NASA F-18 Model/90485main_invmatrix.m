function [out] = invmatrix(in);
%
%
% this routine creates the matrix
% of partial derivatives of cvdots to surfaces
%
% out(3,7) =  ail del der dr
%
% 
% initially, the in(52) vector will be a column vector 
% with the following order:
%
% surfaces
%
% in(1)  dal (aileron command deg)
% in(2)  del (left stab       deg)
% in(3)  der (right stab      deg)
% in(4)  dr  (rudder)
% in(5)  dl  (effective roll vectoring angle  deg)
% in(6)  dm  (effective pitch vectoring angle deg)
% in(7)  dn  (effective yaw vectoring angle   deg)
%
% states
%
% in(8)  p    (roll rate       deg/sec)
% in(9)  q    (pitch rate      deg/sec)
% in(10) r    (yaw rate        deg/sec)
% in(11) v    (true velocity   fps)
% in(12) alp  (angle of attack deg)
% in(13) bta  (sideslip        deg)
% in(14) qbar (dynamic press   psf)
% in(15) rho  (density         sl/ft3)
% in(16) T    (thrust          lbs)
% in(17) drag (drag from model lbs)
% in(18) tha  (pitch angle     deg)
% in(19) phi  (roll angle      deg)
%
%
% stability derivatives: (all per degree)
%
% in(20)    cd0
% in(21)    cd_q
% in(22)    cd_del
% in(23)    cd_der
%
% in(24)    clift0
% in(25)    clift_q
% in(26)    clift_del
% in(27)    clift_der
%
% in(28     cm0
% in(29)    cm_q
% in(30)    cm_del
% in(31)    cm_der
%
% in(32)    cy_bta
% in(33)    cy_p
% in(34)    cy_r
% in(35)    cy_dal
% in(36)    cy_del
% in(37)    cy_der
% in(38)    cy_dr
%
% in(39)      croll_bta
% in(40)      croll_p
% in(41)      croll_r
% in(42)      croll_dal
% in(43)      croll_del
% in(44)      croll_der
% in(45)      croll_dr
%
% in(46)      cn_bta
% in(47)      cn_p
% in(48)      cn_r
% in(49)      cn_dal
% in(50)      cn_del
% in(51)      cn_der
% in(52)      cn_dr
%
%
%
dtor = 1./57.3;
%
dal = in(1);  % surfaces: dal (aileron)
del = in(2);  %           del (left stab)
der = in(3);  %           der (right stab)
dr  = in(4);  %           dr  (rudder)
dl  = in(5);  %           dl  (effective roll vectoring angle  deg)
dm  = in(6);  %           dm  (effective pitch vectoring angle deg)
dn  = in(7);  %           dn  (effective yaw vectoring angle   deg)
%
%
%
p   = in(8) ; % states:   p    (roll rate       deg/sec)
q   = in(9) ; %           q    (pitch rate      deg/sec)
r   = in(10); %           r    (yaw rate        deg/sec)
v   = in(11); %           v    (true velocity   fps)
alp = in(12); %           alp  (angle of attack deg)
bta = in(13); %           bta  (sideslip        deg)
qbar= in(14); %           qbar (dynamic press   psf)
rho = in(15); %           rho  (density         sl/ft3)
T   = in(16); %           T    (thrust          lbs)
drag= in(17); %           drag (drag from model    )
tha = in(18); %           tha  (pitch angle     deg)
phi = in(19); %           phi  (roll angle      deg)
%
%
% stability derivatives:
%
cd0       = in(20);  %      cd0
cd_q      = in(21);  %      cd_q
cd_del    = in(22);  %      cd_del
cd_der    = in(23);  %      cd_der
%
clift0    = in(24);  %      clift0
clift_q   = in(25);  %      clift_q
clift_del = in(26);  %      clift_del
clift_der = in(27);  %      clift_der

cm0       = in(28);  %      cm0
cm_q      = in(29);  %      cm_q
cm_del    = in(30);  %      cm_del
cm_der    = in(31);  %      cm_der
%
cy_beta   = in(32);  %      cy_bta
cy_p      = in(33);  %      cy_p
cy_r      = in(34);  %      cy_r
cy_dal    = in(35);  %      cy_dal
cy_del    = in(36);  %      cy_del
cy_der    = in(37);  %      cy_der
cy_dr     = in(38);  %      cy_dr
%
croll_bta    = in(39);  %      croll_bta
croll_p      = in(40);  %      croll_p
croll_r      = in(41);  %      croll_r
croll_dal    = in(42);  %      croll_dal
croll_del    = in(43);  %      croll_del
croll_der    = in(44);  %      croll_der
croll_dr     = in(45);  %      croll_dr
%
cn_bta    = in(46);  %      cn_bta
cn_p      = in(47);  %      cn_p
cn_r      = in(48);  %      cn_r
cn_dal    = in(49);  %      cn_dal
cn_del    = in(50);  %      cn_del
cn_der    = in(51);  %      cn_der
cn_dr     = in(52);  %      cn_dr
%
%
%
% constants used in the subroutine
%
cbar       = 11.52;
b          = 37.4;
mass       = 1111.74;
g          = 32.17;
Ixx        = 22632.6;
Iyy        = 174246.3;
Izz        = 189336.4;
Ixz        = -2131.8;
S          = 400.;
lxt        = 18.17;
lyt        = 2.23;
xref       = .017*cbar;
zref       = -.449;
%
% calculate the total forces and moments
%
cd = cd0 + (cbar/2*v)*cd_q*q + cd_del*del + cd_der*der;
clift = clift0 + (cbar/2*v)*clift_q*q + clift_del*del + clift_der*der;
cm = cm0 + (cbar/2*v)*cm_q*q + cm_del*del + cm_der*der;
%
cy = cy_b*bta + (b/2*v)*cy_p*p + (b/2*v)*cy_r*r 
     + cy_dal*dal + cy_del*del + cy_der*der;
croll = croll_b*bta + (b/2*v)*croll_p*p + (b/2*v)*croll_r*r 
     + croll_dal*dal + croll_del*del + croll_der*der;
cn = cn_b*bta + (b/2*v)*cn_p*p + (b/2*v)*cn_r*r 
     + cn_dal*dal + cn_del*del + cn_der*der;
%
%
% convert all angular units to radians
% 
alp = alp*dtor;
bta = bta*dtor;
tha = tha*dtor;
phi = phi*dtor;
p   = p*dtor;
q   = q*dtor;
r   = r*dtor;
dl  = dl*dtor;
dm  = dm*dtor;
dn  = dn*dtor;
%
% calculate total moments
%
D = qbar*S*cd;
Y = qbar*S*cy;
L = qbar*S*clift;

laero = qbar*S*b*croll + zref*Y;

maero = qbar*S*cbar*cm - xref*( L*cos(alp) + D*sin(alp)) 
                       + zref*(-L*sin(alp) + D*cos(alp));

naero = qbar*S*b*cn - xref*Y;
%
%
%
%  now calculate pdot, qdot, rdot
%
%
% note: the inertial tensor has no yx or yz terms,
%       leading to simplified equations for 
%       pdot, qdot, and rdot
%
% the inversion of the inertial tensor leads to:
%
% inv(1,1) = Izz/(Ixx*Izz - Ixz^2)
%
inv11 = .000044231;
%
% inv(1,3) = Ixz/(Ixx*Izz - Ixz^2)
%
inv13 = -.000000498;
%
% (do we really need this?)
%
% inv(2,2) = 1/Iyy
%
inv22 = .000005739;
%
% inv(3,1) = Ixz/(Ixx*Izz - Ixz^2)
%
inv31 = -.000000498;
%
% inv(3,3) = Ixx/(Ixx*Izz - Ixz^2)
%
inv33 = .000005287
%
% (do we really need this?)
%
%
% now calculate pdot, qdot, and rdot
%
sinl = sin(dl);
cosl = cos(dl);
sinm = sin(dm);
cosm = cos(dm);
sinn = sin(dn);
cosn = cos(dn);
%
%
rhs1 = laero + Ixz*p*q + (Iyy - Izz)*q*r + T*ly*sinl;
rhs2 = maero + (Izz - Ixx)*p*r + Ixz*(-p^2 +r^2) - T*lx*sinm;
rhs3 = naero + (Ixx - Iyy)*p*q - Ixz*p*r - T*lx*sinn;
%
%
pdot = inv11*rhs1 + inv13*rhs3;
qdot = inv22*rhs2;
rdot = inv31*rhs3 + inv33*rhs3;
%
% calculate mu ,gamma
% 
sina = sin(alp);
cosa = cos(alp);
sinb = sin(bta);
cosb = cos(bta);
tanb = tan(bta);
sint = sin(tha);
cost = cos(tha);
sinp = sin(phi);
cosp = cos(phi);
%
%
num   = cosa*sinb*sint + cost*(cosb*sinp - sina*sinb*cosp);
den   = sina*sint + cosa*cosb*cosp;
mu    = atan(num/den);
num   = cosa*sinb*sint - cost*(cosb*sinp + sina*sinb*cosp);
gamma = asin(num);
%
%
sinmu = sin(mu);
cosmu = cos(mu);
singma= sin(gamma);
cosgma= cos(gamma);
%
% calculate thrust components
%
rollthr  = T*lyt*sinl;
pitthr   =-T*lxt*sinm;
yawthr   =-T*lxt*sinn;
%
%
Tn  = T - drag;
Fvt = Tn*(cosm*cosn*cosa*cosb + cosm*sinn*sinb 
                               - sinm*sina*cosb);
Fxt = Tn*(-sinm*(-cosmu*sina*sinb - sinmu*cosa)
          + cosm*cosn*(-cosmu*cosa*sinb + sinmu*cosa)
          + cosm*sinn*cosmu*cosb);
          
Fgmat = -Tn*(-sinm*(-sinmu*sina*sinb + cosmu*cosa) 
          + cosm*cosn*(-sinmu*cosa*sinb - cosmu*sina)
          + cosm*sinn*sinmu*cosb);
%
%  vdot, chidot, gammadot
%
vdot   = (1/mass)*(-D*cosb + Y*sinb) - g*singma + Fvt/mass;
tmp    = 1/mass*v*cosgma;
chidot = tmp*(-D*sinb*cosmu + L*sinmu + Y*cosb*cosmu + Fxt);
tmp    = 1/mass*v;
tmp2   = g*cosgma/v;
gmadot = tmp*(-D*sinb*sinmu* + L*cosmu - Y*cosb*sinmu) 
         - tmp2 + tmp*Fgmat;
%
%  mudot, alpdot, btadot
%
tmp    = (cosa/cosb)*p;
tmp2   = (sina/cosb)*r;
tmp3   = (tanb*cosmu)*gmadot;
tmp4   = (singma + tanb*sinmu*cosgma);
mud    = tmp + tmp1 + tmp2 + tmp3*chidot;
tmp    = -p*cosa*tanb; 
tmp2   = r*sina*tanb;
tmp3   = cosmu/cosb;
tmp4   = sinmu*(cosgma/cosb);
alpdot = tmp + q - tmp2 - tmp2 - tmp3*chidot;
tmp    = p*sina;
tmp2   = r*cosa;
tmp3   = sinmu*gmadoot;
tmp4   = cosmu*cosgma*chidot;
btadot = tmp - tmp2 - tmp3 + tmp4; 
%
% now calculate the cvdots
%
% note that SWcv = 2, Flon and Flat = const = 1
%
out = 0*ones(3);
%
lcvdot = cosa*pdot + sina*rdot
         + (r*cosa - p*sina)*alpdot;
%
% Kza = 2.33
%
Fza = 2.33*qbar;
Fzadot = 2.33*rho*v*vdot;
ps = p*cosa + r*sina;
rs = -p*sina + r*cosa;
tmp  = (Fza*alpdot + Fzadot*alp)/400.;
tmp2 = g/(v*cosb);
tmp3 = cosmu*singma*gmadot;
tmp4 = cosgma*sinmu*mud;
tmp5 = cosgma*cosmu*(vdot/v - tanb*btadot);
tmp6 = ps/(cosb*cosb*btadot);
tmp7 = tanb*(pdot*cosa + rdot*sina - rs*alpdot);
%
% Kv = .006
% Fpb = 1.
%
mcvdot = qdot + tmp 
         - tmp2*(tmp3 + tmp4 + tmp5)
         - tmp6 + tmp7 - .006*vdot;
%
% Kb = -2.5/171.*qbar
% kbdot = -2.5/171.*qbardot
%
%
Kb = -2.5/171.*qbar;
Kbdot = (-1.5/171.)*rho*v*vdot;
tmp  = cosa*rdot - sina*pdot;
tmp2 = ps*alpdot 
tmp3 = (g/(v*v))*vdot*cosgma*sinmu;
tmp4 = (g/v)*(gmadot*singma*sinmu - mud*cosgma*cosmu);
ncvdot = tmp - tmp2 + tmp3 - tmp4 
                          + Kb*btadot + bta*Kbdot;
%
%
%
out(1) = lcvdot;
out(2) = mcvdot;
out(3) = ncvdot;
%
% convert back to degrees
%
%
alp = alp/dtor;
bta = bta/dtor;
tha = tha/dtor;
phi = phi/dtor;
p = p/dtor;
q = q/dtor;
r = r/dtor;
dl = dl/dtor;
dm = dm/dtor;
dn = dn/dtor;
