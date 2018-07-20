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
	elseif iMapID == 17 then
		iZoneID = 19
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 36 then
		iZoneID = 29
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 37 then
		iZoneID = 30
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 47 then
		iZoneID = 34
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 49 then
		iZoneID = 36
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 50 then
		iZoneID = 37
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 51 then
		iZoneID = 38
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 52 then
		iZoneID = 39
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 84 then
		iZoneID = 301
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 210 then
		iZoneID = 673
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....

	end --if iMapID...
end -- function GoGo_ZoneMapIDMigration()

