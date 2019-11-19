file = 'Test.mat';
X = load(file);

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
title('XYH Plot for F-18 HARV');
xlabel('X Position');
ylabel('Y Position');
zlabel('H Position');

figure(2)
plot(t,round(V,2), 'LineWidth', 1);
xlabel('Time');
ylabel('Velocity');
title('Velocity v/s Time');

figure(3)
subplot(2,1,1);
plot(t,round(alpha,2), 'LineWidth', 1);
xlabel('Time');
ylabel('\alpha');
title('\alpha v/s Time');
subplot(2,1,2);
plot(t, round(beta,2), 'LineWidth', 1);
xlabel('Time');
ylabel('\beta');
title('\beta v/s Time');

figure(4)
subplot(3,1,1);
plot(t, round(p,2), 'LineWidth', 1);
xlabel('Time');
ylabel('p');
title('p v/s Time');
subplot(3,1,2);
plot(t, round(q,2), 'LineWidth', 1);
xlabel('Time');
ylabel('q');
title('q v/s Time');
subplot(3,1,3);
plot(t, round(r,2), 'LineWidth', 1);
xlabel('Time');
ylabel('r');
title('r v/s Time');

figure(5)
subplot(3,1,1);
plot(t,round(phi,2), 'LineWidth', 1);
xlabel('Time');
ylabel('\phi');
title('\phi v/s Time');
subplot(3,1,2);
plot(t, round(theta,2), 'LineWidth', 1);
xlabel('Time');
ylabel('\theta');
title('\theta v/s Time');
subplot(3,1,3);
plot(t, round(psi,2), 'LineWidth', 1);
xlabel('Time');
ylabel('\psi');
title('\psi v/s Time');

figure(6)
subplot(3,1,1);
plot(t, round(x,2), 'LineWidth', 1);
xlabel('Time');
ylabel('x');
title('x v/s Time');
subplot(3,1,2);
plot(t, round(y,2), 'LineWidth', 1);
xlabel('Time');
ylabel('y');
title('y v/s Time');
subplot(3,1,3);
tf = strcmp(file,'Trim.mat');
if (tf~=1)
    plot(round(x,2),round(y,2));
    xlabel('x');
    ylabel('y');
    title("X-Y v/s Time")
else
    plot(t, round(h,2), 'LineWidth', 1);
    xlabel('Time');
    ylabel('h');
    title('h v/s Time');
end    

% figure(7)
% plot(beta*180/pi, alpha*180/pi);
% xlabel('\beta');
% ylabel('\alpha');
% title('\alpha v/s \beta');
% xlim([-75 75]);
% ylim([-30 80]);