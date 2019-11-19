function [ret,x0,str]=myblocks(t,x,u,flag);
%MYBLOCKS	is the M-file description of the SIMULINK system named MYBLOCKS.
%	The block-diagram can be displayed by typing: MYBLOCKS.
%
%	SYS=MYBLOCKS(T,X,U,FLAG) returns depending on FLAG certain
%	system values given time point, T, current state vector, X,
%	and input vector, U.
%	FLAG is used to indicate the type of output to be returned in SYS.
%
%	Setting FLAG=1 causes MYBLOCKS to return state derivatives, FLAG=2
%	discrete states, FLAG=3 system outputs and FLAG=4 next sample
%	time. For more information and other options see SFUNC.
%
%	Calling MYBLOCKS with a FLAG of zero:
%	[SIZES]=MYBLOCKS([],[],[],0),  returns a vector, SIZES, which
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
     set_param(sys,'Location',[672,63,1117,390])
     open_system(sys)
end;
set_param(sys,'algorithm',     'RK-45')
set_param(sys,'Start time',    '0.0')
set_param(sys,'Stop time',     '999999')
set_param(sys,'Min step size', '0.0001')
set_param(sys,'Max step size', '10')
set_param(sys,'Relative error','1e-3')
set_param(sys,'Return vars',   '')

add_block('built-in/Saturation',[sys,'/','Saturation'])
set_param([sys,'/','Saturation'],...
		'position',[30,125,55,145])

add_block('built-in/Gain',[sys,'/','Gain'])
set_param([sys,'/','Gain'],...
		'position',[25,10,45,30])

add_block('built-in/Switch',[sys,'/','Switch'])
set_param([sys,'/','Switch'],...
		'position',[75,9,100,41])


%     Subsystem  'Variable_Limiter'.

new_system([sys,'/','Variable_Limiter'])
set_param([sys,'/','Variable_Limiter'],'Location',[65,342,368,497])

add_block('built-in/Inport',[sys,'/','Variable_Limiter/in_2'])
set_param([sys,'/','Variable_Limiter/in_2'],...
		'Port','2',...
		'position',[15,70,35,90])

add_block('built-in/Inport',[sys,'/','Variable_Limiter/in_1'])
set_param([sys,'/','Variable_Limiter/in_1'],...
		'position',[25,45,45,65])

add_block('built-in/Inport',[sys,'/','Variable_Limiter/in_3'])
set_param([sys,'/','Variable_Limiter/in_3'],...
		'Port','3',...
		'position',[25,110,45,130])

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
add_line([sys,'/','Variable_Limiter'],[50,120;65,90])
add_line([sys,'/','Variable_Limiter'],[40,80;65,80])
add_line([sys,'/','Variable_Limiter'],[230,80;245,80])
add_line([sys,'/','Variable_Limiter'],[50,55;65,70])
add_line([sys,'/','Variable_Limiter'],[110,80;150,80])
set_param([sys,'/','Variable_Limiter'],...
		'Mask Display','plot([0 0],[-1 1],[-1 1],[0 0],[-.9 -.6 .6 .9],[-.6 -.6 .6 .6])',...
		'Mask Type','variable limiter',...
		'Mask Help','input1: signal, input2 upper limit, input3 lower limit')


%     Finished composite block 'Variable_Limiter'.

set_param([sys,'/','Variable_Limiter'],...
		'position',[130,5,180,55])

add_block('built-in/Sum',[sys,'/','Sum'])
set_param([sys,'/','Sum'],...
		'position',[220,20,240,40])

add_block('built-in/From Workspace',[sys,'/','From Workspace'])
set_param([sys,'/','From Workspace'],...
		'position',[25,67,65,93])

add_block('built-in/Integrator',[sys,'/','Integrator'])
set_param([sys,'/','Integrator'],...
		'position',[135,75,155,95])

add_block('built-in/MATLAB Fcn',[sys,'/','MATLAB Fcn'])
set_param([sys,'/','MATLAB Fcn'],...
		'position',[15,182,90,218])

add_block('built-in/Product',[sys,'/','Product'])
set_param([sys,'/','Product'],...
		'position',[115,215,140,235])

add_block('built-in/Look Up Table',[sys,'/','Look Up Table'])
set_param([sys,'/','Look Up Table'],...
		'position',[190,215,215,235])

add_block('built-in/Rate Limiter',[sys,'/','Rate Limiter'])
set_param([sys,'/','Rate Limiter'],...
		'position',[45,250,70,270])

add_block('built-in/Mux',[sys,'/','Mux'])
set_param([sys,'/','Mux'],...
		'inputs','3',...
		'position',[125,264,155,296])

add_block('built-in/Discrete Transfer Fcn',[sys,'/',['S to Z ',13,'tustin']])
set_param([sys,'/',['S to Z ',13,'tustin']],...
		'Numerator','nd',...
		'Denominator','dd',...
		'Sample time','Ts',...
		'Mask Display','dpoly(nd,dd,''z'')',...
		'Mask Type','tustin')
set_param([sys,'/',['S to Z ',13,'tustin']],...
		'Mask Dialogue','Vector expressions for numerator and \ndenominator in the s-domain\n(Requires Signal Toolbox).|Numerator:|Denominator:|Sample time:')
set_param([sys,'/',['S to Z ',13,'tustin']],...
		'Mask Translate','Fs=1/@3;[nd,dd]=bilinear(@1,@2,Fs);Ts=@3;')
set_param([sys,'/',['S to Z ',13,'tustin']],...
		'Mask Help','This block takes expressions for numerator in the s-domain and converts them to the z-domain using tustin method.  Need signal toolbox bilinear command.')
set_param([sys,'/',['S to Z ',13,'tustin']],...
		'Mask Entries','[1]\/[1 1]\/0.0125\/',...
		'position',[265,76,380,124])


%     Subsystem  'vector sub2'.

new_system([sys,'/','vector sub2'])
set_param([sys,'/','vector sub2'],'Location',[40,340,452,590])

add_block('built-in/Inport',[sys,'/','vector sub2/in_2'])
set_param([sys,'/','vector sub2/in_2'],...
		'Port','2',...
		'position',[25,125,45,145])

add_block('built-in/Outport',[sys,'/','vector sub2/out_1'])
set_param([sys,'/','vector sub2/out_1'],...
		'position',[335,105,355,125])

add_block('built-in/Inport',[sys,'/','vector sub2/in_1'])
set_param([sys,'/','vector sub2/in_1'],...
		'position',[25,75,45,95])

add_block('built-in/Demux',[sys,'/','vector sub2/Demux'])
set_param([sys,'/','vector sub2/Demux'],...
		'outputs','3',...
		'position',[75,69,115,101])

add_block('built-in/Demux',[sys,'/','vector sub2/Demux1'])
set_param([sys,'/','vector sub2/Demux1'],...
		'outputs','3',...
		'position',[75,119,115,151])

add_block('built-in/Sum',[sys,'/','vector sub2/Sum1'])
set_param([sys,'/','vector sub2/Sum1'],...
		'inputs','+-',...
		'position',[200,120,215,140])

add_block('built-in/Sum',[sys,'/','vector sub2/Sum'])
set_param([sys,'/','vector sub2/Sum'],...
		'inputs','+-',...
		'position',[200,70,215,90])

add_block('built-in/Sum',[sys,'/','vector sub2/Sum2'])
set_param([sys,'/','vector sub2/Sum2'],...
		'inputs','+-',...
		'position',[200,165,215,185])

add_block('built-in/Mux',[sys,'/','vector sub2/Mux'])
set_param([sys,'/','vector sub2/Mux'],...
		'inputs','3',...
		'position',[275,99,305,131])
add_line([sys,'/','vector sub2'],[50,135;65,135])
add_line([sys,'/','vector sub2'],[310,115;325,115])
add_line([sys,'/','vector sub2'],[50,85;65,85])
add_line([sys,'/','vector sub2'],[120,75;190,75])
add_line([sys,'/','vector sub2'],[120,125;190,85])
add_line([sys,'/','vector sub2'],[120,85;190,125])
add_line([sys,'/','vector sub2'],[120,135;190,135])
add_line([sys,'/','vector sub2'],[120,95;190,170])
add_line([sys,'/','vector sub2'],[120,145;190,180])
add_line([sys,'/','vector sub2'],[220,80;265,105])
add_line([sys,'/','vector sub2'],[220,130;265,115])
add_line([sys,'/','vector sub2'],[220,175;265,125])
set_param([sys,'/','vector sub2'],...
		'Mask Display','')


%     Finished composite block 'vector sub2'.

set_param([sys,'/','vector sub2'],...
		'position',[175,119,205,181])

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
