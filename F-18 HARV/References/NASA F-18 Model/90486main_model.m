function [out] = model(in);
%
%
% this routine calculates lcvdot, mcvdot, ncvdot
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
% in(17) Tn   (net thrust      lbs)
% in(18) tha  (pitch angle     deg)
% in(19) phi  (roll angle      deg)
%
%
% stability derivatives: (all per degree)
%
% in(20)    cy_b
% in(21)    cy_p
% in(22)    cy_r
% in(23)    cy_dal
% in(24)    cy_del
% in(25)    cy_der
% in(26)    cy_dr
%
% in(27)      croll_b
% in(28)      croll_p
% in(29)      croll_r
% in(30)      croll_dal
% in(31)      croll_del
% in(32)      croll_der
% in(33)      croll_dr
%
% in(34)      cn_b
% in(35)      cn_p
% in(36)      cn_r
% in(37)      cn_dal
% in(38)      cn_del
% in(39)      cn_der
% in(40)      cn_dr
%
% in(41)    cd0
% in(42)    cd_q
% in(43)    cd_del
% in(44)    cd_der
%
% in(45)    clift0
% in(46)    clift_q
% in(47)    clift_del
% in(48)    clift_der
%
% in(49     cm0
% in(50)    cm_q
% in(51)    cm_del
% in(52)    cm_der
%
%
dtor = pi/180;
%
dal = in(1);
del = in(2);
der = in(3);
dr  = in(4);
dl  = in(5);
dm  = in(6);
dn  = in(7);
%
%
%
p   = in(8); 
q   = in(9); 
r   = in(10);
v   = in(11);
alp = in(12);
bta = in(13);
qbar= in(14);
rho = in(15);
T   = in(16);
Tn  = in(17);
tha = in(18);
phi = in(19);
%
%
%
cy_b      = in(20);
cy_p      = in(21);
cy_r      = in(22);
cy_dal    = in(23);
cy_del    = in(24);
cy_der    = in(25);
cy_dr     = in(26);
%
croll_b      = in(27);
croll_p      = in(28);
croll_r      = in(29);
croll_dal    = in(30);
croll_del    = in(31);
croll_der    = in(32);
croll_dr     = in(33);
%
cn_b      = in(34);
cn_p      = in(35);
cn_r      = in(36);
cn_dal    = in(37);
cn_del    = in(38);
cn_der    = in(39);
cn_dr     = in(40);
%
cd0       = in(41);
cd_q      = in(42);
cd_del    = in(43);
cd_der    = in(44);
%
clift0    = in(45);
clift_q   = in(46);
clift_del = in(47);
clift_der = in(48);

cm0       = in(49);
cm_q      = in(50);
cm_del    = in(51);
cm_der    = in(52);
%
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

cd = cd0 + (cbar/(2*v))*cd_q*q + cd_del*del + cd_der*der;

clift = clift0 + (cbar/(2*v))*clift_q*q + clift_del*del + clift_der*der;

cm = cm0 + (cbar/(2*v))*cm_q*q + cm_del*del + cm_der*der;
%
cy = cy_b*bta + (b/(2*v))*cy_p*p + (b/(2*v))*cy_r*r ... 
     + cy_dal*dal + cy_del*del + cy_der*der + cy_dr*dr;
 
croll = croll_b*bta + (b/(2*v))*croll_p*p + (b/(2*v))*croll_r*r ... 
     + croll_dal*dal + croll_del*del + croll_der*der + croll_dr*dr;


cn = cn_b*bta + (b/(2*v))*cn_p*p + (b/(2*v))*cn_r*r ...
     + cn_dal*dal + cn_del*del + cn_der*der + cn_dr*dr;
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

maero = qbar*S*cbar*cm - xref*( L*cos(alp) + D*sin(alp)) ... 
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
inv33 = .000005287;
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
rhs1 = laero + Ixz*p*q + (Iyy - Izz)*q*r + T*lyt*sinl;
rhs2 = maero + (Izz - Ixx)*p*r + Ixz*(-p^2 +r^2) - T*lxt*sinm;
rhs3 = naero + (Ixx - Iyy)*p*q - Ixz*p*r - T*lxt*sinn;
%
%
pdot = inv11*rhs1 + inv13*rhs3;
qdot = inv22*rhs2;
rdot = inv31*rhs1 + inv33*rhs3;
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
den   = sina*sint + cosa*cosp*cost;
mua   = atan2(num,den);
num   = cosa*cosb*sint - cost*(sinb*sinp + sina*cosb*cosp);
gammaa = asin(num);
%
%
sinmu = sin(mua);
cosmu = cos(mua);
singma= sin(gammaa);
cosgma= cos(gammaa);
%
%
%
Fvt = Tn*(cosm*cosn*cosa*cosb + cosm*sinn*sinb        ...
                               - sinm*sina*cosb);
                           
Fxt = Tn*(-sinm*(-cosmu*sina*sinb - sinmu*cosa)       ...
          + cosm*cosn*(-cosmu*cosa*sinb + sinmu*sina) ...
          + cosm*sinn*cosmu*cosb);

          
Fgmat = -Tn*(-sinm*(-sinmu*sina*sinb + cosmu*cosa)    ...
          + cosm*cosn*(-sinmu*cosa*sinb - cosmu*sina) ...
          + cosm*sinn*sinmu*cosb);
%
%  vdot, chidot, gammadot
%

vdot   = (1/mass)*(-D*cosb + Y*sinb) - g*singma + Fvt/mass;
tmp    = 1/(mass*v*cosgma);
chidot = tmp*(D*sinb*cosmu + L*sinmu + Y*cosb*cosmu + Fxt);
tmp    = 1/(mass*v);
tmp2   = (g*cosgma)/v;
gmadot = tmp*(-D*sinb*sinmu + L*cosmu - Y*cosb*sinmu) ...
         - tmp2 + tmp*Fgmat;
%
%  mudot, alpdot, btadot
%
tmp    = (cosa/cosb)*p;
tmp2   = (sina/cosb)*r;
tmp3   = (tanb*cosmu)*gmadot;
tmp4   = (singma + tanb*sinmu*cosgma);
mud    = tmp + tmp2 + tmp3 + tmp4*chidot;
tmp    = -p*cosa*tanb; 
tmp2   = r*sina*tanb;
tmp3   = cosmu/cosb;
tmp4   = sinmu*(cosgma/cosb);
alpdot = tmp + q - tmp2 - tmp3*gmadot - tmp4*chidot;
tmp    = p*sina;
tmp2   = r*cosa;
tmp3   = sinmu*gmadot;
tmp4   = cosmu*cosgma*chidot;
btadot = tmp - tmp2 - tmp3 + tmp4;
%
% now calculate the cvdots
%
% note that SWcv = 2, Flon and Flat = const = 1
%
%
lcvdot = cosa*pdot + sina*rdot          ...
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
tmp6 = ps*btadot/(cosb*cosb);
tmp7 = tanb*(pdot*cosa + rdot*sina + rs*alpdot);
%
% Kv = .0006
% Fpb = 1.
%
mcvdot = qdot + tmp                   ...
         - tmp2*(tmp3 + tmp4 + tmp5)  ...
         - (tmp6 + tmp7) - .0006*vdot;

%
% Kb = -2.5/171.*qbar
% kbdot = -2.5/171.*qbardot
%
%
Kb = -2.5/171.*qbar;
Kbdot = (-2.5/171.)*rho*v*vdot;
tmp  = cosa*rdot - sina*pdot;
tmp2 = ps*alpdot;
tmp3 = (g/(v*v))*vdot*cosgma*sinmu;
tmp4 = (g/v)*(gmadot*singma*sinmu - mud*cosgma*cosmu);
ncvdot = tmp - tmp2 + tmp3 + tmp4            ...
          + Kb*btadot + Kbdot*bta;
%
%
out = 0*ones(3,1);
out(1) = lcvdot; 
out(2) = mcvdot;
out(3) = mcvdot;
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






