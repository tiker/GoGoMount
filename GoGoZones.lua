local _
---------
function GoGo_ZoneMapIDMigration()
---------
	-- Migrating the 7.0 zoneIDs to 8.0 mapIDs
	-- Moving from GoGoPrefs.Zones to GoGoPrefs.MapIDs
	
	local iMapID = C_Map.GetBestMapForUnit("player")
	local iZoneID = 0
	
	if iMapID == 1 then
	--
	elseif iMapID == 36 then
		iZoneID = 29
		GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
	elseif iMapID == 37 then
		iZoneID = 30
		GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
	elseif iMapID == 84 then
		iZoneID = 301
		GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]

	end --if iMapID...
end -- function GoGo_ZoneMapIDMigration()

