#include "..\script_component.hpp"
/*
 * Authors: DartRuffian
 * Assigns the players's custom color as their fireteam color.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [params] call duic_main_fnc_assignCustomColor
 *
 * Public: No
 */

private _color = profileNamespace getVariable [QGVAR(customColor), ""];
if (_color == "") exitWith {
    [LLSTRING(noColorSet), 1.5] call ace_common_fnc_displayTextStructured;
};

ace_player setVariable ["dui_customHexColor", _color, true];
ace_player setVariable ["dui_customRGBColor", _color call CBA_fnc_colorHEXtoDecimal, true];
