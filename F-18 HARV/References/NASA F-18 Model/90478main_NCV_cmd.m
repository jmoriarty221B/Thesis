function [ret,x0,str]=NCV_cmd(t,x,u,flag);
%NCV_CMD	is the M-file description of the SIMULINK system named NCV_CMD.
%	The block-diagram can be displayed by typing: NCV_CMD.
%
%	SYS=NCV_CMD(T,X,U,FLAG) returns depending on FLAG certain
%	system values given time point, T, current state vector, X,
%	and input vector, U.
%	FLAG is used to indicate the type of output to be returned in SYS.
%
%	Setting FLAG=1 causes NCV_CMD to return state derivatives, FLAG=2
%	discrete states, FLAG=3 system outputs and FLAG=4 next sample
%	time. For more information and other options see SFUNC.
%
%	Calling NCV_CMD with a FLAG of zero:
%	[SIZES]=NCV_CMD([],[],[],0),  returns a vector, SIZES, which
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
     set_param(sys,'Location',[303,246,919,529])
     open_system(sys)
end;
set_param(sys,'algorithm',     'RK-45')
set_param(sys,'Start time',    'min(T)')
set_param(sys,'Stop time',     'max(T)')
set_param(sys,'Min step size', '0.0125')
set_param(sys,'Max step size', '0.0125')
set_param(sys,'Relative error','1e-3')
set_param(sys,'Return vars',   '')

add_block('built-in/Gain',[sys,'/','pedal_gain'])
set_param([sys,'/','pedal_gain'],...
		'Gain','0.0109935',...
		'position',[175,58,255,112])

add_block('built-in/Saturation',[sys,'/',['yaw trim',13,'limit',13,'-12 -> 12.']])
set_param([sys,'/',['yaw trim',13,'limit',13,'-12 -> 12.']],...
		'Lower Limit','-12.0',...
		'Upper Limit','12.0',...
		'position',[260,156,305,194])

add_block('built-in/Gain',[sys,'/','yaw_trim_gain'])
set_param([sys,'/','yaw_trim_gain'],...
		'Gain','0.09',...
		'position',[160,152,220,198])

add_block('built-in/Gain',[sys,'/','deg2rad'])
set_param([sys,'/','deg2rad'],...
		'Gain','.0174',...
		'position',[335,158,385,192])

add_block('built-in/Sum',[sys,'/','Sum2'])
set_param([sys,'/','Sum2'],...
		'hide name',0,...
		'position',[445,80,465,100])

add_block('built-in/Outport',[sys,'/','NCV_command'])
set_param([sys,'/','NCV_command'],...
		'position',[505,81,565,99])

add_block('built-in/Inport',[sys,'/',['rudder_pedal (lb)',13,'drp']])
set_param([sys,'/',['rudder_pedal (lb)',13,'drp']],...
		'position',[75,75,120,95])

add_block('built-in/Inport',[sys,'/','yaw_trim (deg)'])
set_param([sys,'/','yaw_trim (deg)'],...
		'Port','2',...
		'position',[70,165,115,185])
add_line(sys,[120,175;150,175])
add_line(sys,[470,90;495,90])
add_line(sys,[225,175;250,175])
add_line(sys,[310,175;325,175])
add_line(sys,[125,85;165,85])
add_line(sys,[390,175;415,175;415,95;435,95])
add_line(sys,[260,85;435,85])

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
