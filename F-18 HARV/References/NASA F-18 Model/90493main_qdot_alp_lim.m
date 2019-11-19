function [ret,x0,str]=qdot_alp_lim(t,x,u,flag);
%QDOT_ALP_LIM	is the M-file description of the SIMULINK system named QDOT_ALP_LIM.
%	The block-diagram can be displayed by typing: QDOT_ALP_LIM.
%
%	SYS=QDOT_ALP_LIM(T,X,U,FLAG) returns depending on FLAG certain
%	system values given time point, T, current state vector, X,
%	and input vector, U.
%	FLAG is used to indicate the type of output to be returned in SYS.
%
%	Setting FLAG=1 causes QDOT_ALP_LIM to return state derivatives, FLAG=2
%	discrete states, FLAG=3 system outputs and FLAG=4 next sample
%	time. For more information and other options see SFUNC.
%
%	Calling QDOT_ALP_LIM with a FLAG of zero:
%	[SIZES]=QDOT_ALP_LIM([],[],[],0),  returns a vector, SIZES, which
%	contains the sizes of the state vector and other parameters.
%		SIZES(1) number of states
%		SIZES(2) number of discrete states
%		SIZES(3) number of outputs
%		SIZES(4) number of inputs.
%	For the definition of other parameters in SIZES, see SFUNC.
%	See also, TRIM, LINMOD, LINSIM, EULER, RK23, RK45, ADAMS, GEAR.

% Note: This M-file is only used for saving graphical information;
%       after the model is loaded into memory an internal model
%       representation is used.

% the system will take on the name of this mfile:
sys = mfilename;
new_system(sys)
simver(1.2)
if(0 == (nargin + nargout))
     set_param(sys,'Location',[155,189,1032,494])
     open_system(sys)
end;
set_param(sys,'algorithm',     'RK-45')
set_param(sys,'Start time',    'min(T)')
set_param(sys,'Stop time',     'max(T)')
set_param(sys,'Min step size', '0.0125')
set_param(sys,'Max step size', '0.0125')
set_param(sys,'Relative error','1e-3')
set_param(sys,'Return vars',   '')

add_block('built-in/Inport',[sys,'/',['roll_rate (rad//s)',13,'p_rps']])
set_param([sys,'/',['roll_rate (rad//s)',13,'p_rps']],...
		'position',[60,30,100,50])

add_block('built-in/Inport',[sys,'/',['dynamic_pressure (psf)',13,'qbar']])
set_param([sys,'/',['dynamic_pressure (psf)',13,'qbar']],...
		'Port','3',...
		'position',[50,143,115,167])

add_block('built-in/Inport',[sys,'/',['yaw_rate (rad//s)',13,'r_rps']])
set_param([sys,'/',['yaw_rate (rad//s)',13,'r_rps']],...
		'Port','2',...
		'position',[60,90,105,110])

add_block('built-in/Inport',[sys,'/',['gross_thrust_est',13,'Tg']])
set_param([sys,'/',['gross_thrust_est',13,'Tg']],...
		'Port','4',...
		'position',[60,210,105,230])

add_block('built-in/Fcn',[sys,'/','Cm_star'])
set_param([sys,'/','Cm_star'],...
		'Expr','(Iy*.05+Ixz*u[1]^2+(Ix-Iz)*(u[1]*u[2]) -Ixz*u[2]^2-(u[4]*18.17*22)/57.3)/(u[3]*S*cbar)',...
		'position',[260,104,740,136])

add_block('built-in/Mux',[sys,'/','Mux1'])
set_param([sys,'/','Mux1'],...
		'hide name',0,...
		'position',[175,84,220,156])

add_block('built-in/Look Up Table',[sys,'/','Fm_1'])
set_param([sys,'/','Fm_1'],...
		'Input_Values','[-.5505 -.55 .25 1]',...
		'Output_Values','[1.483 1.3 .75  -3.9375]',...
		'position',[385,193,435,237])

add_block('built-in/Saturation',[sys,'/','-.55 -> 10'])
set_param([sys,'/','-.55 -> 10'],...
		'Lower Limit','-0.5505',...
		'Upper Limit','10.',...
		'position',[300,198,335,232])

add_block('built-in/Outport',[sys,'/','adot_lim_q rad//s'])
set_param([sys,'/','adot_lim_q rad//s'],...
		'position',[530,204,585,226])
add_line(sys,[105,40;165,90])
add_line(sys,[110,100;165,110])
add_line(sys,[120,155;165,130])
add_line(sys,[110,220;165,150])
add_line(sys,[225,120;250,120])
add_line(sys,[340,215;375,215])
add_line(sys,[745,120;770,120;770,170;250,170;250,215;290,215])
add_line(sys,[440,215;520,215])

% Return any arguments.
if (nargin | nargout)
	% Must use feval here to access system in memory
	if (nargin > 3)
		if (flag == 0)
			eval(['[ret,x0,str]=',sys,'(t,x,u,flag);'])
		else
			eval(['ret =', sys,'(t,x,u,flag);'])
		end
	else
		[ret,x0,str] = feval(sys);
	end
end
