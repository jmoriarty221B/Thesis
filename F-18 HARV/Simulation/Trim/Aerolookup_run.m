alpha = -10:0.1:50;
aero_out = aero_lookup(alpha);
y_axis = ["CY_{beta}", "CY_p", "CY_r", "CY_{da}", "CY_{del}", "CY_{der}", "CY_{dr}", ...
            "Cl_{beta}", "Cl_p", "Cl_r", "Cl_{da}", "Cl_{del}", "Cl_{der}", "Cl_{dr}", ...
            "Cn_{beta}", "Cn_p", "Cn_r", "Cn_{da}", "Cn_{del}", "Cn_{der}", "Cn_{dr}", ...
            "CD_0", "CD_q", "CD_{del}", "CD_{der}", ...
            "CL_0", "CL_q", "CL_{del}", "CL_{der}", ...
            "CM_0", "CM_q", "CM_{del}", "CM_{der}"];
%CALCULATION OF e
aero_0 = aero_lookup(0);
aero_10 = aero_lookup(10);
CL0 = aero_0(26);
CD0 = aero_0(22);
CD10 = aero_10(22)*r2d;
CL10 = aero_10(26)*r2d;
k = 0.0975;
e = 1/(k*pi*(b^2/S))

%%%%%%%%%%%% PERFORMANCE ANALYSIS %%%%%%%%%%%%%%%%
CD0 = 0.0307
T = 71171.546
Em = 9.1451
Vr = sqrt(2*m*g/(1.225*S))*(k/CD0)^0.25
z = T*Em/(m*g)
w = g*sqrt(2*z-2)/Vr
n = sqrt(2*z-1)


plot(alpha,aero_out(:,26));
xlabel('alpha');
ylabel('CL');

%CALCULATION OF E = CL/CD %
% for i=1:601
%     E(i) = aero_out(i,26)/aero_out(i,22);
% end
% figure(1);
% plot(aero_out(:,26), E);
% xlabel('CL');
% ylabel('E');
% figure(2);
% plot(alpha, aero_out(:,26));
% xlabel('alpha');
% ylabel('CL');
% Emax = 9.1451;
% Em = 1/(2*sqrt(k*CD0))
% for k=1:33
%     figure(k)
%     plot(alpha,aero_out(:,k));
%     xlabel("alpha");
%     ylabel(y_axis(k));
%     title(y_axis(k)+" v/s alpha");
% end
