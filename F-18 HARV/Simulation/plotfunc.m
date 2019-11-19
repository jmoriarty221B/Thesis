X = load('Test1.mat');
V = X.ans.Data(:,1);
alpha = X.ans.Data(:,2);
beta = X.ans.Data(:,3);
p = X.ans.Data(:,4);
q = X.ans.Data(:,5);
r = X.ans.Data(:,6);
psi = X.ans.Data(:,7);
theta = X.ans.Data(:,8);
phi = X.ans.Data(:,9);
x = X.ans.Data(:,10);
y = X.ans.Data(:,11);
h= X.ans.Data(:,12);
t= X.ans.Time;
InitialStates = X.ans.Data(1,1:12)
InitialControls = X.ans.Data(1,13:17)
figure(1)
plot3(x,y,h, '-r', 'LineWidth', 1.5);
title('XYZ Plot for F-18 HARV');
xlabel('X Position');
ylabel('Y Position');
zlabel('Z Position');

figure(2)
plot(t,V, 'LineWidth', 1);
xlabel('Time');
ylabel('Velocity');
title('Velocity v/s Time');

figure(3)
subplot(2,1,1);
plot(t,alpha, 'LineWidth', 1);
xlabel('Time');
ylabel('\alpha');
title('\alpha v/s Time');
subplot(2,1,2);
plot(t, beta, 'LineWidth', 1);
xlabel('Time');
ylabel('\beta');
title('\beta v/s Time');

figure(4)
subplot(3,1,1);
plot(t, p, 'LineWidth', 1);
xlabel('Time');
ylabel('p');
title('p v/s Time');
subplot(3,1,2);
plot(t, q, 'LineWidth', 1);
xlabel('Time');
ylabel('q');
title('q v/s Time');
subplot(3,1,3);
plot(t, r, 'LineWidth', 1);
xlabel('Time');
ylabel('r');
title('r v/s Time');

figure(5)
subplot(3,1,1);
plot(t,phi, 'LineWidth', 1);
xlabel('Time');
ylabel('\phi');
title('\phi v/s Time');
subplot(3,1,2);
plot(t, theta, 'LineWidth', 1);
xlabel('Time');
ylabel('\theta');
title('\theta v/s Time');
subplot(3,1,3);
plot(t, psi, 'LineWidth', 1);
xlabel('Time');
ylabel('\psi');
title('\psi v/s Time');

figure(6)
subplot(3,1,1);
plot(t, x, 'LineWidth', 1);
xlabel('Time');
ylabel('x');
title('x v/s Time');
subplot(3,1,2);
plot(t, y, 'LineWidth', 1);
xlabel('Time');
ylabel('y');
title('y v/s Time');
subplot(3,1,3);
plot(t, h, 'LineWidth', 1);
xlabel('Time');
ylabel('z');
title('z v/s Time');

% figure(7)
% plot(beta*180/pi, alpha*180/pi);
% xlabel('\beta');
% ylabel('\alpha');
% title('\alpha v/s \beta');
% xlim([-75 75]);
% ylim([-30 80]);