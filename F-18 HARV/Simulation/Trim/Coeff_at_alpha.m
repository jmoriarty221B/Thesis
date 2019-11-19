r2d = 180/pi;
aero = aero_lookup(0.2969*r2d);
CD_alpha = 0.03 + r2d*(aero(23)*0.1885 + aero(24)*(-1.3084) + aero(25)*(-0.5481))