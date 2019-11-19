function [ret,x0,str]=LCV_fdbk(t,x,u,flag);
%LCV_fdbk	is the M-file description of the SIMULINK system named LCV_fdbk.
%	The block-diagram can be displayed by typing: LCV_fdbk.
%
%	SYS=LCV_fdbk(T,X,U,FLAG) returns depending on FLAG certain
%	system values given time point, T, current state vector, X,
%	and input vector, U.
%	FLAG is used to indicate the type of output to be returned in SYS.
%
%	Setting FLAG=1 causes LCV_fdbk to return state derivatives, FLAG=2
%	discrete states, FLAG=3 system outputs and FLAG=4 next sample
%	time. For more information and other options see SFUNC.
%
%	Calling LCV_fdbk with a FLAG of zero:
%	[SIZES]=LCV_fdbk([],[],[],0),  returns a vector, SIZES, which
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
     set_param(sys,'Location',[47,100,737,417])
     open_system(sys)
end;
set_param(sys,'algorithm',     'RK-45')
set_param(sys,'Start time',    'min(T)')
set_param(sys,'Stop time',     'max(T)')
set_param(sys,'Min step size', '0.0125')
set_param(sys,'Max step size', '0.0125')
set_param(sys,'Relative error','1e-3')
set_param(sys,'Return vars',   '')

add_block('built-in/Outport',[sys,'/',['p_stability (rad//s)',13,'pstab_rps']])
set_param([sys,'/',['p_stability (rad//s)',13,'pstab_rps']],...
		'position',[460,54,515,76])

add_block('built-in/Fcn',[sys,'/','cos'])
set_param([sys,'/','cos'],...
		'hide name',0,...
		'Expr','cos(u[1])',...
		'position',[150,253,220,277])

add_block('built-in/Sum',[sys,'/','Sum2'])
set_param([sys,'/','Sum2'],...
		'hide name',0,...
		'position',[385,55,405,75])

add_block('built-in/Fcn',[sys,'/','sin'])
set_param([sys,'/','sin'],...
		'hide name',0,...
		'position',[145,178,205,202])

add_block('built-in/Product',[sys,'/','Product'])
set_param([sys,'/','Product'],...
		'hide name',0,...
		'position',[290,50,315,70])

add_block('built-in/Product',[sys,'/','Product1'])
set_param([sys,'/','Product1'],...
		'hide name',0,...
		'position',[290,125,315,145])

add_block('built-in/Inport',[sys,'/',['alpha (rad)',13,'alpha_rad']])
set_param([sys,'/',['alpha (rad)',13,'alpha_rad']],...
		'Port','3',...
		'position',[50,179,85,201])

add_block('built-in/Product',[sys,'/','Product2'])
set_param([sys,'/','Product2'],...
		'hide name',0,...
		'position',[330,175,355,195])

add_block('built-in/Product',[sys,'/','Product3'])
set_param([sys,'/','Product3'],...
		'hide name',0,...
		'position',[325,250,350,270])

add_block('built-in/Sum',[sys,'/','Sum3'])
set_param([sys,'/','Sum3'],...
		'hide name',0,...
		'inputs','-+',...
		'position',[430,180,450,200])

add_block('built-in/Inport',[sys,'/',['yaw_rate (rad//s)',13,'r_rps']])
set_param([sys,'/',['yaw_rate (rad//s)',13,'r_rps']],...
		'Port','2',...
		'position',[55,120,100,140])

add_block('built-in/Inport',[sys,'/',['roll_rate (rad//s)',13,'p_rps']])
set_param([sys,'/',['roll_rate (rad//s)',13,'p_rps']],...
		'position',[60,45,100,65])

add_block('built-in/Outport',[sys,'/',['r_stability (rad//s)',13,'rstab_rps']])
set_param([sys,'/',['r_stability (rad//s)',13,'rstab_rps']],...
		'Port','2',...
		'position',[485,180,535,200])
add_line(sys,[210,190;320,190])
add_line(sys,[260,190;260,140;280,140])
add_line(sys,[105,55;280,55])
add_line(sys,[215,55;215,180;320,180])
add_line(sys,[90,190;135,190])
add_line(sys,[455,190;475,190])
add_line(sys,[105,130;280,130])
add_line(sys,[235,130;235,255;315,255])
add_line(sys,[225,265;250,265;250,65;280,65])
add_line(sys,[250,265;315,265])
add_line(sys,[360,185;420,185])
add_line(sys,[320,60;375,60])
add_line(sys,[320,135;350,135;350,70;375,70])
add_line(sys,[410,65;450,65])
add_line(sys,[120,190;120,265;140,265])
add_line(sys,[355,260;390,260;390,195;420,195])

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
