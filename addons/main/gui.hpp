class RscText;
class RscEdit;
class RscButtonMenuCancel;
class RscButtonMenuOK;

class GVAR(RscSetColor) {
    idd = -1;
    movingEnable = 0;
    onLoad = QUOTE(call FUNC(setColorOnLoad));
    onUnload = QUOTE(uiNamespace setVariable [ARR_2(QQGVAR(RscSetColor),nil)]);
    class controlsBackground {
        class centerBackground {
            idc = -1;
            type = CT_STATIC;
            style = ST_PICTURE;
            colorText[] = {0, 0, 0, GUI_BCG_ALPHA};
            colorBackground[] = {0, 0, 0, GUI_BCG_ALPHA};
            sizeEx = QUOTE(GUI_GRID_H);
            x = QUOTE(13 * GUI_GRID_W + GUI_GRID_CENTER_X);
            y = QUOTE(2 * GUI_GRID_H + GUI_GRID_CENTER_Y);
            w = QUOTE(13 * GUI_GRID_W);
            h = QUOTE(1.7 * GUI_GRID_H);
            text = "#(argb,8,8,3)color(0,0,0,0.8)";
            font = "RobotoCondensed";
        };
    };

    class controls {
        class headerName: RscText {
            text = CSTRING(setCustomColor);
            x = QUOTE(13 * GUI_GRID_W + GUI_GRID_CENTER_X);
            y = QUOTE(GUI_GRID_H + GUI_GRID_CENTER_Y);
            w = QUOTE(13 * GUI_GRID_W);
            h = QUOTE(GUI_GRID_H);
            style = QUOTE(ST_LEFT + ST_SHADOW);
            colorBackground[] = GUI_BCG_COLOR;
        };
        class color: RscEdit {
            idc = 100;
            canModify = 1;
            x = QUOTE(13.1 * GUI_GRID_W + GUI_GRID_CENTER_X);
            y = QUOTE(2.1 * GUI_GRID_H + GUI_GRID_CENTER_Y);
            w = QUOTE(12.8 * GUI_GRID_W);
            h = QUOTE(1.5 * GUI_GRID_H);
            SizeEx = QUOTE(1.5 * (GUI_GRID_H * 0.7));
        };
        class cancel: RscButtonMenuCancel {
            x = QUOTE(13 * GUI_GRID_W + GUI_GRID_CENTER_X);
            y = QUOTE(3.8 * GUI_GRID_H + GUI_GRID_CENTER_Y);
            w = QUOTE(5 * GUI_GRID_W);
            h = QUOTE(GUI_GRID_H);
            size = QUOTE(GUI_GRID_H * 1);
            SizeEx = QUOTE(GUI_GRID_H * 0.7);
        };
        class ok: RscButtonMenuOK {
            x = QUOTE(21 * GUI_GRID_W + GUI_GRID_CENTER_X);
            y = QUOTE(3.8 * GUI_GRID_H + GUI_GRID_CENTER_Y);
            w = QUOTE(5 * GUI_GRID_W);
            h = QUOTE(GUI_GRID_H);
            size = QUOTE(GUI_GRID_H * 1);
            SizeEx = QUOTE(GUI_GRID_H * 0.7);
        };
    };
};
