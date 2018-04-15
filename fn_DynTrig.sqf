/*---------------------------------------------------------------------------------------
Dynamic Entry trigger script, by OpUs-Nebula

PARAMETERS:
0. ThisList
1. ThisTrigger
Both explained very well on the BI-WIKI:
https://community.bistudio.com/wiki/setTriggerStatements

If using EDEN editor for triggers:
Paste the following into the condition box,
[ThisList,ThisTrigger] call TAG_fnc_DynTrig

Feel free to Include credit in your mission if you found this script helpful!
---------------------------------------------------------------------------------------*/
params  ["_List","_Trg"];
private ["_Ret","_OldList"];
_Men     = [];
if (isNil {_Trg getVariable "Storage"}) then 
{
    _Trg setVariable ["Storage",_Men];
	_OldList = _Men;
} 
else 
{
    _OldList = _Trg getVariable "Storage";
};

{
    if (!(_x iskindOf "Man")) then {
	    _Crew = crew _x;
		{
            if ((_x isKindOf "Man") && (Alive _x)) then 
	        {
	            _Men append [_x];
	        };
		} forEach _Crew;	
	};
	if (_x isKindOf "Man") then 
	{
	    _Men append [_x];
	};
} forEach _List;

switch (true) do {
    case (_OldList isEqualTo _Men): 
	{ 
//DEBUG	    hint format ["RETURN: FALSE, OLD: %1, ACTUAL: %2",_Men,_OldList];
        _Ret = false;		
	};
	case !(_OldList isEqualTo _Men): 
	{ 
//DEBUG	    hint format ["RETURN: TRUE, UNITS: %1",_Men];
//DEBUG		"C_Offroad_01_F" createVehicle position player;
		_Trg setVariable ["Storage",_Men];
        _Ret = true;		
	};
	default 
	{ 
	    hint format ["RETURN: NOT DEFINED, UNITS: %1",_Men]; 
	};
};
_Ret