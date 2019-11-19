%% Control input responses
clear all; clc;
parameters_f;
d_rud = 0; %#ok<NASGU>
sim('HAAfdcModel');
save ContResp_V15_parf.mat tout States15 Valphabeta massNinertia mImatrix forces moments ControlInputs IcMassB;
clear all; clc;

varbles = {'tout','States15','Valphabeta','massNinertia','mImatrix','forces','moments','ControlInputs','IcMassB'};
contActrs = {'Thrust_F','mu_T','d_elv','d_rud'};
pertns = {100,-0.05,-0.03,0.02};
legInds = {2,1,2,2};
noofCI = length(contActrs);
noofvar = length(varbles);
save ContResp_V15_parf.mat varbles contActrs pertns legInds noofCI noofvar -append;

parameters_f;
d_rud = 0;
for i=1:noofCI
    Cinput = contActrs{1,i};
    eval([Cinput ' = ' Cinput ' + ' num2str(pertns{1,i}) ';']);
    sim('HAAfdcModel');
    for j=1:noofvar
        temp = strsplit(Cinput,'_');
        eval([varbles{1,j} temp{1,legInds{1,i}} ' = ' varbles{1,j} ';']);
        eval(['save ContResp_V15_parf.mat ' varbles{1,j} temp{1,legInds{1,i}} ' -append;']);
    end
    clc; clearvars -except varbles contActrs pertns legInds noofCI noofvar;
    parameters_f;
    d_rud = 0;
end

%% Plotting control-input responses (non-dimensional)
load ContResp_V15_parf.mat tout* States15* Valphabeta* contActrs pertns legInds;
colorArray = {'r-','g-','b-','m-','c-','k-','r--','g--','b--','m--','c--','k--',...
    'r-.','g-.','b-.'};
contActrsmod = {'\DeltaThrust','\Delta\mu_{pv}','\Delta\delta_{elv}','\Delta\delta_{rud}'};
% States
k = 0;
legendSArray = {'U','V','W','P','Q','R','\phi','\theta','\psi','X','Y','Z',...
    'V_0','\alpha','\beta'};
figure;
for i=[1,4,2,3,5,6]
    subplot(2,3,i); hold on; grid on; set(gca,'FontSize',12);
    xlabel('Time (s)');
    ylabel('Normalized States');
    legendSmodArray = legendSArray;
    if (i==1)||(i==4)
        title('Trim results');
        for j=1:length(legendSArray)
            timeLen = length(tout);
            if j<=12
                stateTemp = reshape(States15(j,1,:),timeLen,1);
                maxSTemp = max(abs(stateTemp));
                if maxSTemp==0
%                     plot(tout,zeros(timeLen,1),'k-');
                    legendSmodArray = setdiff(legendSmodArray,legendSArray(1,j),'stable');
                else
                    plot(tout,stateTemp./maxSTemp,colorArray{1,j},'LineWidth',1.5);
                end
            else
                othstateTemp = Valphabeta(:,j-12);
                maxothSTemp = max(abs(othstateTemp));
                if maxothSTemp==0
%                     plot(tout,zeros(timeLen,1),'k-');
                    legendSmodArray = setdiff(legendSmodArray,legendSArray(1,j),'stable');
                else
                    plot(tout,othstateTemp./maxothSTemp,colorArray{1,j},'LineWidth',1.5);
                end
            end
        end
        legend(legendSmodArray);
        clear legendSmodArray;
        if i==4
            clear tout States15 Valphabeta;
        end
    else
        if i>=5; k=1; end;
        title([contActrsmod{1,i-1-k} ' = ' num2str(pertns{1,i-1-k})]);
        temp = strsplit(contActrs{1,i-1-k},'_');
        eval(['tout = tout' temp{1,legInds{1,i-1-k}} ';']);
        timeLen = length(tout);
        for j=1:length(legendSArray)
            if j<=12
                eval(['stTemp = States15' temp{1,legInds{1,i-1-k}} '(j,1,:);']);
                pstateTemp = reshape(stTemp,timeLen,1);
                maxpSTemp = max(abs(pstateTemp));
                if maxpSTemp==0
%                     plot(tout,zeros(timeLen,1),'k-');
                    legendSmodArray = setdiff(legendSmodArray,legendSArray(1,j),'stable');
                else
                    plot(tout,pstateTemp./maxpSTemp,colorArray{1,j},'LineWidth',1.5);
                end
            else
                eval(['othpstateTemp = Valphabeta' temp{1,legInds{1,i-1-k}} '(:,j-12);']);
                maxothpSTemp = max(abs(othpstateTemp));
                if maxothpSTemp==0
%                     plot(tout,zeros(timeLen,1),'k-');
                    legendSmodArray = setdiff(legendSmodArray,legendSArray(1,j),'stable');
                else
                    plot(tout,othpstateTemp./maxothpSTemp,colorArray{1,j},'LineWidth',1.5);
                end
            end
        end
        legend(legendSmodArray);
        clear tout States15 Valphabeta legendSmodArray;
    end
end

%% Plotting control-input responses (final values)
load ContResp_V15_parf.mat tout* States15* Valphabeta* varbles contActrs pertns legInds noofCI noofvar;
colorArray = {'r-','g-','b-','m-','k-','c-','r--','g--','b--','m--','k--','c--',...
    'r-.','g-.','b-.','m-.','k-.','c-.'}; % Slightly different
contActrsmod = {'\DeltaT','\Delta\mu_{pv}','\Delta\delta_{elv}','\Delta\delta_{rud}'}; % Slightly different
% States
legendSArray = {'U','V','W','P','Q','R','\phi','\theta','\psi','X','Y','Z',...
    'V_0','\alpha','\beta'};
legendSCArray = {'Velocities (b)','Body rates','Orientation','Position','V_0, \alpha, \beta'};

figure;
for j=1:3:(length(legendSArray)-3)
    figInd = (j+2)/3;
    subplot(2,2,figInd); hold on; grid on; set(gca,'FontSize',12);
    xlabel('Time (s)');
    if figInd~=4
        ylabel(legendSCArray{1,figInd});
    else
        ylabel(['Trim (r),  ' contActrsmod{1,1} ' (g),  ' contActrsmod{1,2} ' (b),  ' contActrsmod{1,3} ...
            ' (m),  ' contActrsmod{1,4} ' (k)']);
    end
    title([legendSArray{1,j} ' (solid), ' legendSArray{1,j+1} ' (dashed), ' legendSArray{1,j+2} ' (-.)']);
    
    timeLen = length(tout);
    for i=1:3
        stateTemp = reshape(States15(j+i-1,1,:),timeLen,1);
        if max(abs(stateTemp))~=0
            plot(tout,stateTemp,colorArray{1,6*i-5},'LineWidth',1.5);
        end
        clear stateTemp;
    end
    clear timeLen;
    
    for k=1:noofCI
        temp = strsplit(contActrs{1,k},'_');
        eval(['timeTemp = tout' temp{1,legInds{1,k}} ';']);
        timeLen = length(timeTemp);
        disp(timeLen);
        for i=1:3
            eval(['stateTemp = reshape(States15' temp{1,legInds{1,k}} '(j+i-1,1,:),timeLen,1);']);
            if max(abs(stateTemp))~=0
                plot(timeTemp,stateTemp,colorArray{1,k+6*i-5},'LineWidth',1.5);
            end
            clear stateTemp;
        end
        clear temp timeLen timeTemp;
    end
end
