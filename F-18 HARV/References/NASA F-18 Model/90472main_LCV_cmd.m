function [ret,x0,str]=LCV_cmd(t,x,u,flag);
%LCV_CMD	is the M-file description of the SIMULINK system named LCV_CMD.
%	The block-diagram can be displayed by typing: LCV_CMD.
%
%	SYS=LCV_CMD(T,X,U,FLAG) returns depending on FLAG certain
%	system values given time point, T, current state vector, X,
%	and input vector, U.
%	FLAG is used to indicate the type of output to be returned in SYS.
%
%	Setting FLAG=1 causes LCV_CMD to return state derivatives, FLAG=2
%	discrete states, FLAG=3 system outputs and FLAG=4 next sample
%	time. For more information and other options see SFUNC.
%
%	Calling LCV_CMD with a FLAG of zero:
%	[SIZES]=LCV_CMD([],[],[],0),  returns a vector, SIZES, which
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
     set_param(sys,'Location',[157,157,1120,596])
     open_system(sys)
end;
set_param(sys,'algorithm',     'RK-45')
set_param(sys,'Start time',    'min(T)')
set_param(sys,'Stop time',     'max(T)')
set_param(sys,'Min step size', '0.0125')
set_param(sys,'Max step size', '0.0125')
set_param(sys,'Relative error','1e-3')
set_param(sys,'Return vars',   '')

add_block('built-in/Sum',[sys,'/','Sum2'])
set_param([sys,'/','Sum2'],...
		'hide name',0,...
		'position',[775,105,795,125])

add_block('built-in/Outport',[sys,'/','LCV_command'])
set_param([sys,'/','LCV_command'],...
		'position',[845,105,880,125])


%     Subsystem  'Variable_Limiter'.

new_system([sys,'/','Variable_Limiter'])
set_param([sys,'/','Variable_Limiter'],'Location',[65,342,544,709])

add_block('built-in/Outport',[sys,'/','Variable_Limiter/out_1'])
set_param([sys,'/','Variable_Limiter/out_1'],...
		'position',[255,70,275,90])

add_block('built-in/Mux',[sys,'/','Variable_Limiter/Mux'])
set_param([sys,'/','Variable_Limiter/Mux'],...
		'inputs','3',...
		'position',[75,64,105,96])

add_block('built-in/MATLAB Fcn',[sys,'/','Variable_Limiter/MATLAB Fcn'])
set_param([sys,'/','Variable_Limiter/MATLAB Fcn'],...
		'MATLAB Fcn','var_limit',...
		'Output Width','1',...
		'position',[160,61,225,99])

add_block('built-in/Inport',[sys,'/','Variable_Limiter/in_3'])
set_param([sys,'/','Variable_Limiter/in_3'],...
		'Port','3',...
		'position',[25,130,45,150])

add_block('built-in/Inport',[sys,'/','Variable_Limiter/in_1'])
set_param([sys,'/','Variable_Limiter/in_1'],...
		'position',[25,20,45,40])

add_block('built-in/Inport',[sys,'/','Variable_Limiter/in_2'])
set_param([sys,'/','Variable_Limiter/in_2'],...
		'Port','2',...
		'position',[25,70,45,90])
add_line([sys,'/','Variable_Limiter'],[50,140;65,90])
add_line([sys,'/','Variable_Limiter'],[50,80;65,80])
add_line([sys,'/','Variable_Limiter'],[230,80;245,80])
add_line([sys,'/','Variable_Limiter'],[50,30;65,70])
add_line([sys,'/','Variable_Limiter'],[110,80;150,80])
set_param([sys,'/','Variable_Limiter'],...
		'Mask Display','plot([0 0],[-1 1],[-1 1],[0 0],[-.9 -.6 .6 .9],[-.6 -.6 .6 .6])',...
		'Mask Type','variable limiter',...
		'Mask Help','input1: signal, input2 upper limit, input3 lower limit')


%     Finished composite block 'Variable_Limiter'.

set_param([sys,'/','Variable_Limiter'],...
		'position',[685,85,735,135])

add_block('built-in/Inport',[sys,'/','roll_trim (in)'])
set_param([sys,'/','roll_trim (in)'],...
		'Port','5',...
		'position',[160,366,200,384])

add_block('built-in/Gain',[sys,'/','Gain4'])
set_param([sys,'/','Gain4'],...
		'hide name',0,...
		'Gain','.0174',...
		'position',[285,358,335,392])

add_block('built-in/Inport',[sys,'/',['LCV_command upper limit',13,'LCVcmd_ul']])
set_param([sys,'/',['LCV_command upper limit',13,'LCVcmd_ul']],...
		'Port','3',...
		'position',[260,275,315,295])

add_block('built-in/Inport',[sys,'/',['LCV_command lower limit',13,'LCVcmd_ll']])
set_param([sys,'/',['LCV_command lower limit',13,'LCVcmd_ll']],...
		'Port','2',...
		'position',[255,220,310,240])

add_block('built-in/Abs',[sys,'/','Abs'])
set_param([sys,'/','Abs'],...
		'position',[100,140,125,160])

add_block('built-in/Inport',[sys,'/',['alpha (rad)',13,'alpha_rad']])
set_param([sys,'/',['alpha (rad)',13,'alpha_rad']],...
		'Port','4',...
		'position',[30,140,65,160])

add_block('built-in/Inport',[sys,'/',['roll_stick (in)',13,'dap ']])
set_param([sys,'/',['roll_stick (in)',13,'dap ']],...
		'position',[70,65,115,85])

add_block('built-in/Product',[sys,'/','Product'])
set_param([sys,'/','Product'],...
		'hide name',0,...
		'position',[315,70,340,90])

add_block('built-in/Look Up Table',[sys,'/','Kroll_hi'])
set_param([sys,'/','Kroll_hi'],...
		'Input_Values','[0 30 70 90]',...
		'Output_Values','[1.222 1.222 0.297 0.297]',...
		'position',[230,133,265,167])

add_block('built-in/Gain',[sys,'/','Gain'])
set_param([sys,'/','Gain'],...
		'Gain','180/pi',...
		'position',[145,123,195,177])

add_block('built-in/Discrete Transfer Fcn',[sys,'/',['lead-lag',13,'(.4s+1)//(.15s+1)']])
set_param([sys,'/',['lead-lag',13,'(.4s+1)//(.15s+1)']],...
		'move name',0,...
		'Numerator','[2.6 -2.52]',...
		'Denominator','[1 -0.92]',...
		'Sample time','.0125',...
		'position',[520,74,595,116])


%     Subsystem  'Variable_Limiter1'.

new_system([sys,'/','Variable_Limiter1'])
set_param([sys,'/','Variable_Limiter1'],'Location',[65,342,544,709])

add_block('built-in/Outport',[sys,'/','Variable_Limiter1/out_1'])
set_param([sys,'/','Variable_Limiter1/out_1'],...
		'position',[255,70,275,90])

add_block('built-in/Mux',[sys,'/','Variable_Limiter1/Mux'])
set_param([sys,'/','Variable_Limiter1/Mux'],...
		'inputs','3',...
		'position',[75,64,105,96])

add_block('built-in/MATLAB Fcn',[sys,'/','Variable_Limiter1/MATLAB Fcn'])
set_param([sys,'/','Variable_Limiter1/MATLAB Fcn'],...
		'MATLAB Fcn','var_limit',...
		'Output Width','1',...
		'position',[160,61,225,99])

add_block('built-in/Inport',[sys,'/','Variable_Limiter1/in_3'])
set_param([sys,'/','Variable_Limiter1/in_3'],...
		'Port','3',...
		'position',[25,130,45,150])

add_block('built-in/Inport',[sys,'/','Variable_Limiter1/in_1'])
set_param([sys,'/','Variable_Limiter1/in_1'],...
		'position',[25,20,45,40])

add_block('built-in/Inport',[sys,'/','Variable_Limiter1/in_2'])
set_param([sys,'/','Variable_Limiter1/in_2'],...
		'Port','2',...
		'position',[25,70,45,90])
add_line([sys,'/','Variable_Limiter1'],[50,140;65,90])
add_line([sys,'/','Variable_Limiter1'],[50,80;65,80])
add_line([sys,'/','Variable_Limiter1'],[230,80;245,80])
add_line([sys,'/','Variable_Limiter1'],[50,30;65,70])
add_line([sys,'/','Variable_Limiter1'],[110,80;150,80])
set_param([sys,'/','Variable_Limiter1'],...
		'Mask Display','plot([0 0],[-1 1],[-1 1],[0 0],[-.9 -.6 .6 .9],[-.6 -.6 .6 .6])',...
		'Mask Type','variable limiter',...
		'Mask Help','input1: signal, input2 upper limit, input3 lower limit')


%     Finished composite block 'Variable_Limiter1'.

set_param([sys,'/','Variable_Limiter1'],...
		'position',[430,70,480,120])

add_block('built-in/MATLAB Fcn',[sys,'/','roll_shaping'])
set_param([sys,'/','roll_shaping'],...
		'MATLAB Fcn','roll_shaping',...
		'position',[175,57,250,93])
add_line(sys,[200,150;220,150])
add_line(sys,[270,150;285,150;285,85;305,85])
add_line(sys,[255,75;305,75])
add_line(sys,[205,375;275,375])
add_line(sys,[120,75;165,75])
add_line(sys,[340,375;760,375;760,120;765,120])
add_line(sys,[800,115;835,115])
add_line(sys,[315,230;615,230;615,110;675,110])
add_line(sys,[320,285;635,285;635,125;675,125])
add_line(sys,[70,150;90,150])
add_line(sys,[130,150;135,150])
add_line(sys,[740,110;765,110])
add_line(sys,[600,95;675,95])
add_line(sys,[485,95;510,95])
add_line(sys,[345,80;420,80])
add_line(sys,[355,230;355,95;420,95])
add_line(sys,[380,285;380,110;420,110])

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
