function [aero_out]=HARV_aero(alpha);
%
%  purpose: m file to implement an aero table lookup for the harv data base.
%
%  usage:  [aero_out]=aero_lookup(alpha);
%
%  inputs:  alpha (deg)
%
%  outputs: aero_out - vector of aero lookup results (length=33)
%
%     here is the order (all derivatives per degree)
%
% (1) cy_b   ( 8) croll_b   (15) cn_b   (22) cd0    (26) clift0    (30) cm0
% (2) cy_p   ( 9) croll_p   (16) cn_p   (23) cd_q   (27) clift_q   (31) cm_q
% (3) cy_r   (10) croll_r   (17) cn_r   (24) cd_del (28) clift_del (32) cm_del
% (4) cy_da  (11) croll_da  (18) cn_da  (25) cd_der (29) clift_der (33) cm_der
% (5) cy_del (12) croll_del (19) cn_del
% (6) cy_der (13) croll_der (20) cn_der
% (7) cy_dr  (14) croll_dr  (21) cn_dr
%
%         
%    
% format:  [aero_out]=HARV_aero(alpha);
%
global ALPHA_BREAK
global AEROTABLE
alpha = max(min(alpha,90),-14);
aero_out = interp1(ALPHA_BREAK,AEROTABLE,alpha)';
