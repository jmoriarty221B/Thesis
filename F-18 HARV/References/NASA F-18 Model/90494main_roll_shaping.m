function [out]=roll_shaping(in);
%
xtroll= .6;
xmaxroll= 3.;
den=2*xmaxroll*xtroll-xtroll^2;
%
if abs(in) < xtroll
  out = xmaxroll*in*abs(in)/den;
else
  out = 2*xmaxroll*xtroll*in*(1-xtroll/(2*abs(in)))/den;
end;
%
%
% the above could be replaced by the following (vectorized code)
%
%$$$ for i=1:length(in)
%$$$   if abs(in(i)) < .6
%$$$     out1(i) = 0.9259*in(i)*abs(in(i));
%$$$   else
%$$$     if in(i) > 0.
%$$$       out1(i) = 1.11111 * in(i) - .3333333;
%$$$     else
%$$$       out1(i) = 1.11111 * in(i) + .3333333;
%$$$     end
%$$$   end;
%$$$ end


