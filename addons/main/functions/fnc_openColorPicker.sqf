#include "..\script_component.hpp"
/*
 * Authors: R3vo
 * A wrapper function for duic_fnc_createColorPicker.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * call duic_main_fnc_openColorPicker
 *
 * Public: No
 */

[
    call BIS_fnc_displayMission,
    CSTRING(setCustomColor),
    FUNC(saveColor),
    (profileNamespace getVariable [QGVAR(customColor), "#FFFFFF"])
] call FUNC(createColorPicker);
