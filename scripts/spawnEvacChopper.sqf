// _script = [_spawnPos,_type,_rot,_side,_landingPosArray,_exitPos,_evacGroup,_landInHotLZ] execVM "scripts\spawnEvacChopper.sqf";
if(!isServer)exitWith{};
_spawnPos = _this select 0;
_type = _this select 1;
_rot = _this select 2;
_side = _this select 3;
_landingPosArray = _this select 4;
_exitPos = _this select 5;
_evacGroup = _this select 6;
_landInHotLZ = _this select 7;

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

//_sidesArray = ["WEST","EAST","Resistance","Civilian"];
//_friendlyFactionsArray = [];
//{
//    if ([_side, _x] call BIS_fnc_sideIsFriendly) then
//    {
//        _friendlyFactionsArray append [_x];
//    };
//} forEach _sidesArray;

_sideArray = [_side] append [" SEIZED"];
_sideStr = _sideArray joinString "";
_LZhot = false;
_waitLoop = 1;

if (!_landInHotLZ) then
{
    _LZTrigger createTrigger ["EmptyDetector", _landingPos, TRUE];
    _LZTrigger setTriggerArea [100, 100, 0, false, 20];
    _LZTrigger setTriggerActivation [_sideStr, "PRESENT", false];
};

wp0Evac = _evacGroup addwaypoint [_landingPos, 0];
wp0Evac setwaypointtype "GETIN";
[_evacGroup, 0] waypointAttachVehicle _heli;

wp0Heli = _heliGroup addwaypoint [_landingPos, 250];
wp0Heli setwaypointtype "MOVE";

if (!_landInHotLZ) then
    while {_waitLoop == 1} do
    {
        _LZhot = triggerActivated _LZTrigger;
        if !(_LZhot) then
        {
            _waitLoop = 0;
            wp1Heli = _heliGroup addwaypoint [_landingPos, 0];
            wp1Heli setwaypointtype "LOAD";
            [_heliGroup, 1] waypointAttachVehicle _evacGroupLeader;
            wp1Heli synchronizeWaypoint [wp0Evac];
        
            wp2Heli = _heliGroup addwaypoint [_exitPos, 500];
            wp2Heli setwaypointtype "MOVE";
        };
        sleep 2.0;
    };
}
else
{
    wp1Heli = _heliGroup addwaypoint [_landingPos, 0];
    wp1Heli setwaypointtype "LOAD";
    [_heliGroup, 1] waypointAttachVehicle _evacGroupLeader;
    wp1Heli synchronizeWaypoint [wp0Evac];
    
    wp2Heli = _heliGroup addwaypoint [_exitPos, 500];
    wp2Heli setwaypointtype "MOVE";
};

_heli
