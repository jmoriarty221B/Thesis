function [limits] = roll_stick_limits(in,first_pass);
%
% this function calculates the roll command limits
% for the honeywell control laws
%
% in(6) = baerotilde(2,1)
% in(7) = baerotilde(2,2)
% in(8) = baerotilde(2,3)
% in(9) = aileron command
% in(10)= left stab command
% in(11)= right stab command
% in(12)= rudder command
%
%
if first_pass == 1,
  disp('Im first passing')

end
%
%
tsamp = .0125;
dail_old = surf(1);
%
%
htl_old = de + .5*surf(3);
htr_old = de - .5*surf(3);
rud_old = surf(2);
%
%
%
ail_min = max(-50,dail_old   - tsamp*200.);
ail_max = min( 50,dail_old   + tsamp*200.);
rud_min = max(-30,rud_old  - tsamp*73.);
rud_max = min( 30,rud_old  + tsamp*73.);
htl_max = min( 10,htl_old  + tsamp*40.);
htl_min = max(-24,htl_old  - tsamp*40.);
htr_max = min( 10,htr_old  + tsamp*40.);
htr_min = max(-24,htr_old  - tsamp*40.);
%
demin = .5*(htl_min + htr_min);
demax = .5*(htl_max + htr_max);
%
de = in(13)/in(14);
if de > demax,
  de = demax;
elseif de < demin,
  de = demin;
end
%
%
htr_pr = 0;
htl_pr = 0;
htl_doub_pr = de + .5*surf(3);
htr_doub_pr = de - .5*surf(3);
%
if   htl_doub_pr < htl_min,
  htl_pr = htl_min;
  htr_pr = 2*de - htl_pr;
elseif htl_doub_pr > htl_max,
  htl_pr = htl_max;
  htr_pr = 2*de - htl_pr;
elseif htr_doub_pr < htr_min,
  htr_pr = htr_min;
  htl_pr = 2*de - htr_pr;
elseif htr_doub_pr > htr_max,
  htr_pr = htr_max;
  htl_pr = 2*de - htr_pr;
else
  htl_pr = htl_doub_pr;
  htr_pr = htr_doub_pr;
end
%
%
min1 = min((htl_max - htl_pr),(htr_max - htr_pr));
min2 = min((htl_pr - htl_min),(htr_pr - htr_min));
delta_ht = 2*min(min1,min2);
%
deroll_min = htl_pr - htr_pr - delta_ht;
deroll_max = htl_pr - htr_pr + delta_ht;
deroll_max = min( 10,deroll_max);
deroll_min = max(-10,deroll_min);
%
limmax =  2*min(abs(de + 24),abs(10 - de));
de_pr_max = min(limmax,34);
limmin = -2*min(abs(de + 24),abs(10 - de));
de_pr_min = max(limmin,-34);
wd3  = .5*(de_pr_max - de_pr_min);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% start the s23 solution
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%
d_cent = [ .5*(ail_min    + ail_max);
           .5*(rud_min    + rud_max);
           .5*(deroll_min + deroll_max)];
%
d_lim  = [ .5*(ail_max    - ail_min);
           .5*(rud_max    - rud_min);
           .5*(deroll_max - deroll_min)];
%
r   = [in(1);in(2)];
b = r - amat*d_cent;
%
inv_d_lim = 0*ones(3,1);
for i = 1:3,
 if d_lim(i) > 1.e-12,
  inv_d_lim(i) = 1./d_lim(i);
 else
  inv_d_lim(i) = 1.e12;
 end
end
%
%  linear solution
%
Dsq = diag([wd1 wd2 wd3])^2.;
Minv= inv(amat*Dsq*amat');
%
%
%
linsurf = Dsq*amat'*Minv*r - d_cent;
%
% check to see if linear solution is
% ok
%
surf(5) = linsurf(1);
surf(6) = linsurf(2);
surf(7) = linsurf(3);
surf(8) = inv_d_lim(1);
surf(9) = inv_d_lim(2);
surf(10)= inv_d_lim(3);
surf(11) = deroll_max;
surf(12) = deroll_min;
surf(13) = d_lim(1);
surf(14) = d_lim(2);
surf(15) = d_lim(3);
surf(16) = d_cent(1);
surf(17) = d_cent(2);
surf(18) = d_cent(3);
%
if (linsurf.*inv_d_lim) <= ones(3,1),
  surf(1:3) = d_cent + linsurf;
  surf(4) = 1;
  return;
end
%
%
% calculate the 6 surface solutions
%
%
xsurf = 0*ones(3,6);
F1 = [amat(1,2) amat(1,3);
      amat(2,2) amat(2,3)];
w1 = [b(1) + amat(1,1)*d_lim(1);
      b(2) + amat(2,1)*d_lim(1)];
ysurf1 = inv(F1)*w1;
xsurf(:,1) = [-d_lim(1);
             ysurf1(1);
             ysurf1(2)];
%
%
%
F2 = F1;
w2 = [b(1) - amat(1,1)*d_lim(1);
      b(2) - amat(2,1)*d_lim(1)];
ysurf2 = inv(F2)*w2;
xsurf(:,2) = [ d_lim(1);
             ysurf2(1);
             ysurf2(2)];
%
%
%
F3 = [amat(1,1) amat(1,3);
      amat(2,1) amat(2,3)];
w3 = [b(1) + amat(1,2)*d_lim(2);
      b(2) + amat(2,2)*d_lim(2)];
ysurf3 =  inv(F3)*w3;
xsurf(:,3) = [   ysurf3(1);
                 -d_lim(2);
                 ysurf3(2)];
%
%
%
F4 = F3;
w4 = [b(1) - amat(1,2)*d_lim(2);
      b(2) - amat(2,2)*d_lim(2)];
ysurf4 = inv(F4)*w4;
xsurf(:,4) = [   ysurf4(1);
                  d_lim(2);
                 ysurf4(2)];
%
%
%
F5 = [amat(1,1) amat(1,2);
      amat(2,1) amat(2,2)];
w5 = [b(1) + amat(1,3)*d_lim(3);
      b(2) + amat(2,3)*d_lim(3)];
ysurf5 = inv(F5)*w5;
xsurf(:,5)= [    ysurf5(1);
                 ysurf5(2);
                -d_lim(3)];
%
%
%
F6 = F5;
w6 = [b(1) - amat(1,3)*d_lim(3);
      b(2) - amat(2,3)*d_lim(3)];
ysurf6 = inv(F6)*w6;
xsurf(:,6)= [      ysurf6(1);
                   ysurf6(2);
                   d_lim(3)];
%
%
surfnorm =2.*ones(6,1);
for i = 1:6,
 if (xsurf(:,i).*inv_d_lim) <= ones(3,1),
   surfnorm(i) = sqrt(sum((xsurf(:,i).*inv_d_lim).^2.));
 end
end
[surfmin,index]=min(surfnorm)
if surfmin < 2.,
  surf(1:3) = d_cent + xsurf(index);
  surf(19) = xsurf(index);
  surf(4) = 2;
  return;
end
%
% now for solutions on the edge of a cube
%
vo = [d_lim(1)*ones(1,6) -d_lim(1)*ones(1,6);
      d_lim(2)*ones(1,3) -d_lim(2)*ones(1,3) ...
      d_lim(2)*ones(1,3) -d_lim(2)*ones(1,3);
      d_lim(3)*ones(1,3) -d_lim(3)*ones(1,6) ...
      d_lim(3)*ones(1,3)];
%
v1 = [d_lim(1)*ones(1,2) -d_lim(1) d_lim(1)*ones(1,2) -d_lim(1) ...
      d_lim(1) -d_lim(1)*ones(1,2) d_lim(1) -d_lim(1)*ones(1,2);
      d_lim(2) -d_lim(2) d_lim(2)*ones(1,2) -d_lim(2)*ones(1,2) ...
      d_lim(2)*ones(1,2) -d_lim(2)*ones(1,2) d_lim(2) -d_lim(2);
     -d_lim(3) d_lim(3)*ones(1,2) -d_lim(3) d_lim(3) ....
     -d_lim(3)*ones(1,2) d_lim(3) -d_lim(3) ...
      d_lim(3)*ones(1,2) -d_lim(3)];
%
%
tden     = 0*ones(1,12);
tnum     = 0*ones(1,12);
inv_tden = 0*ones(1,12);
trat     = 0*ones(1,12);
%
% calculate ratio, trat
%
R = diag([1. 25.]);
%
first_edge = 1;
for i = 1:12;
  tnum(i) = (b - amat*vo(:,i))'*R*amat*(v1(:,i) - vo(:,i));
  tden(i) = (v1(:,i) - vo(:,i))'*amat'*R*amat*(v1(:,i) - vo(:,i));
  if abs(tden(i)) > 1.e-12,
    inv_tden(i) = 1./tden(i);
  else
    inv_tden(i) = 1.e12;
  end
  trat(i) = tnum(i)*inv_tden(i);
%
% calculate the edge surfaces based
% on the t ratio
%
  if     trat(i) < 0,
    edgesurf(:,i) = d_cent + vo(:,i);
  elseif trat(i) > 1,
    edgesurf(:,i) = d_cent + v1(:,i);
  else
    edgesurf(:,i) = d_cent + vo(:,i) + trat(i)*(v1(:,i) - vo(:,i));
  end
%
% find out which set of surface deflections
% have a minimum cost functional
%
%
  if first_edge == 1,
    temp = R*(amat*edgesurf(:,i) - r).^2;
    edgecost0 = sqrt(temp(1) + temp(2));
    first_edge = 0;
  else

    temp = R*(amat*edgesurf(:,i) - r).^2;
    edgecost(i) = sqrt(temp(1) + temp(2));
    if edgecost(i) < edgecost0 ,
      edgecost0 = edgecost(i);
      surf(1:3) = edgesurf(:,i);
      surf(14) = edgesurf(3,i) - d_cent(3);
    end
  end
end  
surf(4) = 3;
trat     = 0*ones(1,12);
return;







