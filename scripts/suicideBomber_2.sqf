//[bomber,[CIVILIAN,WEST,EAST,RESISTANCE],"grenadeHand",radius] execVM "scripts\suicideBomber.sqf"; //The unit you want to be the bomber, the sides you want the bomber to attack, classname of explosive you want to use

_bomber = _this select 0;
_targetSide = _this select 1;
_explosiveClass = _this select 2;
_radius = _this select 3;
_info = [_bomber,_targetSide,_explosiveClass];
_runCode = 1;

while {alive _bomber && _runCode == 1} do
{
	_nearUnits = nearestObjects [_bomber,["CAManBase"],70];
	_nearUnits = _nearUnits - [_bomber];
	{
		if(!(side _x in _targetSide)) then {_nearUnits = _nearUnits - [_x];};
	} forEach _nearUnits;
	if(count _nearUnits != 0) then
	{
		_pos = position (_nearUnits select 0);
		_bomber doMove _pos;
		waitUntil {(_bomber distance _pos < _radius) or (!alive _bomber) or (!alive(_nearUnits select 0))};
		if(_bomber distance (_nearUnits select 0) < _radius)
		exitWith
		{
		_runCode = 0;
		_explosive = _explosiveClass createVehicle (position _bomber);
        _explosive_bag = "satchelcharge_remote_mag" createVehicle (position _bomber);
        [_bomber,_explosive] spawn {_bomber = _this select 0; _explosive = _this select 1; sleep 0.5; _bomber say3D "shout"; _explosive setDamage 1; _bomber addRating -10000000;};
		[_explosive,_bomber,_explosive_bag] spawn {_explosive = _this select 0; _bomber = _this select 1; _explosive = _this select 2; waitUntil {!alive _bomber}; deleteVehicle _explosive; deleteVehicle _explosive_bag;};
			if(round(random(1)) == 0) then
			{
			_explosive_bag attachTo [_bomber,[-0.02,-0.07,0.042],"rightHand"];
			}
			else
			{
			_explosive_bag attachTo [_bomber,[-0.02,-0.07,0.042],"leftHand"];
			};
		};
	};
	
	sleep 1;
};

