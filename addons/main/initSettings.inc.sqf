[
    QGVAR(customInfo), "EDITBOX",
    [LSTRING(customInfo_name), LSTRING(customInfo_tooltip)],
    _category, "", 2, {
        if (!hasInterface) exitWith {};
        // We want player and not ace_player in case player changes it while remote controlling
        player setVariable ["diwako_dui_nametags_customInfo", _this, true];
    }
] call CBA_fnc_addSetting;
