%Yaw rate
clc
clear figure;
clear;
figure(1) = openfig('yawrateBeta10.fig');
figure(2) = openfig('yawrateBeta50.fig','invisible');
figure(3) = openfig('yawrateBeta100.fig','invisible');
figure(4) = openfig('yawrateBeta500.fig','invisible');
figure(5) = openfig('yawrateBeta1000.fig','invisible');
L2 = findobj(2,'type','line');
L3 = findobj(3,'type','line');
L4 = findobj(4,'type','line');
L5 = findobj(5,'type','line');
set(L2,'Color','red');
set(L3,'Color','green');
set(L4,'Color','blue');
set(L5,'Color','white');
copyobj(L2,findobj(1,'type','axes'));
copyobj(L3,findobj(1,'type','axes'));
copyobj(L4,findobj(1,'type','axes'));
copyobj(L5,findobj(1,'type','axes'));
close(2);
close(3);
close(4);
close(5);
savefig('CombinedYawRate.fig');
clear figure;