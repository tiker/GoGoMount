local _
---------
function GoGo_ZoneMapIDMigration()
---------
	-- Migrating the 7.0 zoneIDs to 8.0 mapIDs
	-- Moving from GoGoPrefs.Zones to GoGoPrefs.MapIDs
	
	local iMapID = C_Map.GetBestMapForUnit("player")
	local iZoneID = GoGo_Variables.ZoneMapID[iMapID]
	
	if not GoGo_Prefs.MapIDs[iMapID] then
		GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
	end --if not GoGo_Prefs.MapIDs....
	
	if (not GoGo_Prefs.MapIDs[iMapID]) or (not type(GoGo_Prefs.MapIDs[iMapID])) == "table" then
		GoGo_Prefs.MapIDs[iMapID] = {}
		GoGo_Prefs.MapIDs[iMapID]["Preferred"] = {}
		GoGo_Prefs.MapIDs[iMapID]["Excluded"] = {}
	end --if
end -- function GoGo_ZoneMapIDMigration()

