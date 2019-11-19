gdload('NASA2.13B_HIL_1_BAT');
T=time-time(1);
t=T;
g=32.174;
Ix=22632.6;Iy=174246.3;Iz=189336.4;Ixz=-2138.8;
S=400;cbar=11.52;qdot_tot=.05;
roll_stick=g24_20_/10000;
LCVcmd_ll=g24_21_/10000;
LCVcmd_ul=g24_22_/10000;
alpha_rad=g24_23_/10000.;
roll_trim=(180/pi)*g24_24_/10000;

p_rps=g24_25_/10000;
q_rps=g24_26_/10000;
r_rps=g24_27_/10000;

mom_eq_limit=g24_28_/10000;
alpdot_rps=g24_29_/10000;
pitch_stick=g24_30_/10000;
pitch_trim=(180/pi)*g24_31_/10000;

qbar=g24_19_/10000.;

g_thrust=g24_32_/10000;
true_velocity=g24_33_/10000;;

mu_rad=g24_34_/10000;
gamma_rad=g24_35_/10000;
beta_rad=g24_36_/10000;;
rudder_pedal=g24_37_/10000;
yaw_trim=g24_38_/10000;
lateral_accel=g24_39_/10000;

LCVCMD=g24_40_/10000;
MCVCMD=g24_41_/10000;
NCVCMD=g24_42_/10000;

LCV=g24_43_/10000;
MCV=g24_44_/10000;
NCV=g24_45_/10000;

LCV_dot_des=g24_160_/10000.;
MCV_dot_des=g24_161_/10000.;
NCV_dot_des=g24_162_/10000.;

LCV_dot_0=g24_163_/10000.;
MCV_dot_0=g24_164_/10000.;
NCV_dot_0=g24_165_/10000.;

LCVERRDOT=LCV_dot_des-LCV_dot_0;
MCVERRDOT=MCV_dot_des-MCV_dot_0;
NCVERRDOT=NCV_dot_des-NCV_dot_0;

LCV_err_aw=-g24_166_/10000.;
MCV_err_aw=-g24_167_/10000.;
NCV_err_aw=-g24_168_/10000.;

Kb=5.0;Ki=6.25;Kf=0.5;

alp_tlu = (180/pi)*g24_169_/10000.;

dal      = g24_130_/10000.;
del      = g24_131_/10000.;
der      = g24_132_/10000.;
dr       = g24_133_/10000.;
dn       = g24_136_/10000.;
dm       = g24_135_/10000.;
dl       = g24_134_/10000.;
p_new    = g24_137_/10000.;
q_new    = g24_138_/10000.;
r_new    = g24_139_/10000.;
v        = g24_140_/10000.;
alp_new  = g24_141_/10000.;
bta_new  = g24_142_/10000.;
qbar     = g24_143_/10000.;
rho      = g24_144_/1000000.;
Tg       = g24_145_/10000.;
Tn       = g24_146_/10000.;
tha_rad  = g24_151_/10000.;
phi_rad  = g24_150_/10000.;
invect = [dal del der dr dl dm dn p_new q_new r_new v alp_new bta_new qbar ...
           rho Tg  Tn tha_rad phi_rad]; 

global ALPHA_BREAK;
global AEROTABLE;

aerodata;

num_mu=cos(alpha_rad).*sin(beta_rad).*sin(tha_rad)+...
   cos(tha_rad).*(cos(beta_rad).*sin(phi_rad)-sin(alpha_rad).*sin(beta_rad).*cos(phi_rad));
num_gamma=cos(alpha_rad).*cos(beta_rad).*sin(tha_rad)-...
   cos(tha_rad).*(sin(beta_rad).*sin(phi_rad)+sin(alpha_rad).*cos(beta_rad).*cos(phi_rad));
den_mu=sin(alpha_rad).*sin(tha_rad)+cos(alpha_rad).*cos(phi_rad).*cos(tha_rad);

mu_term=num_mu ./den_mu;
cos_mu1=sign(den_mu) ./(sqrt(1+mu_term.^2));
sin_mu1=mu_term .* cos_mu1;
sin_gamma1= num_gamma;
cos_gamma1= sqrt(1-sin_gamma1.^2);













