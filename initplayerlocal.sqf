#include "USERSCRIPTS\missionsettings.sqf"
#include "USERSCRIPTS\loadouts.sqf"
#include "script_component.hpp"

enableSentences false;
enableRadio false;
enableSaving [false, false];

GRAD_Loadout_Chosen_Prefix = _loadoutFaction;

if (_useCaching) then {
  f_param_debugMode = _cachingDebug;
  f_param_caching = _cachingRange;
  f_var_cachingAggressiveness = _cachingAggressiveness;
  f_param_uncacheForZeus = _uncacheForZeus;
  [30] spawn f_fnc_cInit;
};

if (_waveRespawn) then {
  GRAD_waveRespawn = true;
  WAVERESPAWNTIME = _waveRespawnTime max 10;
  RESPAWNTIME = _respawnTime max 10;
  BLUFORWAVESIZE = _bluforWaveSize max -1;
  OPFORWAVESIZE = _opforWaveSize max -1;
  INDEPWAVESIZE = _indepWaveSize max -1;
  if (!isServer) then {
    [] execVM "wave_respawn\initWaveRespawn.sqf";
  };
} else {
  GRAD_waveRespawn = false;
};

if (_civTraffic) then {
  [] execVM "Engima\Traffic\Init.sqf";
};

if (didJIP) then {
  [[player], "helpers\addjiptozeus.sqf"] remoteExec ["execVM",2,false];
};

[] execVM "helpers\intro.sqf";
[] execVM "helpers\tfarsettings.sqf";
[] execVM "helpers\createDiaryRecords.sqf";

["InitializePlayer", [player]] call BIS_fnc_dynamicGroups;
[0,true] call FNC_SMC(client,setClientAction);
