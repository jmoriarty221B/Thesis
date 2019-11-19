function [ret,x0,str]=MCV_fdbk(t,x,u,flag);
%MCV_FDBK	is the M-file description of the SIMULINK system named MCV_FDBK.
%	MCV_FDBK has a total of 0 states, 0 discrete states, 1 outputs and 8 inputs.
%	The block-diagram can be displayed by typing: MCV_FDBK.
%
%	SYS=MCV_FDBK(T,X,U,FLAG) returns depending on FLAG certain
%	system values given time point, T, current state vector, X,
%	and input vector, U.
%	FLAG is used to indicate the type of output to be returned in SYS.
%
%	Setting FLAG=1 causes MCV_FDBK to return state derivatives, FLAG=2
%	discrete states, FLAG=3 system outputs and FLAG=4 next sample
%	time. For more information and other options see SFUNC.
%
%	Calling MCV_FDBK with a FLAG of zero:
%	[SIZES]=MCV_FDBK([],[],[],0),  returns a vector, SIZES, which
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
     set_param(sys,'Location',[100,100,938,819])
     open_system(sys)
end;
set_param(sys,'algorithm',     'RK-45')
set_param(sys,'Start time',    'min(T)')
set_param(sys,'Stop time',     'max(T)')
set_param(sys,'Min step size', '0.0125')
set_param(sys,'Max step size', '0.0125')
set_param(sys,'Relative error','1e-3')
set_param(sys,'Return vars',   '')

add_block('built-in/Sum',[sys,'/','Sum1'])
set_param([sys,'/','Sum1'],...
		'hide name',0,...
		'position',[685,55,705,75])

add_block('built-in/Look Up Table',[sys,'/','F_alpha'])
set_param([sys,'/','F_alpha'],...
		'Input_Values','[-.25 -.15 1.5 1.55]',...
		'Output_Values','[0 1 1 0]',...
		'position',[290,151,350,189])

add_block('built-in/Gain',[sys,'/','Kz_alp//V_co'])
set_param([sys,'/','Kz_alp//V_co'],...
		'Gain','2.33/400.',...
		'position',[305,218,390,262])

add_block('built-in/Product',[sys,'/','Product'])
set_param([sys,'/','Product'],...
		'hide name',0,...
		'position',[240,230,265,250])

add_block('built-in/Look Up Table',[sys,'/','F_lon'])
set_param([sys,'/','F_lon'],...
		'Input_Values','[0 12 50 500]',...
		'Output_Values','[0 0 1 1]',...
		'position',[410,111,470,149])

add_block('built-in/Sum',[sys,'/','Sum'])
set_param([sys,'/','Sum'],...
		'hide name',0,...
		'position',[450,235,470,255])

add_block('built-in/Product',[sys,'/','Product1'])
set_param([sys,'/','Product1'],...
		'hide name',0,...
		'position',[530,230,555,250])

add_block('built-in/Product',[sys,'/','Product2'])
set_param([sys,'/','Product2'],...
		'hide name',0,...
		'position',[620,225,645,245])

add_block('built-in/Sum',[sys,'/','Sum2'])
set_param([sys,'/','Sum2'],...
		'hide name',0,...
		'inputs','-+-',...
		'position',[575,372,595,428])

add_block('built-in/Fcn',[sys,'/','gravity compensation'])
set_param([sys,'/','gravity compensation'],...
		'Expr','(g*cos(u[2])*cos(u[3]))/u[1]',...
		'position',[385,387,545,413])

add_block('built-in/Mux',[sys,'/','Mux'])
set_param([sys,'/','Mux'],...
		'inputs','3',...
		'position',[335,384,365,416])

add_block('built-in/Product',[sys,'/','Product4'])
set_param([sys,'/','Product4'],...
		'hide name',0,...
		'position',[190,380,215,400])

add_block('built-in/Saturation',[sys,'/','Saturation'])
set_param([sys,'/','Saturation'],...
		'Lower Limit','1.0',...
		'Upper Limit','1000.',...
		'position',[240,380,265,400])

add_block('built-in/Product',[sys,'/','Product3'])
set_param([sys,'/','Product3'],...
		'hide name',0,...
		'position',[230,695,255,715])

add_block('built-in/Fcn',[sys,'/','Fcn'])
set_param([sys,'/','Fcn'],...
		'orientation',3,...
		'hide name',0,...
		'Expr','cos(u[1])',...
		'position',[137,525,193,565])

add_block('built-in/Fcn',[sys,'/','Fcn1'])
set_param([sys,'/','Fcn1'],...
		'orientation',1,...
		'hide name',0,...
		'Expr','tan(u[1])',...
		'position',[137,635,193,675])

add_block('built-in/Inport',[sys,'/',['alpha (rad)',13,'alpha_rad']])
set_param([sys,'/',['alpha (rad)',13,'alpha_rad']],...
		'Port','3',...
		'position',[50,236,105,254])

add_block('built-in/Inport',[sys,'/',['dynamic_pressure (psf)',13,'qbar']])
set_param([sys,'/',['dynamic_pressure (psf)',13,'qbar']],...
		'Port','2',...
		'position',[50,118,115,142])

add_block('built-in/Inport',[sys,'/',['pitch_rate (rad//s)',13,'q_rps']])
set_param([sys,'/',['pitch_rate (rad//s)',13,'q_rps']],...
		'position',[65,47,100,73])

add_block('built-in/Outport',[sys,'/','MCV_feedback'])
set_param([sys,'/','MCV_feedback'],...
		'position',[765,53,860,77])

add_block('built-in/Inport',[sys,'/',['true_velocity (fps)',13,'vtrue']])
set_param([sys,'/',['true_velocity (fps)',13,'vtrue']],...
		'Port','4',...
		'position',[60,373,125,397])

add_block('built-in/Inport',[sys,'/',['mu (rad)',13,'mu_rad']])
set_param([sys,'/',['mu (rad)',13,'mu_rad']],...
		'Port','5',...
		'position',[45,438,110,462])

add_block('built-in/Inport',[sys,'/',['gamma (rad)',13,'gamma_rad']])
set_param([sys,'/',['gamma (rad)',13,'gamma_rad']],...
		'Port','6',...
		'position',[50,498,115,522])

add_block('built-in/Inport',[sys,'/',['beta (rad)',13,'beta_rad']])
set_param([sys,'/',['beta (rad)',13,'beta_rad']],...
		'Port','7',...
		'position',[45,598,110,622])

add_block('built-in/Inport',[sys,'/',['p_stability (rad//s)',13,'pstab_rps']])
set_param([sys,'/',['p_stability (rad//s)',13,'pstab_rps']],...
		'Port','8',...
		'position',[45,698,110,722])

add_block('built-in/Gain',[sys,'/','Kv'])
set_param([sys,'/','Kv'],...
		'Gain','.0006',...
		'position',[290,334,360,366])
add_line(sys,[105,60;675,60])
add_line(sys,[120,130;400,130])
add_line(sys,[270,240;295,240])
add_line(sys,[110,245;230,245])
add_line(sys,[155,245;155,170;280,170])
add_line(sys,[185,130;185,235;230,235])
add_line(sys,[395,240;440,240])
add_line(sys,[475,245;520,245])
add_line(sys,[560,240;610,240])
add_line(sys,[355,170;490,170;490,235;520,235])
add_line(sys,[475,130;575,130;575,230;610,230])
add_line(sys,[650,235;670,235;670,70;675,70])
add_line(sys,[710,65;755,65])
add_line(sys,[115,710;220,710])
add_line(sys,[130,385;180,385])
add_line(sys,[165,520;165,395;180,395])
add_line(sys,[115,610;165,610;165,575])
add_line(sys,[220,390;230,390])
add_line(sys,[270,390;325,390])
add_line(sys,[115,450;305,450;305,400;325,400])
add_line(sys,[120,510;320,510;320,410;325,410])
add_line(sys,[370,400;375,400])
add_line(sys,[550,400;565,400])
add_line(sys,[260,705;555,705;555,420;565,420])
add_line(sys,[145,385;145,350;280,350])
add_line(sys,[365,350;555,350;555,380;565,380])
add_line(sys,[600,400;660,400;660,280;420,280;420,250;440,250])
add_line(sys,[165,610;165,625])
add_line(sys,[165,680;165,700;220,700])

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
