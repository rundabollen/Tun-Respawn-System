#include "script_component.hpp"
#include "XEH_prep.sqf"


if (isServer) then {
    missionNamespace setVariable [QGVAR(disableContestedCheck), false, true];

    missionNamespace setVariable [QGVAR(contested_east), false, true];
    missionNamespace setVariable [QGVAR(contested_west), false, true];
    missionNamespace setVariable [QGVAR(contested_guer), false, true];
    missionNamespace setVariable [QGVAR(contested_civ), false, true];

    missionNamespace setVariable [QGVAR(status_east), false, true];
    missionNamespace setVariable [QGVAR(status_west), false, true];
    missionNamespace setVariable [QGVAR(status_guer), false, true];
    missionNamespace setVariable [QGVAR(status_civ), false, true];

    missionNamespace setVariable [QGVAR(vehicle_east), objNull, true];
    missionNamespace setVariable [QGVAR(vehicle_west), objNull, true];
    missionNamespace setVariable [QGVAR(vehicle_guer), objNull, true];
    missionNamespace setVariable [QGVAR(vehicle_civ), objNull, true];

    missionNamespace setVariable [QGVAR(nearUnitsEast), [], true];
    missionNamespace setVariable [QGVAR(nearUnitsEastMin), [], true];

    missionNamespace setVariable [QGVAR(nearUnitsWest), [], true];
    missionNamespace setVariable [QGVAR(nearUnitsWestMin), [], true];

    missionNamespace setVariable [QGVAR(nearUnitsGuer), [], true];
    missionNamespace setVariable [QGVAR(nearUnitsGuerMin), [], true];

    missionNamespace setVariable [QGVAR(nearUnitsCiv), [], true];
    missionNamespace setVariable [QGVAR(nearUnitsCivMin), [], true];

    missionNamespace setVariable [QGVAR(enemyCountEast), 0, true];
    missionNamespace setVariable [QGVAR(enemyCountMinEast), 0, true];
    missionNamespace setVariable [QGVAR(friendlyCountEast), 0, true];

    missionNamespace setVariable [QGVAR(enemyCountWest), 0, true];
    missionNamespace setVariable [QGVAR(enemyCountMinWest), 0, true];
    missionNamespace setVariable [QGVAR(friendlyCountWest), 0, true];

    missionNamespace setVariable [QGVAR(enemyCountGuer), 0, true];
    missionNamespace setVariable [QGVAR(enemyCountMinGuer), 0, true];
    missionNamespace setVariable [QGVAR(friendlyCountGuer), 0, true];

    missionNamespace setVariable [QGVAR(enemyCountCiv), 0, true];
    missionNamespace setVariable [QGVAR(enemyCountMinCiv), 0, true];
    missionNamespace setVariable [QGVAR(friendlyCountCiv), 0, true];
};



[
    QGVAR(enable), // Unique setting name. Matches resulting variable name <STRING>
    "CHECKBOX", // Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
    ["STR_Tun_MSP_CBA_Enable" call BIS_fnc_localize, "STR_Tun_MSP_CBA_tooltip_Enable" call BIS_fnc_localize], // Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
    "STR_Tun_MSP_CBA_Category_main" call BIS_fnc_localize, // Category for the settings menu + optional sub-category <STRING, ARRAY>
    false, // Extra properties of the setting depending of _settingType.
    1, // 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <ARRAY>
    {}, // Script to execute when setting is changed. (optional) <CODE>
    true //Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_Settings_fnc_init;

[
    QGVAR(allowCheckTicketsMSP), // Unique setting name. Matches resulting variable name <STRING>
    "CHECKBOX", // Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
    ["STR_Tun_MSP_CBA_allowCheckTicketsMSP" call BIS_fnc_localize, "STR_Tun_Respawn_CBA_tooltip_CheckTickets" call BIS_fnc_localize], // Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
    "STR_Tun_MSP_CBA_Category_main" call BIS_fnc_localize, // Category for the settings menu + optional sub-category <STRING, ARRAY>
    false, // Extra properties of the setting depending of _settingType.
    1, // 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <ARRAY>
    {}, // Script to execute when setting is changed. (optional) <CODE>
    true //Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_Settings_fnc_init;


[
    QGVAR(report_enemies), // Unique setting name. Matches resulting variable name <STRING>
    "CHECKBOX", // Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
    ["STR_Tun_MSP_CBA_report_enemies" call BIS_fnc_localize, "STR_Tun_MSP_CBA_tooltip_report_enemies" call BIS_fnc_localize], // Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
    ["STR_Tun_MSP_CBA_Category_main" call BIS_fnc_localize, "STR_Tun_MSP_CBA_Category_contested" call BIS_fnc_localize], // Category for the settings menu + optional sub-category <STRING, ARRAY>
    true, // Extra properties of the setting depending of _settingType.
    1, // 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <ARRAY>
    {}, // Script to execute when setting is changed. (optional) <CODE>
    true //Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_Settings_fnc_init;


[
    QGVAR(report_enemies_interval), // Unique setting name. Matches resulting variable name <STRING>
    "SLIDER", // Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
    ["STR_Tun_MSP_CBA_report_enemies_intervala" call BIS_fnc_localize, "STR_Tun_MSP_CBA_tooltip_report_enemies_interval" call BIS_fnc_localize], // Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
    ["STR_Tun_MSP_CBA_Category_main" call BIS_fnc_localize, "STR_Tun_MSP_CBA_Category_contested" call BIS_fnc_localize], // Category for the settings menu + optional sub-category <STRING, ARRAY>
    [1, 600, 30, 0], // Extra properties of the setting depending of _settingType.
    1, // 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <ARRAY>
    {}, // Script to execute when setting is changed. (optional) <CODE>
    true //Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_Settings_fnc_init;


[
    QGVAR(report_enemies_range), // Unique setting name. Matches resulting variable name <STRING>
    "SLIDER", // Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
    ["STR_Tun_MSP_CBA_report_enemies_range" call BIS_fnc_localize, "STR_Tun_MSP_CBA_tooltip_report_enemies_range" call BIS_fnc_localize], // Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
    ["STR_Tun_MSP_CBA_Category_main" call BIS_fnc_localize, "STR_Tun_MSP_CBA_Category_contested" call BIS_fnc_localize], // Category for the settings menu + optional sub-category <STRING, ARRAY>
    [0, 5000, 500, 0], // Extra properties of the setting depending of _settingType.
    1, // 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <ARRAY>
    {}, // Script to execute when setting is changed. (optional) <CODE>
    false //Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_Settings_fnc_init;


[
    QGVAR(contested_radius_max), // Unique setting name. Matches resulting variable name <STRING>
    "SLIDER", // Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
    ["STR_Tun_MSP_CBA_contested_radius_max" call BIS_fnc_localize, "STR_Tun_MSP_CBA_tooltip_contested_max" call BIS_fnc_localize], // Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
    ["STR_Tun_MSP_CBA_Category_main" call BIS_fnc_localize, "STR_Tun_MSP_CBA_Category_contested" call BIS_fnc_localize], // Category for the settings menu + optional sub-category <STRING, ARRAY>
    [0, 5000, 500, 0], // Extra properties of the setting depending of _settingType.
    1, // 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <ARRAY>
    {}, // Script to execute when setting is changed. (optional) <CODE>
    false //Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_Settings_fnc_init;


[
    QGVAR(contested_radius_min), // Unique setting name. Matches resulting variable name <STRING>
    "SLIDER", // Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
    ["STR_Tun_MSP_CBA_contested_radius_min" call BIS_fnc_localize, "STR_Tun_MSP_CBA_tooltip_contested_min" call BIS_fnc_localize], // Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
    ["STR_Tun_MSP_CBA_Category_main" call BIS_fnc_localize, "STR_Tun_MSP_CBA_Category_contested" call BIS_fnc_localize], // Category for the settings menu + optional sub-category <STRING, ARRAY>
    [0, 5000, 200, 0], // Extra properties of the setting depending of _settingType.
    1, // 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <ARRAY>
    {}, // Script to execute when setting is changed. (optional) <CODE>
    false //Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_Settings_fnc_init;


[
    QGVAR(contested_check_interval), // Unique setting name. Matches resulting variable name <STRING>
    "SLIDER", // Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
    ["STR_Tun_MSP_CBA_contested_check_interval" call BIS_fnc_localize, "STR_Tun_MSP_CBA_tooltip_contested_check_interval" call BIS_fnc_localize], // Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
    ["STR_Tun_MSP_CBA_Category_main" call BIS_fnc_localize, "STR_Tun_MSP_CBA_Category_contested" call BIS_fnc_localize], // Category for the settings menu + optional sub-category <STRING, ARRAY>
    [1, 600, 30, 0], // Extra properties of the setting depending of _settingType.
    1, // 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <ARRAY>
    {}, // Script to execute when setting is changed. (optional) <CODE>
    true //Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_Settings_fnc_init;


[
    QGVAR(progresbar_time_setup), // Unique setting name. Matches resulting variable name <STRING>
    "SLIDER", // Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
    ["STR_Tun_MSP_CBA_setup_progresbar" call BIS_fnc_localize, "STR_Tun_MSP_CBA_tooltip_setup_progresbar" call BIS_fnc_localize], // Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
    ["STR_Tun_MSP_CBA_Category_main" call BIS_fnc_localize, "STR_Tun_MSP_CBA_Category_progres" call BIS_fnc_localize], // Category for the settings menu + optional sub-category <STRING, ARRAY>
    [0, 60, 5, 0], // Extra properties of the setting depending of _settingType.
    1, // 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <ARRAY>
    {}, // Script to execute when setting is changed. (optional) <CODE>
    true //Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_Settings_fnc_init;


[
    QGVAR(progresbar_time_pack), // Unique setting name. Matches resulting variable name <STRING>
    "SLIDER", // Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
    ["STR_Tun_MSP_CBA_pack_progresbar" call BIS_fnc_localize, "STR_Tun_MSP_CBA_tooltip_pack_progresbar" call BIS_fnc_localize], // Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
    ["STR_Tun_MSP_CBA_Category_main" call BIS_fnc_localize, "STR_Tun_MSP_CBA_Category_progres" call BIS_fnc_localize], // Category for the settings menu + optional sub-category <STRING, ARRAY>
    [0, 60, 5, 0], // Extra properties of the setting depending of _settingType.
    1, // 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <ARRAY>
    {}, // Script to execute when setting is changed. (optional) <CODE>
    true //Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_Settings_fnc_init;


[
    QGVAR(clasnames_east), // Unique setting name. Matches resulting variable name <STRING>
    "EDITBOX", // Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
    ["STR_Tun_MSP_CBA_classname_east" call BIS_fnc_localize, "STR_Tun_MSP_CBA_tooltip_classname" call BIS_fnc_localize], // Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
    ["STR_Tun_MSP_CBA_Category_main" call BIS_fnc_localize, "STR_Tun_MSP_CBA_classname" call BIS_fnc_localize], // Category for the settings menu + optional sub-category <STRING, ARRAY>
    "O_Truck_03_transport_F", // Extra properties of the setting depending of _settingType.
    1, // 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <ARRAY>
    {}, // Script to execute when setting is changed. (optional) <CODE>
    true //Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_Settings_fnc_init;


[
    QGVAR(clasnames_west), // Unique setting name. Matches resulting variable name <STRING>
    "EDITBOX", // Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
    ["STR_Tun_MSP_CBA_classname_west" call BIS_fnc_localize, "STR_Tun_MSP_CBA_tooltip_classname" call BIS_fnc_localize], // Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
    ["STR_Tun_MSP_CBA_Category_main" call BIS_fnc_localize, "STR_Tun_MSP_CBA_classname" call BIS_fnc_localize], // Category for the settings menu + optional sub-category <STRING, ARRAY>
    "B_Truck_01_transport_F", // Extra properties of the setting depending of _settingType.
    1, // 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <ARRAY>
    {}, // Script to execute when setting is changed. (optional) <CODE>
    true //Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_Settings_fnc_init;


[
    QGVAR(clasnames_resistance), // Unique setting name. Matches resulting variable name <STRING>
    "EDITBOX", // Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
    ["STR_Tun_MSP_CBA_classname_resistance" call BIS_fnc_localize, "STR_Tun_MSP_CBA_tooltip_classname" call BIS_fnc_localize], // Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
    ["STR_Tun_MSP_CBA_Category_main" call BIS_fnc_localize, "STR_Tun_MSP_CBA_classname" call BIS_fnc_localize], // Category for the settings menu + optional sub-category <STRING, ARRAY>
    "I_Truck_02_transport_F", // Extra properties of the setting depending of _settingType.
    1, // 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <ARRAY>
    {}, // Script to execute when setting is changed. (optional) <CODE>
    true //Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_Settings_fnc_init;


[
    QGVAR(clasnames_civilian), // Unique setting name. Matches resulting variable name <STRING>
    "EDITBOX", // Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
    ["STR_Tun_MSP_CBA_classname_civilian" call BIS_fnc_localize, "STR_Tun_MSP_CBA_tooltip_classname" call BIS_fnc_localize], // Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
    ["STR_Tun_MSP_CBA_Category_main" call BIS_fnc_localize, "STR_Tun_MSP_CBA_classname" call BIS_fnc_localize], // Category for the settings menu + optional sub-category <STRING, ARRAY>
    "C_Truck_02_transport_F", // Extra properties of the setting depending of _settingType.
    1, // 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <ARRAY>
    {}, // Script to execute when setting is changed. (optional) <CODE>
    true //Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_Settings_fnc_init;


[
    QGVAR(setupNotification), // Unique setting name. Matches resulting variable name <STRING>
    "LIST", // Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
    ["STR_Tun_MSP_CBA_whoGetsSetUpNotification" call BIS_fnc_localize, "STR_Tun_MSP_CBA_whoGetsSetUpNotification_Tooltip" call BIS_fnc_localize], // Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
    ["STR_Tun_MSP_CBA_Category_main" call BIS_fnc_localize, "STR_Tun_MSP_CBA_notificationCategory" call BIS_fnc_localize], // Category for the settings menu + optional sub-category <STRING, ARRAY>
    [[0, 1], ["Group Leaders", "Side"], 0], // Extra properties of the setting depending of _settingType.
    1, // 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <ARRAY>
    {}, // Script to execute when setting is changed. (optional) <CODE>
    true //Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_Settings_fnc_init;

[
    QGVAR(contestedNotification), // Unique setting name. Matches resulting variable name <STRING>
    "LIST", // Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
    ["STR_Tun_MSP_CBA_whoGetsContestedNotification" call BIS_fnc_localize, "STR_Tun_MSP_CBA_whoGetsContestedNotification_Tooltip" call BIS_fnc_localize], // Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
    ["STR_Tun_MSP_CBA_Category_main" call BIS_fnc_localize, "STR_Tun_MSP_CBA_notificationCategory" call BIS_fnc_localize], // Category for the settings menu + optional sub-category <STRING, ARRAY>
    [[0, 1], ["Group Leaders", "Side"], 0], // Extra properties of the setting depending of _settingType.
    1, // 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <ARRAY>
    {}, // Script to execute when setting is changed. (optional) <CODE>
    true //Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_Settings_fnc_init;

[
    QGVAR(reportEnemiesNotification), // Unique setting name. Matches resulting variable name <STRING>
    "LIST", // Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
    ["STR_Tun_MSP_CBA_whoGetsReportEnemiesNotification" call BIS_fnc_localize, "STR_Tun_MSP_CBA_whoGetsReportEnemies_Tooltip" call BIS_fnc_localize], // Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
    ["STR_Tun_MSP_CBA_Category_main" call BIS_fnc_localize, "STR_Tun_MSP_CBA_notificationCategory" call BIS_fnc_localize], // Category for the settings menu + optional sub-category <STRING, ARRAY>
    [[0, 1], ["Group Leaders", "Side"], 0], // Extra properties of the setting depending of _settingType.
    1, // 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <ARRAY>
    {}, // Script to execute when setting is changed. (optional) <CODE>
    true //Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_Settings_fnc_init;

