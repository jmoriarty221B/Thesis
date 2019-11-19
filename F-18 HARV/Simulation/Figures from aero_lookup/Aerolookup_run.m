alpha = 0:70;
aero_out = aero_lookup(alpha);
y_axis = ["CY_{\beta}", "CY_p", "CY_r", "CY_{da}", "CY_{del}", "CY_{der}", "CY_{dr}", ...
            "Cl_{\beta}", "Cl_p", "Cl_r", "Cl_{da}", "Cl_{del}", "Cl_{der}", "Cl_{dr}", ...
            "Cn_{\beta}", "Cn_p", "Cn_r", "Cn_{da}", "Cn_{del}", "Cn_{der}", "Cn_{dr}", ...
            "CD_0", "CD_q", "CD_{del}", "CD_{der}", ...
            "CL_0", "CL_q", "CL_{del}", "CL_{der}", ...
            "CM_0", "CM_q", "CM_{del}", "CM_{der}"];
for k=1:33
    figure(k)
    plot(alpha,aero_out(:,k));
    xlabel("\alpha");
    ylabel(y_axis(k));
    name = y_axis(k)+" vs \alpha";
    title(name);
    savefig(name);
end