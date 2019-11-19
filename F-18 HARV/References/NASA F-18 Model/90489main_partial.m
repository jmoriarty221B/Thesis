function [out] = partial(in);
%
%
%
% this function calculates the matrix of
% partial derivatives of the CVdots with respect 
% to aerodynamic surfaces
%
%
%
%
out    = 0*ones(21,1);
cvdnom = 0*ones(3,1);
cvdper = 0*ones(3,7);
baero  = 0*ones(3,7);
cvdnom = model(in);
%
% in(1) = 1; aileron
%   (2) = 2; left stab
%   (3) = 3; right stab
%   (4) = 4; rudder 
%   (5) = 5; roll vectoring
%   (6) = 6; pitch vectoring
%   (7) = 7; yaw vectoring
%
% resulting matrix, baero
%
%   ail  symstab  rudder rollv pitv yawv rollstab
% --------------------------------------------------
% Cl
% Cm
% Cn
% --------------------------------------------------
%
%
for i = 1:7,
  if i == 1,
    in(1) = in(1) + .5;
  elseif i == 2,
    in(2) = in(2) + .5;
    in(3) = in(3) + .5;
  elseif i == 3,
    in(4) = in(4) + .5;
  elseif i == 4,
    in(5) = in(5) + .5;
  elseif i == 5,
    in(6) = in(6) + .5;
  elseif i == 6,
    in(7) = in(7) + .5;
  elseif i == 7,
    in(2) = in(2) + .25;
    in(3) = in(3) - .25;
  end
  cvdper(:,i) = model(in);
  if i == 1,
    in(1) = in(1) - .5;
  elseif i == 2,
    in(2) = in(2) - .5;
    in(3) = in(3) - .5;
  elseif i == 3,
    in(4) = in(4) - .5;
  elseif i == 4,
    in(5) = in(5) - .5;
  elseif i == 5,
    in(6) = in(6) - .5;
  elseif i == 6,
    in(7) = in(7) - .5;
  elseif i == 7,
    in(2) = in(2) - .25;
    in(3) = in(3) + .25;
  end
%
% 
%
  baero(:,i) = (cvdper(:,i) - cvdnom)/.5;
%
end
out(1) = baero(1,1);
out(2) = baero(2,1);
out(3) = baero(3,1);
out(4) = baero(1,2);
out(5) = baero(2,2);
out(6) = baero(3,2);
out(7) = baero(1,3);
out(8) = baero(2,3);
out(9) = baero(3,3);
out(10) = baero(1,4);
out(11) = baero(2,4);
out(12) = baero(3,4);
out(13) = baero(1,5);
out(14) = baero(2,5);
out(15) = baero(3,5);
out(16) = baero(1,6);
out(17) = baero(2,6);
out(18) = baero(3,6);
out(19) = baero(1,7);
out(20) = baero(2,7);
out(21) = baero(3,7);
%
% 
%
%
%


