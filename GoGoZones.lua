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
	
--[[
	if iMapID == 1 then
		iZoneID = 4
	elseif iMapID == 2 then
		iZoneID = 4
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 3 then
		iZoneID = 4
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 4 then
		iZoneID = 4
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 5 then
		iZoneID = 4
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 6 then
		iZoneID = 4
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 7 then
		iZoneID = 9
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 8 then
		iZoneID = 9
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 9 then
		iZoneID = 9
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 10 then
		iZoneID = 11
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 11 then
		iZoneID = 11
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 12 then
		iZoneID = 13
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 13 then
		iZoneID = 14
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 14 then
		iZoneID = 16
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 15 then
		iZoneID = 17
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 16 then
		iZoneID = 17
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 17 then
		iZoneID = 19
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 18 then
		iZoneID = 20
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 19 then
		iZoneID = 20
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 20 then
		iZoneID = 20
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 21 then
		iZoneID = 21
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 22 then
		iZoneID = 22
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 23 then
		iZoneID = 23
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 24 then
		iZoneID = 23
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 25 then
		iZoneID = 24
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 26 then
		iZoneID = 26
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 27 then
		iZoneID = 27
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 28 then
		iZoneID = 27
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 29 then
		iZoneID = 27
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 30 then
		iZoneID = 27
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 31 then
		iZoneID = 27
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 32 then
		iZoneID = 28
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 33 then
		iZoneID = 28
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 34 then
		iZoneID = 28
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 35 then
		iZoneID = 28
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
	elseif iMapID == 38 then
		iZoneID = 30
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 39 then
		iZoneID = 30
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 40 then
		iZoneID = 30
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 41 then
		iZoneID = 30
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 42 then
		iZoneID = 32
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 43 then
		iZoneID = 32
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 44 then
		iZoneID = 32
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 45 then
		iZoneID = 32
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 46 then
		iZoneID = 32
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 47 then
		iZoneID = 34
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 48 then
		iZoneID = 35
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
	elseif iMapID == 53 then
		iZoneID = 39
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 54 then
		iZoneID = 39
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 55 then
		iZoneID = 39
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 56 then
		iZoneID = 40
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 57 then
		iZoneID = 41
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 58 then
		iZoneID = 41
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 59 then
		iZoneID = 41
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 60 then
		iZoneID = 41
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 61 then
		iZoneID = 41
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 62 then
		iZoneID = 42
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 63 then
		iZoneID = 43
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 64 then
		iZoneID = 61
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 65 then
		iZoneID = 81
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 66 then
		iZoneID = 101
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 67 then
		iZoneID = 101
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 68 then
		iZoneID = 101
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 69 then
		iZoneID = 121
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 70 then
		iZoneID = 141
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 71 then
		iZoneID = 161
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 72 then
		iZoneID = 161
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 73 then
		iZoneID = 161
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 74 then
		iZoneID = 161
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 75 then
		iZoneID = 161
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 76 then
		iZoneID = 181
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 77 then
		iZoneID = 182
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 78 then
		iZoneID = 201
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 79 then
		iZoneID = 201
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 80 then
		iZoneID = 241
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 81 then
		iZoneID = 261
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 82 then
		iZoneID = 261
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 83 then
		iZoneID = 281
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 84 then
		iZoneID = 301
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 85 then
		iZoneID = 321
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 86 then
		iZoneID = 321
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 87 then
		iZoneID = 341
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 88 then
		iZoneID = 362
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 89 then
		iZoneID = 381
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 90 then
		iZoneID = 382
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 91 then
		iZoneID = 401
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 92 then
		iZoneID = 443
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 93 then
		iZoneID = 461
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 94 then
		iZoneID = 462
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 95 then
		iZoneID = 463
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 96 then
		iZoneID = 463
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 97 then
		iZoneID = 464
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 98 then
		iZoneID = 464
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 99 then
		iZoneID = 464
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 100 then
		iZoneID = 465
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 101 then
		iZoneID = 466
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 102 then
		iZoneID = 467
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 103 then
		iZoneID = 471
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 104 then
		iZoneID = 473
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 105 then
		iZoneID = 475
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 106 then
		iZoneID = 476
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 107 then
		iZoneID = 477
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 108 then
		iZoneID = 478
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 109 then
		iZoneID = 479
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 110 then
		iZoneID = 480
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 111 then
		iZoneID = 481
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 112 then
		iZoneID = 482
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 113 then
		iZoneID = 485
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 114 then
		iZoneID = 486
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 115 then
		iZoneID = 488
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 116 then
		iZoneID = 490
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 117 then
		iZoneID = 491
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 118 then
		iZoneID = 492
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 119 then
		iZoneID = 493
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 120 then
		iZoneID = 495
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 121 then
		iZoneID = 496
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 122 then
		iZoneID = 499
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 123 then
		iZoneID = 501
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 124 then
		iZoneID = 502
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 125 then
		iZoneID = 504
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 126 then
		iZoneID = 504
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 127 then
		iZoneID = 510
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 128 then
		iZoneID = 512
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 129 then
		iZoneID = 520
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 130 then
		iZoneID = 521
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 131 then
		iZoneID = 521
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 132 then
		iZoneID = 522
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 133 then
		iZoneID = 523
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 134 then
		iZoneID = 523
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 135 then
		iZoneID = 523
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 210 then
		iZoneID = 673
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 217 then
		iZoneID = 684
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 241 then
		iZoneID = 700
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 244 then
		iZoneID = 708
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 245 then
		iZoneID = 709
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 291 then
		iZoneID = 756
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 292 then
		iZoneID = 756
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 525 then
		iZoneID = 941
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 526 then
		iZoneID = 941
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 527 then
		iZoneID = 941
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 528 then
		iZoneID = 941
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 529 then
		iZoneID = 941
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 530 then
		iZoneID = 941
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 531 then
		iZoneID = 941
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 532 then
		iZoneID = 941
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 533 then
		iZoneID = 941
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 534 then
		iZoneID = 945
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 535 then
		iZoneID = 946
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 536 then
		iZoneID = 946
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 537 then
		iZoneID = 946
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 538 then
		iZoneID = 946
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 539 then
		iZoneID = 947
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 540 then
		iZoneID = 947
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 541 then
		iZoneID = 947
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 542 then
		iZoneID = 948
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 543 then
		iZoneID = 949
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 544 then
		iZoneID = 949
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 545 then
		iZoneID = 949
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 546 then
		iZoneID = 949
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 547 then
		iZoneID = 949
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 548 then
		iZoneID = 949
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 549 then
		iZoneID = 949
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 550 then
		iZoneID = 950
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 551 then
		iZoneID = 950
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 552 then
		iZoneID = 950
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 553 then
		iZoneID = 950
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 588 then
		iZoneID = 978
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 589 then
		iZoneID = 978
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 622 then
		iZoneID = 1009
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 628 then
		iZoneID = 1014
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 630 then
		iZoneID = 1015
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 631 then
		iZoneID = 1015
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 632 then
		iZoneID = 1015
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 633 then
		iZoneID = 1015
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 634 then
		iZoneID = 1017
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 635 then
		iZoneID = 1017
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 636 then
		iZoneID = 1017
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 637 then
		iZoneID = 1017
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 638 then
		iZoneID = 1017
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 639 then
		iZoneID = 1017
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 640 then
		iZoneID = 1017
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 641 then
		iZoneID = 1018
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 642 then
		iZoneID = 1018
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 643 then
		iZoneID = 1018
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 644 then
		iZoneID = 1018
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 646 then
		iZoneID = 1021
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 650 then
		iZoneID = 1024
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 680 then
		iZoneID = 1033
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 681 then
		iZoneID = 1033
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 682 then
		iZoneID = 1033
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 683 then
		iZoneID = 1033
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 684 then
		iZoneID = 1033
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 685 then
		iZoneID = 1033
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 686 then
		iZoneID = 1033
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 687 then
		iZoneID = 1033
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 688 then
		iZoneID = 1033
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 689 then
		iZoneID = 1033
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 690 then
		iZoneID = 1033
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 691 then
		iZoneID = 1033
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 692 then
		iZoneID = 1033
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 693 then
		iZoneID = 1033
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	else
		if GoGo_Variables.Debug >= 5 then
			GoGo_DebugAddLine("GoGo_ZoneMapIDMigration: Zone preferences for this zone have not been migrated to 8.0 settings.")
		end --if

	end --if iMapID...
--		GoGo_DebugAddLine("DO YOU SEE ME!?? after the if statement!??!")
	]]
	if (not GoGo_Prefs.MapIDs[iMapID]) or (not type(GoGo_Prefs.MapIDs[iMapID])) == "table" then
		GoGo_Prefs.MapIDs[iMapID] = {}
		GoGo_Prefs.MapIDs[iMapID]["Preferred"] = {}
		GoGo_Prefs.MapIDs[iMapID]["Excluded"] = {}
	end --if

end -- function GoGo_ZoneMapIDMigration()

