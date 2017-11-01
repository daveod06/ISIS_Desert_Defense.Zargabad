// Civilians & Traffic
call compile preprocessFileLineNumbers "scripts\Engima\Civilians\Init.sqf";
call compile preprocessFileLineNumbers "scripts\Engima\Traffic\Init.sqf";

//EOS Dynamic Combat System
[]execVM "scripts\eos\OpenMe.sqf";

// IED script
detonateBombs = false;
iedMkr=["iedMkr0","iedMkr1","iedMkr2"];
//[iedMkr,detonateBombs] execVM "scripts\ied.sqf";
[] execVM "scripts\ied.sqf";