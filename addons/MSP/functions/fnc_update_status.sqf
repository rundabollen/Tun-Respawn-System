﻿/*
 * Author: [Tuntematon]
 * [Description]
 *
 *
 * Arguments:
 * 0: MSP <OBJ>
 * 1: True: Setup MSP. False: Pack MSP <BOOL>
 *
 * Return Value:
 * none
 *
 * Example:
 * [msp, true] call Tun_MSP_fnc_update_status
 */
#include "script_component.hpp"

params ["_msp", "_setup"];

private _side = _msp getVariable QGVAR(side);
private _msp_var = objNull;
private _whoToNotify = [];
if (GVAR(setupNotification) isEqualTo 0) then {
	{
		private _group = _x;
		if (side _group isEqualTo _side) then {
			_whoToNotify pushBack leader _group;
		};
	} forEach allGroups;
} else {
	_whoToNotify = [_side];
};

AAR_UPDATE(_msp,"Is active MSP", _setup);

if (_setup) then {
	
	if (count _whoToNotify > 0 ) then {
		(call compile ("STR_Tun_MSP_FNC_setup_notification" call BIS_fnc_localize)) remoteExecCall ["CBA_fnc_notify", _whoToNotify];
	};

	[_msp] remoteExecCall [QFUNC(create_msp_props), 2];

	//force player out from MSP and LOCK it
	{
	    [_x, ["getOut", _msp]] remoteExecCall ["action", _x];
	} forEach crew _msp;

	[{count crew _this == 0}, {
	    [_this, 2] remoteExecCall ["lock", _this];
	}, _msp] call CBA_fnc_waitUntilAndExecute;

	_msp_var = _msp;

} else {
	if (count _whoToNotify > 0 ) then {
		(call compile ("STR_Tun_MSP_FNC_pack_notification" call BIS_fnc_localize)) remoteExecCall ["CBA_fnc_notify", _whoToNotify];
	};
	//Delete props
	{
	    deleteVehicle _x;
	} forEach (_msp getVariable QGVAR(objects));

	//Unlock vehicle
	[_msp, 0] remoteExecCall ["lock", _msp];

};

private _pos = getpos _msp;

[_side, _setup, _pos] remoteExecCall ["Tun_respawn_fnc_update_respawn_point", 2];

_msp setVariable [QGVAR(isMSP), _setup, true];

switch (_side) do {
	case west: {
		missionNamespace setVariable [QGVAR(vehicle_west), _msp_var, true];
		missionNamespace setVariable [QGVAR(status_west), _setup, true];

		missionNamespace setVariable [QGVAR(nearUnitsWest), [], 2];
		missionNamespace setVariable [QGVAR(nearUnitsWestMin), [], 2];	
		missionNamespace setVariable [QGVAR(enemyCountWest), 0, 2];
		missionNamespace setVariable [QGVAR(enemyCountMinWest), 0, 2];	
		missionNamespace setVariable [QGVAR(friendlyCountWest), 0, 2];
	};

	case east: {
		missionNamespace setVariable [QGVAR(vehicle_east), _msp_var, true];
		missionNamespace setVariable [QGVAR(status_east), _setup, true];

		missionNamespace setVariable [QGVAR(nearUnitsEast), [], 2];
		missionNamespace setVariable [QGVAR(nearUnitsGuerEast), [], 2];	
		missionNamespace setVariable [QGVAR(enemyCountEast), 0, 2];
		missionNamespace setVariable [QGVAR(enemyCountMinEast), 0, 2];	
		missionNamespace setVariable [QGVAR(friendlyCountEast), 0, 2];
	};

	case resistance: {
		missionNamespace setVariable [QGVAR(vehicle_guer), _msp_var, true];
		missionNamespace setVariable [QGVAR(status_guer), _setup, true];

		missionNamespace setVariable [QGVAR(nearUnitsGuer), [], 2];
		missionNamespace setVariable [QGVAR(nearUnitsGuerMin), [], 2];	
		missionNamespace setVariable [QGVAR(enemyCountGuer), 0, 2];
		missionNamespace setVariable [QGVAR(enemyCountMinGuer), 0, 2];	
		missionNamespace setVariable [QGVAR(friendlyCountGuer), 0, 2];
	};

	case civilian: {
		missionNamespace setVariable [QGVAR(vehicle_civ), _msp_var, true];
		missionNamespace setVariable [QGVAR(status_civ), _setup, true];

		missionNamespace setVariable [QGVAR(nearUnitsCiv), [], 2];
		missionNamespace setVariable [QGVAR(nearUnitsCivMin), [], 2];	
		missionNamespace setVariable [QGVAR(enemyCountCiv), 0, 2];
		missionNamespace setVariable [QGVAR(enemyCountMinCiv), 0, 2];	
		missionNamespace setVariable [QGVAR(friendlyCountCiv), 0, 2];
	};
};

if (_setup) then {
	[{
		[] call FUNC(contestedCheck)
	}, nil, 1] call CBA_fnc_waitAndExecute;
};
