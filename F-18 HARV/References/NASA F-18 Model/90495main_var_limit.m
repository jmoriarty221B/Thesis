function out=var_limit(in);
%
% m file to implement a limiter with variable upper and lower limits
%
%  inputs:  in - signal
%                lower limit
%                upper limit
%
%  outputs: out - limited signal
%
% 
%

sig=in(1);
ll=in(2);
ul=in(3);
%
out=min(max(sig,ll),ul);
