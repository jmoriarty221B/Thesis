clc
clear
sideslip=openfig('CombinedBeta.fig','invisible')
ax1=gca;
roll=openfig('CombinedRoll.fig','invisible')
ax2=gca;
rollrate=openfig('CombinedRollRate.fig','invisible')
ax3=gca;
yawrate=openfig('CombinedYawRate.fig','invisible')
ax4=gca;
f4=figure;
s1=subplot(2,2,1)
s2=subplot(2,2,2)
s3=subplot(2,2,3)
s4=subplot(2,2,4)
fig1 = get(ax1,'children');
fig2 = get(ax2,'children');
fig3 = get(ax3,'children');
fig4 = get(ax4,'children');
copyobj(fig1,s1)
copyobj(fig2,s2)
copyobj(fig3,s3)
copyobj(fig4,s4)
close(sideslip);
close(roll);
close(rollrate);
close(yawrate);
clear figure;
clear;