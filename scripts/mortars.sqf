// _script = [_numRounds, _mortarName, _targetUnit, _radius, _delay] execVM "scripts\mortars.sqf";
_numRounds = _this select 0;
_mortarName = _this select 1;
_targetUnit = _this select 2; // array of possible target units
_radius = _this select 3;
_delay = _this select 4;
_mortar = _mortarName;

for [{_i=0}, {_i<_numRounds}, {_i=_i+1}] do {  

	if (alive _mortar) {
		_uni = _targetUnit call BIS_fnc_selectRandom;
		//_uni = _targetUnit;
		_mortar = _mortarName; 
		_center = getposatl _uni;
		_ammo = getArtilleryAmmo [_mortar] select 0;

		_pos = [
		(_center select 0) - _radius + (2 * random _radius),
		(_center select 1) - _radius + (2 * random _radius),
		0
		];

		_mortar doArtilleryFire [
						_pos,
						_ammo,
						1];
					
	}			

	sleep _delay;

};