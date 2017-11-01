// _script = [_spawnPos,_type,_rot,_side,_landingPosArray,_exitPos,_evacGroup] execVM "scripts\spawnEvacChopper.sqf";
if(!isServer)exitWith{};
_spawnPos = _this select 0;
_type = _this select 1;
_rot = _this select 2;
_side = _this select 3;
_landingPosArray = _this select 4;
_exitPos = _this select 5;
_evacGroup = _this select 6;

_landingPos = _landingPosArray call BIS_fnc_selectRandom;
_spawnedVehicle = [_spawnPos, _rot, _type, _side] call BIS_fnc_spawnVehicle;
_heli = _spawnedVehicle select 0;
_heliCrew = _spawnedVehicle select 1;
_heliGroup = _spawnedVehicle select 2;
_heliGroup setCombatMode "RED";
_heliGroup setBehaviour "AWARE";
{(driver _heli) disableAI _x} forEach ["TARGET","AUTOTARGET","FSM","AUTOCOMBAT"];
{(commander _heli) disableAI _x} forEach ["TARGET","AUTOTARGET","FSM","AUTOCOMBAT"];
//{_heliGroup disableAI _x} forEach ["TARGET","AUTOTARGET","FSM","AUTOCOMBAT"];
_evacGroupLeader = leader _evacGroup;

wp0Evac = _evacGroup addwaypoint [_landingPos, 0];
wp0Evac setwaypointtype "GETIN";
[_evacGroup, 0] waypointAttachVehicle _heli;

wp0Heli = _heliGroup addwaypoint [_landingPos, 250];
wp0Heli setwaypointtype "MOVE";

wp1Heli = _heliGroup addwaypoint [_landingPos, 0];
wp1Heli setwaypointtype "LOAD";
[_heliGroup, 1] waypointAttachVehicle _evacGroupLeader;

wp1Heli synchronizeWaypoint [wp0Evac];

wp2Heli = _heliGroup addwaypoint [_exitPos, 500];
wp2Heli setwaypointtype "MOVE";
_heli
