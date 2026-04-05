#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        author = AUTHOR;
        authors[] = {"DartRuffian"};
        url = CSTRING(url);
        name = COMPONENT_NAME;
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {
            "ace_interaction"
        };
        units[] = {};
        weapons[] = {};
        VERSION_CONFIG;
    };
};

#include "gui.hpp"
#include "CfgVehicles.hpp"
#include "CfgEventHandlers.hpp"
#include "CfgSettings.hpp"
