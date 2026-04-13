#include "..\script_component.hpp"
#include "\a3\3den\ui\macros.inc"
#include "\a3\3den\ui\resincl.inc"
/*
 * Authors: R3vo
 * A Color Picker, it picks colors.
 *
 * Arguments:
 * 0: Parent display (optional, default display Display3DEN)
 * 1: Window title (optional, default: "Color Picker")
 * 2: Code executed when OK button is clicked
 *    (optional, default, color results are saved to uiNamespace variable "DUIC_ColorPicker_Result" as HashMap
 *
 * Return Value:
 * None
 *
 * Example:
 * [params] call duic_main_fnc_createColorPicker
 *
 * Public: No
 */

#define COLOR_RED [0.8, 0, 0, 1]
#define COLOR_GREEN [0, 0.8, 0, 1]
#define COLOR_BLUE [0, 0, 0.8, 1]
#define IDC_BTN_CANCEL 2
#define IDC_BTN_OK 1
#define WIDTH 90
#define HEX_A_PATTERN "\#{1}[A-F0-9]{8}"
#define HEX_PATTERN "\#{1}[A-F0-9]{6}"
#define RGBA255_PATTERN "[0-9]{1,3},[0-9]{1,3},[0-9]{1,3},[0-9]{1,3}"
#define RGBA_PATTERN "[01]\.[0-9]{0,2},[01]\.[0-9]{0,2},[01]\.[0-9]{0,2},[01]\.[0-9]{0,2}"

params
[
    ["_parentDisplay", findDisplay IDD_DISPLAY3DEN, [displayNull]],
    ["_title", "Color Picker", [""]],
    ["_onOKClicked", {}, [{}]],
    ["_initialColor", [1, 1, 1, 1], [[], ""], [3, 4]]
];

if (_initialColor isEqualType "") then
{
    if (_initialColor regexMatch HEX_A_PATTERN) exitWith
    {
        _initialColor = [_initialColor] call CBA_fnc_colorAHEXtoDecimal;
    };
    if (_initialColor regexMatch HEX_PATTERN) exitWith
    {
        _initialColor = [_initialColor] call CBA_fnc_colorHEXtoDecimal;
    };
};

private _display = _parentDisplay createDisplay "RscDisplayEmpty";

// Hide the vignette (RscDisplayEmpty not actually being empty...)
(_display displayCtrl 1202) ctrlShow false;

private _ctrlTitle = _display ctrlCreate ["ctrlStaticTitle", -1];

_ctrlTitle ctrlSetPosition
[
    0.5 - (0.5 * WIDTH) * GRID_W,
    0.5 - 40 * GRID_H,
    WIDTH * GRID_W,
    5 * GRID_H
];

_ctrlTitle ctrlSetText (_title call BIS_fnc_localize);

private _ctrlControlsGroup =  _display ctrlCreate ["ctrlControlsGroupNoScrollbars", -1];

_ctrlControlsGroup ctrlSetPosition
[
    0.5 - (0.5 * WIDTH) * GRID_W,
    0.5 - 35 * GRID_H,
    WIDTH * GRID_W,
    49 * GRID_H
];

private _ctrlBackground = _display ctrlCreate ["ctrlStaticBackground", -1, _ctrlControlsGroup];

_ctrlBackground ctrlSetPosition
[
    0,
    0,
    WIDTH * GRID_W,
    49 * GRID_H
];

for "_i" from 0 to 3 do
{
    private _ctrlSlider = _display ctrlCreate ["ctrlXSliderH", 100 + _i, _ctrlControlsGroup];
    _ctrlSlider ctrlSetPosition
    [
        GRID_W,
        _i * 5 * GRID_H + GRID_H + _i * GRID_H,
        (WIDTH - 2) * GRID_W,
        5 * GRID_H
    ];

    private _color = [COLOR_RED, COLOR_GREEN, COLOR_BLUE, [1, 1, 1, 1]] select _i;
    _ctrlSlider ctrlSetForegroundColor _color;
    _ctrlSlider ctrlSetActiveColor _color;

    switch _i do
    {
        case 0:
        {
            _display setVariable ["SliderRed", _ctrlSlider];
        };
        case 1:
        {
            _display setVariable ["SliderGreen", _ctrlSlider];
        };
        case 2:
        {
            _display setVariable ["SliderBlue", _ctrlSlider];
        };
        case 3:
        {
            _display setVariable ["SliderAlpha", _ctrlSlider];
        };
    };

    // Set default color. Use param to prevent mismatch between RGB and RGBA
    _ctrlSlider sliderSetPosition (_initialColor param [_i, 1]);
};

private _ctrlPreview = _display ctrlCreate ["ctrlStaticPicture", -1, _ctrlControlsGroup];
_display setVariable ["Preview", _ctrlPreview];

_ctrlPreview ctrlSetPosition
[
    GRID_W,
    25 * GRID_H,
    (WIDTH - 2) * GRID_W,
    10 * GRID_H
];

private _ctrlEditHEXAlpha = _display ctrlCreate ["ctrlEdit", -1, _ctrlControlsGroup];
_display setVariable ["EditHexAlpha", _ctrlEditHEXAlpha];

_ctrlEditHEXAlpha ctrlSetPosition
[
    1 * GRID_W,
    35 * GRID_H + GRID_H,
    19 * GRID_W,
    5 * GRID_H
];

private _ctrlEditHEX = _display ctrlCreate ["ctrlEdit", -1, _ctrlControlsGroup];
_display setVariable ["EditHex", _ctrlEditHEX];

_ctrlEditHEX ctrlSetPosition
[
    2 * GRID_W + (19) * GRID_W,
    35 * GRID_H + GRID_H,
    16 * GRID_W,
    5 * GRID_H
];

private _ctrlEditRGBA255 = _display ctrlCreate ["ctrlEdit", -1, _ctrlControlsGroup];
_display setVariable ["EditRGBA255", _ctrlEditRGBA255];

_ctrlEditRGBA255 ctrlSetPosition
[
    3 * GRID_W + (19 + 16) * GRID_W,
    35 * GRID_H + GRID_H,
    25 * GRID_W,
    5 * GRID_H
];

private _ctrlEditRGBA = _display ctrlCreate ["ctrlEdit", -1, _ctrlControlsGroup];
_display setVariable ["EditRGBA", _ctrlEditRGBA];

_ctrlEditRGBA ctrlSetPosition
[
    4 * GRID_W + (19 + 16 + 25) * GRID_W,
    35 * GRID_H + GRID_H,
    25 * GRID_W,
    5 * GRID_H
];

private _ctrlFooter = _display ctrlCreate ["ctrlStaticFooter", -1, _ctrlControlsGroup];

_ctrlFooter ctrlSetPosition
[
    0,
    41 * GRID_H + GRID_H,
    WIDTH * GRID_W,
    7 * GRID_H
];

private _ctrlButtonOK = _display ctrlCreate ["ctrlButtonOK", -1, _ctrlControlsGroup];

_ctrlButtonOK ctrlSetPosition
[
    (WIDTH - 25 - 1) * GRID_W,
    41 * GRID_H + 2 * GRID_H,
    25 * GRID_W,
    5 * GRID_H
];

// Default code
if (_onOKClicked isEqualTo {}) then
{
    _onOKClicked =
    {
        params ["_ctrlButton"];

        private _display = ctrlParent _ctrlButton;

        private _ctrlEditHEXAlpha = _display getVariable ["EditHexAlpha", controlNull];
        private _ctrlEditHEX = _display getVariable ["EditHex", controlNull];
        private _ctrlEditRGBA255 = _display getVariable ["EditRGBA255", controlNull];
        private _ctrlEditRGBA = _display getVariable ["EditRGBA", controlNull];

        uiNamespace setVariable
        [
            QGVAR(ColorPicker_Result),
            [
                "HEXAlpha",
                "HEX",
                "RGBA255",
                "RGBA"
            ]
            createHashMapFromArray
            [
                ctrlText _ctrlEditHEXAlpha,
                ctrlText _ctrlEditHEX,
                ctrlText _ctrlEditRGBA255,
                ctrlText _ctrlEditRGBA
            ]
        ];
        _display closeDisplay 1;
    };
};

_ctrlButtonOK ctrlAddEventHandler ["ButtonClick", _onOKClicked];

private _ctrlButtonCancel = _display ctrlCreate ["ctrlButtonCancel", IDC_BTN_CANCEL, _ctrlControlsGroup];

_ctrlButtonCancel ctrlSetPosition
[
    (WIDTH - 25 - 1 - 25 - 1) * GRID_W,
    41 * GRID_H + 2 * GRID_H,
    25 * GRID_W,
    5 * GRID_H
];

allControls _display apply {_x ctrlCommit 0};

private _updatePreview =
{
    params ["_display"];

    private _ctrlEditHEXAlpha = _display getVariable ["EditHexAlpha", controlNull];
    private _ctrlEditHEX = _display getVariable ["EditHex", controlNull];
    private _ctrlEditRGBA255 = _display getVariable ["EditRGBA255", controlNull];
    private _ctrlEditRGBA = _display getVariable ["EditRGBA", controlNull];

    // Don't run the loop if user is about to edit the color codes
    if (ctrlType focusedCtrl _display == CT_EDIT) exitWith {};

    private _ctrlPreview = _display getVariable ["Preview", controlNull];
    private _ctrlSliderRed = _display getVariable ["SliderRed", controlNull];
    private _ctrlSliderGreen = _display getVariable ["SliderGreen", controlNull];
    private _ctrlSliderBlue = _display getVariable ["SliderBlue", controlNull];
    private _ctrlSliderAlpha = _display getVariable ["SliderAlpha", controlNull];

    private _colorRGBA =
    [
        sliderPosition _ctrlSliderRed,
        sliderPosition _ctrlSliderGreen,
        sliderPosition _ctrlSliderBlue,
        sliderPosition _ctrlSliderAlpha
    ];

    private _colorHEX = _colorRGBA call BIS_fnc_colorRGBAtoHTML;
    _ctrlEditHEXAlpha ctrlSetText _colorHEX;

    _ctrlEditHEX ctrlSetText format ["#%1", _colorHEX select [3]];

    _ctrlEditRGBA255 ctrlSetText format
    [
        "%1,%2,%3,%4",
        round (_colorRGBA#0 * 255),
        round (_colorRGBA#1 * 255),
        round (_colorRGBA#2 * 255),
        round (_colorRGBA#3 * 255)
    ];

    toFixed 2;

    _ctrlEditRGBA ctrlSetText format
    [
        "%1,%2,%3,%4",
        _colorRGBA#0,
        _colorRGBA#1,
        _colorRGBA#2,
        _colorRGBA#3
    ];

    _ctrlPreview ctrlSetText format
    [
        "#(argb,8,8,3)color(%1,%2,%3,%4)",
        _colorRGBA#0,
        _colorRGBA#1,
        _colorRGBA#2,
        _colorRGBA#3
    ];
};

_display displayAddEventHandler ["MouseHolding", _updatePreview];
_display displayAddEventHandler ["MouseMoving", _updatePreview];

private _onEditChanged =
{
    params ["_ctrlEdit", "_text"];

    private _display = ctrlParent _ctrlEdit;

    // Only fire event if any of the three edit controls are focused
    if (ctrlType focusedCtrl _display != CT_EDIT) exitWith {};

    _text = _text regexReplace [" ", ""];

    private _ctrlSliderRed = _display getVariable ["SliderRed", controlNull];
    private _ctrlSliderGreen = _display getVariable ["SliderGreen", controlNull];
    private _ctrlSliderBlue = _display getVariable ["SliderBlue", controlNull];
    private _ctrlSliderAlpha = _display getVariable ["SliderAlpha", controlNull];

    private _validInput = false;
    private _colorFormat = [1, 1, 1, 1];

    // Hex with alpha changed
    if (toUpper _text regexMatch HEX_A_PATTERN) then
    {
        _colorFormat = _text call CBA_fnc_colorAHEXtoDecimal;
        _validInput = true;
    };

    // Hex without alpha changed
    if (toUpper _text regexMatch HEX_PATTERN) then
    {
        _colorFormat = _text call CBA_fnc_colorHEXtoDecimal;
        _validInput = true;
    };

    // RGBA255 changed
    if (_text regexMatch RGBA255_PATTERN) then
    {
        _colorFormat = _text splitString ", " apply
        {
            parseNumber _x / 255
        };
        _validInput = true;
    };

    // RGBA changed
    if (_text regexMatch RGBA_PATTERN) then
    {
        _colorFormat = _text splitString ", " apply
        {
            parseNumber _x
        };
        _validInput = true;
    };

    if (_validInput) then
    {
        _colorFormat params ["_r", "_g", "_b", ["_a", 1]];
        _ctrlSliderRed sliderSetPosition _r;
        _ctrlSliderGreen sliderSetPosition _g;
        _ctrlSliderBlue sliderSetPosition _b;
        _ctrlSliderAlpha sliderSetPosition _a;
    };
};

_ctrlEditHEXAlpha ctrlAddEventHandler ["EditChanged", _onEditChanged];
_ctrlEditHEX ctrlAddEventHandler ["EditChanged", _onEditChanged];
_ctrlEditRGBA255 ctrlAddEventHandler ["EditChanged", _onEditChanged];
_ctrlEditRGBA ctrlAddEventHandler ["EditChanged", _onEditChanged];

nil
