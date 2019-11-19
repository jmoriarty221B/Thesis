	function windb = WindField(height,phir,thetar,psir)%	FLIGHT Wind Field Interpolation for 3-D wind as a Function of Altitude%   Uses Direction Cosine (Rotation) Matrix from Euler Angles%	November 11, 2018   %	===============================================================%	Copyright 2006-2018 by ROBERT F. STENGEL.  All rights reserved.%   Called by:%       EoM.m%       EoMQ.m	windh	=	[-10 0 100 200 500 1000 2000 4000 8000 16000];	% Height, m	windx	=	[0 0 0 0 0 0 0 0 0 0];	% Northerly wind, m/s	windy	=	[0 0 0 0 0 0 0 0 0 0];	% Easterly wind, m/s	windz	=	[0 0 0 0 0 0 0 0 0 0];	% Vertical wind. m/s		winde	=	[interp1(windh,windx,height)				interp1(windh,windy,height)				interp1(windh,windz,height)];	% Earth-relative frame	HEB		=	DCM(phir,thetar,psir);	windb	=	HEB * winde;					% Body-axis frame