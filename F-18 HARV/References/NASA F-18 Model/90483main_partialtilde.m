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
out     = 0*ones(7,1);
cvdnom  = 0*ones(3,1);
cvdper  = 0*ones(3,7);
baero   = 0*ones(3,7);
baerobl = 0*ones(3,7);
cvdnom  = model(in);
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
%
% now do the blending of the aero matrices
%
% 
baerolowq = [.00562 -.00148  .01177;
            -.00547 -.00108 -.01135];
bdelowq   = -.01518;
%
% bacn based on these numbers 
%
bacn = .00000325822;
%
% calculate ban
%
sr1 = baero(1,1)^2 + baero(1,3)^2 + baero(1,7)^2;
sr2 = baero(3,1)^2 + baero(3,3)^2 + baero(3,7)^2;
sc1 = baero(1,1)*baero(3,1);
sc2 = baero(1,3)*baero(3,3);
sc3 = baero(1,7)*baero(3,7);
sr = sr1 + sr2;
sc = sr1*sr2 - (sc1 + sc2 + sc3)^2.;
ban = .5*sr - .5*(sr^2 - 4*abs(sc))^.5;
ban = min(ban, abs(baero(2,2)));
%
% calculate blending variable
%
bablend = ban^2./(ban^2. + bacn^2.);
%
% now blend between matrices
%
baerobl = [baero(1,1) baero(1,3) baero(1,7);
           baero(3,1) baero(3,3) baero(3,7)];
bde     = baero(2,2);
%
%
%
baerotilde = 0*ones(2,3);
if bablend > .5,
  baerotilde = baerobl;
  bdetilde   = bde;
else
  baerotilde = bablend*baerobl + (1 - bablend)*baerolowq;
  bdetilde   = bablend*bde     + (1 - bablend)*bdelowq;
end
%
%
%
out(1) = baerotilde(1,1);
out(2) = baerotilde(1,2);
out(3) = baerotilde(1,3);
out(4) = baerotilde(2,1);
out(5) = baerotilde(2,2);
out(6) = baerotilde(2,3);
out(7) = bdetilde;

