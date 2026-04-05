#include "..\script_component.hpp"
/*
 * Authors: DartRuffian
 * Handles the onLoad for the set custom color display.
 *
 * Arguments:
 * 0: Argument (optional, default: value) <OBJECT>
 *
 * Return Value:
 * Return description <NONE>
 *
 * Example:
 * [params] call PREFIX_main_fnc_setColorOnLoad
 *
 * Public: No
 */

params ["_display"];
TRACE_1("fnc_setColorOnLoad",_display);

uiNamespace setVariable [QGVAR(RscSetColor), _display];

(_display displayCtrl 100) ctrlSetText (profileNamespace getVariable [QGVAR(customColor), "#FFFFFF"]);

_display displayAddEventHandler ["Unload", {
    params ["_display", "_exitCode"];
    if (_exitCode != 1) exitWith {}; // We only care if user closes it with ok button

    private _colorHex = ctrlText (_display displayCtrl 100);
    if (_colorHex select [0, 1] != "#") then {
        _colorHex = "#" + _colorHex;
    };

    // CBA trims extra characters, so no need to handle that here
    // "#FF00FF" and "#FF00FF00" both become [1, 0, 1]
    private _colorArray = _colorHex call CBA_fnc_colorHEXtoDecimal;

    ace_player setVariable ["dui_customHexColor", _colorHex, true];
    ace_player setVariable ["dui_customRGBColor", _colorArray, true];
    profileNamespace setVariable [QGVAR(customColor), _colorHex];
}];
