function [out]=pitch_shaping(in);
%
xtpitch = .6;
xmidpitch = 2.5;
xmaxpitch = 5.0;
%
 if abs(in) <= xtpitch
   den=4*xtpitch*xmidpitch - 2*xtpitch^2;
   out = xmidpitch*in*abs(in)/den;
 elseif abs(in) <= xmidpitch
   den = 4*xmidpitch*abs(in) - 2*xtpitch*abs(in);
   out = (xmidpitch*in*(2*abs(in) - xtpitch))/den;
 else
   den = (xmaxpitch - xmidpitch);  
   out = (xmaxpitch*abs(in) - ...
         .5*xmidpitch*(abs(in) + xmaxpitch))/den;

 end;



