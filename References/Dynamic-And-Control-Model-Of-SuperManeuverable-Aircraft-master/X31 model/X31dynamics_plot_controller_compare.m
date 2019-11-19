%{
****************************** DISCLAIMER *********************************
    I, ±d¤ß«³, personally create and debug all parts of this simulation program.
However, it is not me nor anyone that truely "invent" the numerical aircraft 
model like this one. It is based on the long history of all mathematical, 
science, and engineering of humanity. Like Isaac Newton said, "standing on
 the shoulders of giants".
    The aerodynamical parameter of the vehicle in this project comes from 
the thesis written by Snell [1]. In his work, he collected and estimated the
data from multiple source including all major aero-astro research and develop
institude around the world. Also, the method to model the dynamics of the 
vehicle and the controller implemented including the NDI and Gain Scheduling 
also came from his thesis.              
    The quaternion kinematics mainly reference to the toturial paper done by 
Trawny [2], where he collected and organized all fundamental properties and
mathematical operation of such system.                   
    This model is released to improve our ability to understand and develop 
control methodology of aerial vehicle system similar to this one. It is 
released free of charge now and always will be so in the hope of sharing the
knowledge as much as possible and making this world a better place. 
    However, despite my greatest effort to ensure the correctness of the 
code, it is not garantee to be free of bug or other issue. You are free to 
use and modify the program to meet your need but I'm not responsible for any
potential risk or damaged of any kind.
    Long live and prosper
***************************** Liscence: GPLv2 ****************************
Dynamic Model of Super-Maneuverable Aircraft
Copyright (C) 2016 Hsin-Yi Kang
DAA, NCKU
f039281310@yahoo.com.tw
This program is free software; you can redistribute it and/or modify it   
under the terms of the GNU General Public License as published by the Free 
Software Foundation; either version 2 of the License, or (at your option) 
any later version. This program is distributed in the hope that it will be 
useful, but WITHOUT ANY WARRANTY; without even the implied warranty of 
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General 
Public License for more details. You should have received a copy of the GNU 
General Public License along with this program; if not, write to the Free 
Software Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, 
MA 02110-1301, USA. 
**************************** Main Reference *******************************
X31:
    [1] Snell, Sidney Antony, "Nonlinear Dynamic-Inversion Flight Control 
of Supermaneuverable Aircraft", Ph.D thesis, UoMinnesota, 1991
Quaternion:
    [2] Nikolas Trawny and StergiosI. Roumeliotis, "Indirect Kalman Filter 
for 3D Attitude Estimation," University of Minnesota, 2005.
                         ***Side Reference***
X31:
    [3] David F. Fisher, John H. Del Frate, and David M. Richwinc, "In-Flight 
Flow Visualization Characteristics of the NASA F-18 High Alpha Research 
Vehicle at High Angles of Attack", Technical Memorandum4193, NASA, Edwards, 
CA, 1990.
    [4] W. B. W. a. W. P. Fellers, "Tail Configurations for Highly 
Maneuverable Aircraft," AGARD, 1981.

Quaternion:
    [5] Nikolas Trawnyand StergiosI. Roumeliotis, "Indirect Kalman Filter 
for 3D Attitude Estimation," University of Minnesota, 2005.
    [6] W. G. Breckenridge, "Quaternions -Proposed Standard Conventions" 
JPL, Tech. Rep. INTEROFFICE MEMORANDUM 343-79-1199, 1999.
    [7] D. M. Henderson, "EularAngles, Quaternions, and Transformation 
Matrices," Mission Planning and Analysis Division, NASA, July 1977.
%}
data_dir_GainS = 'sim_result\x31_03_sim_GainS_MG_30s.mat';
data_dir_NDI = 'sim_result\x31_03_sim_NDI_MG_30s.mat';


close(findobj('type','figure','name','Path top-down'));
close(findobj('type','figure','name','Path longitudinal'));
close(findobj('type','figure','name','Path lateral'));
close(findobj('type','figure','name','3dpath'));

% Plot Gain S first
data_list_GainS = who('-file',data_dir_GainS);
load(data_dir_GainS);

fig_3dpath = figure('name','3dpath');
plot3(x31sim_stateX.data(:,4),x31sim_stateX.data(:,5),x31sim_stateX.data(:,6),'b'); hold on
ax_3dpath = gca;

fig_path_topdown = figure('name','Path top-down');
plot(x31sim_stateX.data(:,5),x31sim_stateX.data(:,4),'b'); hold on
ax_path_topdown = gca;

fig_path_longi = figure('name','Path longitudinal');
plot(x31sim_stateX.data(:,4),x31sim_stateX.data(:,6),'b'); hold on
ax_path_longi = gca;

fig_path_lat = figure('name','Path lateral');
plot(x31sim_stateX.data(:,5),x31sim_stateX.data(:,6),'b'); hold on
ax_path_lat = gca;

clear(data_list_GainS{:});

% Plot NDI second
data_list_NDI = who('-file',data_dir_NDI);
load(data_dir_NDI);

plot3(ax_3dpath,x31sim_stateX.data(:,4),x31sim_stateX.data(:,5),x31sim_stateX.data(:,6),'r');
grid(ax_3dpath,'on');    axis(ax_3dpath,'equal');
xlabel(ax_3dpath,'x');    ylabel(ax_3dpath,'y');    zlabel(ax_3dpath,'z');
set(ax_3dpath,'YDir','Reverse','ZDir','Reverse');
legend(ax_3dpath,'Gain Scheduling','NDI');

plot(ax_path_topdown,x31sim_stateX.data(:,5),x31sim_stateX.data(:,4),'r');
xlabel(ax_path_topdown,'y');    ylabel(ax_path_topdown,'x');
legend(ax_path_topdown,'Gain Scheduling','NDI');

plot(ax_path_longi,x31sim_stateX.data(:,4),x31sim_stateX.data(:,6),'r');
xlabel(ax_path_longi,'x');    ylabel(ax_path_longi,'z');
set(ax_path_longi,'YDir','Reverse');      axis(ax_path_longi,'equal');
legend(ax_path_longi,'Gain Scheduling','NDI');

plot(ax_path_lat,x31sim_stateX.data(:,5),x31sim_stateX.data(:,6),'r');
xlabel(ax_path_lat,'y');    ylabel(ax_path_lat,'z');
set(ax_path_lat,'YDir','Reverse');
legend(ax_path_lat,'Gain Scheduling','NDI');


clear(data_list_NDI{:});
