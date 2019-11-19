function [ret,x0,str]=NCV_fdbk(t,x,u,flag);
%NCV_FDBK	is the M-file description of the SIMULINK system named NCV_FDBK.
%	NCV_FDBK has a total of 1 states, 0 discrete states, 1 outputs and 8 inputs.
%	The block-diagram can be displayed by typing: NCV_FDBK.
%
%	SYS=NCV_FDBK(T,X,U,FLAG) returns depending on FLAG certain
%	system values given time point, T, current state vector, X,
%	and input vector, U.
%	FLAG is used to indicate the type of output to be returned in SYS.
%
%	Setting FLAG=1 causes NCV_FDBK to return state derivatives, FLAG=2
%	discrete states, FLAG=3 system outputs and FLAG=4 next sample
%	time. For more information and other options see SFUNC.
%
%	Calling NCV_FDBK with a FLAG of zero:
%	[SIZES]=NCV_FDBK([],[],[],0),  returns a vector, SIZES, which
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
     set_param(sys,'Location',[178,217,967,766])
     open_system(sys)
end;
set_param(sys,'algorithm',     'RK-45')
set_param(sys,'Start time',    'min(T)')
set_param(sys,'Stop time',     'max(T)')
set_param(sys,'Min step size', '0.0125')
set_param(sys,'Max step size', '0.0125')
set_param(sys,'Relative error','1e-3')
set_param(sys,'Return vars',   '')

add_block('built-in/Gain',[sys,'/','ny_gain'])
set_param([sys,'/','ny_gain'],...
		'Gain','0.0338615',...
		'position',[170,458,240,492])

add_block('built-in/Gain',[sys,'/','beta gain'])
set_param([sys,'/','beta gain'],...
		'Gain','-0.01462',...
		'position',[205,331,290,369])

add_block('built-in/Saturation',[sys,'/',['velocity lower',13,'limit 1.0 ']])
set_param([sys,'/',['velocity lower',13,'limit 1.0 ']],...
		'Lower Limit','1.0',...
		'Upper Limit','1000.0',...
		'position',[195,130,220,150])

add_block('built-in/Mux',[sys,'/','Mux'])
set_param([sys,'/','Mux'],...
		'inputs','3',...
		'position',[305,134,335,166])

add_block('built-in/Fcn',[sys,'/','gravity compensation'])
set_param([sys,'/','gravity compensation'],...
		'Expr','g*sin(u[2])*cos(u[3])/u[1]',...
		'position',[365,138,515,162])

add_block('built-in/Switch',[sys,'/','Switch'])
set_param([sys,'/','Switch'],...
		'position',[430,454,455,486])

add_block('built-in/Constant',[sys,'/','Constant'])
set_param([sys,'/','Constant'],...
		'Value','0.0',...
		'position',[365,370,385,390])

add_block('built-in/Fcn',[sys,'/','abs(pedal) - 7.'])
set_param([sys,'/','abs(pedal) - 7.'],...
		'Expr','abs(u(1)) - 7.0',...
		'position',[205,399,330,431])

add_block('built-in/Gain',[sys,'/','omega_ny'])
set_param([sys,'/','omega_ny'],...
		'Gain','0.1',...
		'position',[350,467,385,493])

add_block('built-in/Sum',[sys,'/','Sum'])
set_param([sys,'/','Sum'],...
		'hide name',0,...
		'inputs','+-',...
		'position',[305,470,325,490])

add_block('built-in/Gain',[sys,'/','g '])
set_param([sys,'/','g '],...
		'hide name',0,...
		'Gain','g',...
		'position',[260,462,280,488])

add_block('built-in/Inport',[sys,'/',['r_stability (rad//s)',13,'rstab_rps']])
set_param([sys,'/',['r_stability (rad//s)',13,'rstab_rps']],...
		'position',[75,73,140,97])

add_block('built-in/Inport',[sys,'/',['mu (rad)',13,'mu_rad']])
set_param([sys,'/',['mu (rad)',13,'mu_rad']],...
		'Port','3',...
		'position',[65,188,130,212])

add_block('built-in/Inport',[sys,'/',['gamma (rad)',13,'gamma_rad']])
set_param([sys,'/',['gamma (rad)',13,'gamma_rad']],...
		'Port','4',...
		'position',[165,233,230,257])

add_block('built-in/Inport',[sys,'/',['dynamic_pressure (psf)',13,'qbar']])
set_param([sys,'/',['dynamic_pressure (psf)',13,'qbar']],...
		'Port','6',...
		'position',[80,338,145,362])

add_block('built-in/Inport',[sys,'/','lateral_accel (g)'])
set_param([sys,'/','lateral_accel (g)'],...
		'Port','8',...
		'position',[70,463,135,487])

add_block('built-in/Inport',[sys,'/',['rudder_pedal (lb)',13,'drp']])
set_param([sys,'/',['rudder_pedal (lb)',13,'drp']],...
		'Port','7',...
		'position',[85,405,130,425])

add_block('built-in/Product',[sys,'/','Product2'])
set_param([sys,'/','Product2'],...
		'hide name',0,...
		'position',[380,285,405,305])

add_block('built-in/Inport',[sys,'/',['beta (rad)',13,'beta_rad']])
set_param([sys,'/',['beta (rad)',13,'beta_rad']],...
		'Port','5',...
		'position',[70,278,135,302])

add_block('built-in/Inport',[sys,'/',['true_velocity (fps)',13,'vtrue']])
set_param([sys,'/',['true_velocity (fps)',13,'vtrue']],...
		'Port','2',...
		'position',[65,128,130,152])

add_block('built-in/Discrete Transfer Fcn',[sys,'/','1//s'])
set_param([sys,'/','1//s'],...
		'Numerator','nd',...
		'Denominator','dd',...
		'Sample time','Ts',...
		'Mask Display','dpoly(nd,dd,''z'')',...
		'Mask Type','tustin')
set_param([sys,'/','1//s'],...
		'Mask Dialogue','Vector expressions for numerator and \ndenominator in the s-domain\n(Requires Signal Toolbox).|Numerator:|Denominator:|Sample time:')
set_param([sys,'/','1//s'],...
		'Mask Translate','Fs=1/@3;[nd,dd]=bilinear(@1,@2,Fs);Ts=@3;')
set_param([sys,'/','1//s'],...
		'Mask Help','This block takes expressions for numerator in the s-domain and converts them to the z-domain using tustin method.  Need signal toolbox bilinear command.',...
		'Mask Entries','[1]\/[1 0]\/0.0125\/')
set_param([sys,'/','1//s'],...
		'position',[475,447,580,493])

add_block('built-in/Outport',[sys,'/','NCV_feedback'])
set_param([sys,'/','NCV_feedback'],...
		'position',[765,146,830,164])

add_block('built-in/Sum',[sys,'/','Sum1'])
set_param([sys,'/','Sum1'],...
		'hide name',0,...
		'inputs','+-++',...
		'position',[675,132,695,178])

add_block('built-in/Unit Delay',[sys,'/','Unit Delay'])
set_param([sys,'/','Unit Delay'],...
		'orientation',2,...
		'Sample time','1/80',...
		'position',[595,507,645,523])
add_line(sys,[135,140;185,140])
add_line(sys,[140,475;160,475])
add_line(sys,[245,475;250,475])
add_line(sys,[285,475;295,475])
add_line(sys,[330,480;340,480])
add_line(sys,[135,415;195,415])
add_line(sys,[390,480;420,480])
add_line(sys,[335,415;389,415;389,470;420,470])
add_line(sys,[390,380;408,380;408,460;420,460])
add_line(sys,[460,470;465,470])
add_line(sys,[140,290;370,290])
add_line(sys,[340,150;355,150])
add_line(sys,[225,140;295,140])
add_line(sys,[135,200;270,200;270,150;295,150])
add_line(sys,[235,245;280,245;280,160;295,160])
add_line(sys,[150,350;195,350])
add_line(sys,[700,155;755,155])
add_line(sys,[520,150;665,150])
add_line(sys,[145,85;540,85;540,140;665,140])
add_line(sys,[410,295;530,295;530,160;665,160])
add_line(sys,[295,350;335,350;335,300;370,300])
add_line(sys,[585,470;605,470;605,170;665,170])
add_line(sys,[590,515;285,515;285,485;295,485])
add_line(sys,[730,155;730,515;655,515])

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
