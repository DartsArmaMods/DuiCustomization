#include "script_component.hpp"

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

// private _category = [QUOTE(MOD_NAME), LLSTRING(displayName)];

// #include "initSettings.inc.sqf"
// #include "initKeybinds.inc.sqf"

// No vanilla event for changing teams, so just use ACE
["ace_interaction_joinedTeam", {
    params ["_unit"];
    if (!local _unit) exitWith {};
    _unit setVariable ["dui_customHexColor", nil, true];
    _unit setVariable ["dui_customRGBColor", nil, true];
}] call CBA_fnc_addEventHandler;
