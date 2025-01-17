﻿/*
 * Author: [Tuntematon]
 * [Description]
 * Notify if ther is enemies inside max radius
 * Disable MPS if there is more enemies than friendlies inside max range
 * Disable MSP if there is even one enemy in min range
 *
 * Arguments:
 * 0: Unit count <Number>
 * 1: MSP <OBJECT>
 * 2: side <SIDE>
 *
 * Return Value:
 * The return value <BOOL>
 *
 * Example:
 * [unitcount, msp vehilce, side] call Tun_MSP_fnc_imanexample
 */
#include "script_component.hpp"
params ["_status", "_msp", "_side"];

//Notification
private _whoToNotify = [];
if (GVAR(reportEnemiesNotification) isEqualTo 0) then {
	{
		private _group = _x;
		if (side _group isEqualTo _side) then {
			_whoToNotify pushBack leader _group;
		};
	} forEach allGroups;
} else {
	_whoToNotify = [_side];
};

//Notify if enemies near
if ( _status ) then {
	if (count _whoToNotify > 0 ) then {
    	("STR_Tun_MSP_FNC_enemies_near" call BIS_fnc_localize) remoteExecCall ["CBA_fnc_notify", _whoToNotify];
	};
    if (_msp getvariable [QGVAR(enemies_near), false]) then {
    	_msp setVariable [QGVAR(enemies_near), true, true];
		AAR_UPDATE(_msp,"Enemies near", true);
    };
} else {
	if (_msp getvariable [QGVAR(enemies_near), true]) then {
		_msp setVariable [QGVAR(enemies_near), false, true];
		AAR_UPDATE(_msp,"Enemies near", false);
	};
};