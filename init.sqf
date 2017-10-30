// Civilians & Traffic
call compile preprocessFileLineNumbers "scripts\Engima\Civilians\Init.sqf";
call compile preprocessFileLineNumbers "scripts\Engima\Traffic\Init.sqf";

//EOS Dynamic Combat System
[]execVM "scripts\eos\OpenMe.sqf";

// IED script
iedMkr=["iedMkr0","iedMkr1","iedMkr2"];
[iedMkr] execVM "scripts\ied.sqf";
