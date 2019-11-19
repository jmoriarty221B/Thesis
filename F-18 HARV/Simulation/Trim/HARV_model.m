rtod       = 180/pi;
cbar       = 11.52*0.305;
b          = 37.42*0.305;
m          = 1128.09*14.5939
g          = 9.8;
Ix         = 30897.73526255;
Iy         = 239720.815;
Iz         = 259969.9570048;
Ixz        = -2.6;
S          = 400*(0.305^2);


c1 = ((Iy-Iz)*Iz-Ixz^2)/(Ix*Iz-Ixz^2);
c2 = (Ix-Iy+Iz)*Ixz/(Ix*Iz-Ixz^2);
c3 = Iz/(Ix*Iz-Ixz^2);
c4 = Ixz/(Ix*Iz-Ixz^2);
c5 = (Iz-Ix)/Iy;
c6 = Ixz/Iy;
c7 = 1/Iy;
c8 = ((Ix-Iy)*Ix-Ixz^2)/(Ix*Iz-Ixz^2);
c9 = Ix/(Ix*Iz-Ixz^2);

GM = [c3 0 c4 0 c2 0 0 c1 0;
      0 c7 0 -c6 0 c5 0 0 c6;
      c4 0 c9 0 c8 0 0 -c2 0]
