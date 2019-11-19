function [ret,x0,str]=MCV_cmd(t,x,u,flag);
%MCV_CMD	is the M-file description of the SIMULINK system named MCV_CMD.
%	The block-diagram can be displayed by typing: MCV_CMD.
%
%	SYS=MCV_CMD(T,X,U,FLAG) returns depending on FLAG certain
%	system values given time point, T, current state vector, X,
%	and input vector, U.
%	FLAG is used to indicate the type of output to be returned in SYS.
%
%	Setting FLAG=1 causes MCV_CMD to return state derivatives, FLAG=2
%	discrete states, FLAG=3 system outputs and FLAG=4 next sample
%	time. For more information and other options see SFUNC.
%
%	Calling MCV_CMD with a FLAG of zero:
%	[SIZES]=MCV_CMD([],[],[],0),  returns a vector, SIZES, which
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
     set_param(sys,'Location',[100,100,923,710])
     open_system(sys)
end;
set_param(sys,'algorithm',     'RK-45')
set_param(sys,'Start time',    'min(T)')
set_param(sys,'Stop time',     'max(T)')
set_param(sys,'Min step size', '0.0125')
set_param(sys,'Max step size', '0.0125')
set_param(sys,'Relative error','1e-3')
set_param(sys,'Return vars',   '')

add_block('built-in/Gain',[sys,'/','deg//rad'])
set_param([sys,'/','deg//rad'],...
		'Gain','.0174',...
		'position',[330,444,380,476])

add_block('built-in/Gain',[sys,'/','stick_gain'])
set_param([sys,'/','stick_gain'],...
		'Gain','.349',...
		'position',[315,355,360,385])

add_block('built-in/MATLAB Fcn',[sys,'/','pitch_shaping'])
set_param([sys,'/','pitch_shaping'],...
		'MATLAB Fcn','pitch_shaping',...
		'position',[195,355,280,385])

add_block('built-in/Sum',[sys,'/','Sum2'])
set_param([sys,'/','Sum2'],...
		'hide name',0,...
		'position',[410,365,430,385])

add_block('built-in/Switch',[sys,'/',['choose smaller',13,'of two']])
set_param([sys,'/',['choose smaller',13,'of two']],...
		'position',[535,269,560,301])

add_block('built-in/Sum',[sys,'/','Sum1'])
set_param([sys,'/','Sum1'],...
		'hide name',0,...
		'inputs','++-',...
		'position',[350,167,370,203])

add_block('built-in/Product',[sys,'/','Product'])
set_param([sys,'/','Product'],...
		'hide name',0,...
		'position',[625,270,650,290])

add_block('built-in/Sum',[sys,'/','Sum5'])
set_param([sys,'/','Sum5'],...
		'orientation',1,...
		'hide name',0,...
		'inputs','+-',...
		'position',[590,200,610,220])

add_block('built-in/Constant',[sys,'/','Constant'])
set_param([sys,'/','Constant'],...
		'position',[535,140,555,160])

add_block('built-in/Sum',[sys,'/','Sum4'])
set_param([sys,'/','Sum4'],...
		'hide name',0,...
		'position',[690,275,710,295])

add_block('built-in/Product',[sys,'/','Product1'])
set_param([sys,'/','Product1'],...
		'hide name',0,...
		'position',[575,360,600,380])

add_block('built-in/Sum',[sys,'/','Sum3'])
set_param([sys,'/','Sum3'],...
		'hide name',0,...
		'inputs','-+',...
		'position',[450,275,470,295])

add_block('built-in/Note',[sys,'/','1-F_alp-loop'])
set_param([sys,'/','1-F_alp-loop'],...
		'position',[660,170,665,175])

add_block('built-in/Sum',[sys,'/','Sum6'])
set_param([sys,'/','Sum6'],...
		'hide name',0,...
		'inputs','-+',...
		'position',[320,105,340,125])

add_block('built-in/Sum',[sys,'/','Sum'])
set_param([sys,'/','Sum'],...
		'hide name',0,...
		'inputs','+-',...
		'position',[250,165,270,185])

add_block('built-in/Note',[sys,'/','Alp_lim'])
set_param([sys,'/','Alp_lim'],...
		'position',[200,145,205,150])

add_block('built-in/Look Up Table',[sys,'/','F_alp-loop'])
set_param([sys,'/','F_alp-loop'],...
		'Input_Values','[0.0 25/57.3 30/57.3  70/57.3]',...
		'Output_Values','[0.0  0.0 1.0 1.0]',...
		'position',[410,97,450,133])

add_block('built-in/Inport',[sys,'/','mom_eq_limit'])
set_param([sys,'/','mom_eq_limit'],...
		'Port','2',...
		'position',[85,160,125,180])

add_block('built-in/Inport',[sys,'/',['alpha (rad)',13,'alpha_rad']])
set_param([sys,'/',['alpha (rad)',13,'alpha_rad']],...
		'Port','3',...
		'position',[80,205,120,225])

add_block('built-in/Inport',[sys,'/',['pitch_stick (in)',13,'dep']])
set_param([sys,'/',['pitch_stick (in)',13,'dep']],...
		'Port','6',...
		'position',[85,358,125,382])

add_block('built-in/Inport',[sys,'/','pitch_trim (deg//s)'])
set_param([sys,'/','pitch_trim (deg//s)'],...
		'Port','7',...
		'position',[115,448,155,472])

add_block('built-in/Outport',[sys,'/','MCV_command'])
set_param([sys,'/','MCV_command'],...
		'position',[760,275,780,295])

add_block('built-in/Inport',[sys,'/',['alpha dot (rad//s)',13,'alpdot_rps']])
set_param([sys,'/',['alpha dot (rad//s)',13,'alpdot_rps']],...
		'Port','5',...
		'position',[75,295,115,315])

add_block('built-in/Inport',[sys,'/',['pitch_rate (rad//s)',13,'q_rps']])
set_param([sys,'/',['pitch_rate (rad//s)',13,'q_rps']],...
		'position',[85,97,120,123])

add_block('built-in/Inport',[sys,'/',['MCV_feedback',13,'(rad//s)']])
set_param([sys,'/',['MCV_feedback',13,'(rad//s)']],...
		'Port','4',...
		'position',[185,246,220,264])
add_line(sys,[130,170;240,170])
add_line(sys,[125,215;199,215;199,180;240,180])
add_line(sys,[275,175;340,175])
add_line(sys,[225,255;320,255;320,185;340,185])
add_line(sys,[120,305;330,305;330,195;340,195])
add_line(sys,[130,370;185,370])
add_line(sys,[285,370;305,370])
add_line(sys,[365,370;400,370])
add_line(sys,[385,460;392,460;392,380;400,380])
add_line(sys,[375,185;425,185;425,280;440,280])
add_line(sys,[475,285;525,285])
add_line(sys,[425,185;495,185;495,275;525,275])
add_line(sys,[435,375;490,375;490,295;525,295])
add_line(sys,[655,280;680,280])
add_line(sys,[715,285;750,285])
add_line(sys,[435,375;435,290;440,290])
add_line(sys,[160,460;320,460])
add_line(sys,[125,110;310,110])
add_line(sys,[345,115;400,115])
add_line(sys,[565,285;615,285])
add_line(sys,[600,225;600,275;615,275])
add_line(sys,[455,115;605,115;605,190])
add_line(sys,[560,150;595,150;595,190])
add_line(sys,[490,375;565,375])
add_line(sys,[605,370;675,370;675,290;680,290])
add_line(sys,[475,115;475,365;565,365])
add_line(sys,[295,175;295,120;310,120])

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
