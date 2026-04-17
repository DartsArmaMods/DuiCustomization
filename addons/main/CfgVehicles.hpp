class CfgVehicles {
    class Man;
    class CAManBase: Man {
        class ACE_SelfActions {
            class ACE_TeamManagement {
                class ACE_JoinTeamRed;
                class GVAR(joinCustomColor): ACE_JoinTeamRed  {
                    displayName = CSTRING(joinCustomColor);
                    condition = "true";
                    statement = QUOTE([] call FUNC(joinCustomColor));
                    modifierFunction = QFUNC(modifyJoinCustomColor);

                    class GVAR(setCustomColor) {
                        displayName = CSTRING(setCustomColor);
                        condition = "true";
                        statement = QUOTE(call FUNC(openColorPicker));
                    };
                };
            };
        };
    };
};
