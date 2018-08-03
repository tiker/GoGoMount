local _
---------
function GoGo_ZoneMapIDMigration()
---------
	-- Migrating the 7.0 zoneIDs to 8.0 mapIDs
	-- Moving from GoGoPrefs.Zones to GoGoPrefs.MapIDs
	
	local iMapID = C_Map.GetBestMapForUnit("player")
	if not iMapID then return end
	
	local iZoneID = GoGo_Variables.ZoneMapID[iMapID]
	
	if not GoGo_Prefs.MapIDs[iMapID] then
		if GoGo_Prefs.Zones and GoGo_Prefs.Zones[iZoneID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		else
			GoGo_Prefs.MapIDs[iMapID] = {}
			GoGo_Prefs.MapIDs[iMapID]["Preferred"] = {}
			GoGo_Prefs.MapIDs[iMapID]["Excluded"] = {}
		end --if
	end --if not GoGo_Prefs.MapIDs....
	
end -- function GoGo_ZoneMapIDMigration()

