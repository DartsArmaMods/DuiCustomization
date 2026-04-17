#include "..\script_component.hpp"
/*
 * Authors: DartRuffian
 * Modifies the ACE action to use the set color
 *
 * Arguments:
 * 0: Target (unused) <OBJECT>
 * 1: Player (unused) <OBJECT>
 * 2: Action data <ARRAY>
 *
 * Return Value:
 * None
 *
 * Public: No
 */

params ["", "", "", "_actionData"];
TRACE_1("fnc_modifyJoinCustomColor",_actionData);

private _color = profileNamespace getVariable [QGVAR(customColor), "#FFFFFF"];
(_actionData select 2) set [1, _color];
