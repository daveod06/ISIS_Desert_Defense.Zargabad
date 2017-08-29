//[bomber,[CIVILIAN,WEST,EAST,RESISTANCE],"grenadeHand"] execVM "scripts\suicideBomber.sqf"; //The unit you want to be the bomber, the sides you want the bomber to attack, classname of explosive you want to use

_bomber = _this select 0;
_targetSide = _this select 1;
_explosiveClass = _this select 2;
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
		waitUntil {(_bomber distance _pos < 15) or (!alive _bomber) or (!alive(nearUnits select 0))};
		if(_bomber distance (_nearUnits select 0) < 15)
		exitWith
		{
		_runCode = 0;
		_explosive = _explosiveClass createVehicle (position _bomber);
        [_bomber,_explosive] spawn {_bomber = _this select 0; _explosive = _this select 1; sleep 2; _bomber say3D "shout"; _explosive setDamage 1; _bomber addRating -10000000;};
		[_explosive,_bomber] spawn {_explosive = _this select 0; _bomber = _this select 1; waitUntil {!alive _bomber}; deleteVehicle _explosive;};
			if(round(random(1)) == 0) then
			{
			_explosive attachTo [_bomber,[-0.02,-0.07,0.042],"rightHand"];
			}
			else
			{
			_explosive attachTo [_bomber,[-0.02,-0.07,0.042],"leftHand"];
			};
		};
	};
	
	sleep 1;
};

