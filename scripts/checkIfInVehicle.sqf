// _script = [_targetVehicle] execVM "scripts\checkIfInVehicle.sqf";
if(!isServer)exitWith{};
_targetVehicle = _this select 0;

allInTheVehicle = false;
while {(not allInTheVehicle)} do  
{
	allInTheVehicle = true;
  	{
    	if (!alive _x || vehicle _x != _targetVehicle) then {allInTheVehicle = false;}
  	} forEach playableUnits;
  	sleep 1.0;
};
globalAllInTheVehicle = true;