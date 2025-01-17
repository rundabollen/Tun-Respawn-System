#include "script_component.hpp"

#undef PREP
#define PREP(fncName) [QPATHTOF(functions\DOUBLES(fnc,fncName).sqf), QFUNC(fncName)] call CBA_fnc_compileFunction

PREP(addGear);
PREP(blackscreen);
PREP(delayed_respawn);
PREP(force_Respawn);
PREP(killed);
PREP(killJIP);
PREP(marker_update);
PREP(module_respawnpos);
PREP(module_waitingarea);
PREP(moveRespawns);
PREP(removegear);
PREP(savegear);
PREP(startSpectator);
PREP(ticketCountterSide);
PREP(timer);
PREP(waitingArea);
PREP(update_respawn_point);
PREP(teleport);
PREP(radioSettings_tfar);
PREP(module_teleporter);
PREP(openTeleportMenu);
PREP(teleportButton);
PREP(teleportOnLBSelChanged);
PREP(addCustomTeleporter);
PREP(addTeleportAction);
PREP(checkTicketCount);
PREP(addCheckTicketCountAction);
PREP(loadSavedGear);
PREP(updateWaitingRespawnList);
PREP(briefingNotes);

