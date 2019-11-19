gdload('NASA2.13B_HIL_1_BAT')
[m,n] = size(alp);
derivout = 0*ones(m,33);
%
derivout = aero_lookup(57.3*g24_169_/10000);
%
derivout = derivout';
