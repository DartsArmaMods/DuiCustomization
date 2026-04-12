#include "..\script_component.hpp"
/*
 * Authors: R3vo
 * Saves color from Color Picker to profileNamespace
 *
 * Arguments:
 * CONTROL: OK Button from Color Picker UI
 *
 * Return Value:
 * None
 *
 * Example:
 * [params] call DUI_main_fnc_saveColor
 *
 * Public: No
 */

params ["_ctrlButton"];

private _display = ctrlParent _ctrlButton;
private _ctrlEditHEX = _display getVariable ["EditHex", controlNull];

profileNamespace setVariable [QGVAR(customColor), ctrlText _ctrlEditHEX];

_display closeDisplay 1;

nil
