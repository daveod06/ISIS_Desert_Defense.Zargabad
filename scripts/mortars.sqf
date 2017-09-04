// _script = [50, isis_base_mortar_1, [us_leader], 150, 20] execVM "scripts\mortars.sqf";
_numRounds = _this select 0;
_mortarName = _this select 1;
_targetUnit = _this select 2; // array of possible target units
_radius = _this select 3;
_delay = _this select 4;


for "_i" from 1 to _numRounds do {  //--- set range of how many cycles you want the mortars to run before they stop firing. 

	if (alive _mortarName) {
		_uni = _targetUnit call BIS_fnc_selectRandom;
		//_uni = _targetUnit;
		_mortar = _mortarName;  //--- selects a random mortar unit out of array. This can be edited to add more mortars. 
		_center = getposatl _uni;  		//--- central point around which the mortar rounds will hit
		_ammo = getArtilleryAmmo [_mortar] select 0;
		//_ammo = "R_60mm_HE";

		_pos = [
		(_center select 0) - _radius + (2 * random _radius),
		(_center select 1) - _radius + (2 * random _radius),
		0
		];

		//hint str _pos;
		//hint str _ammo;

		_mortar doArtilleryFire [
						_pos,
						_ammo,
						1 //--- number of shots per turn per unit
					];
	}					
						

sleep _delay; //--- delay between rounds

};