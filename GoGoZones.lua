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
	elseif iMapID == 32 then
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
	elseif iMapID == 84 then
		iZoneID = 301
		if not GoGo_Prefs.MapIDs[iMapID] then
			GoGo_Prefs.MapIDs[iMapID] = GoGo_Prefs.Zones[iZoneID]
		end --if not GoGo_Prefs.MapIDs....
	elseif iMapID == 90 then
		iZoneID = 382
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
	elseif iMapID == 122 then
		iZoneID = 499
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
	
	if (not GoGo_Prefs.MapIDs[iMapID]) or (not type(GoGo_Prefs.MapIDs[iMapID])) == "table" then
		GoGo_Prefs.MapIDs[iMapID] = {}
		GoGo_Prefs.MapIDs[iMapID]["Preferred"] = {}
		GoGo_Prefs.MapIDs[iMapID]["Excluded"] = {}
	end --if

end -- function GoGo_ZoneMapIDMigration()

