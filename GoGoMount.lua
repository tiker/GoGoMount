---------
function GoGo_OnLoad()
---------
	SLASH_GOGOMOUNT1 = "/gogo"
	SlashCmdList["GOGOMOUNT"] = function(msg) GoGo_OnSlash(msg) end
	SLASH_GOGOID1 = "/id"
	SlashCmdList["GOGOID"] = function(msg) GoGo_Msg(GoGo_Id(msg)) end


	GoGoFrame:RegisterEvent("VARIABLES_LOADED")
	GoGoFrame:RegisterEvent("UPDATE_BINDINGS")
	GoGoFrame:RegisterEvent("TAXIMAP_OPENED")
	GoGoFrame:RegisterEvent("CHAT_MSG_ADDON")
	GoGoFrame:RegisterEvent("COMPANION_LEARNED")
	GoGoFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
	GoGoFrame:RegisterEvent("ZONE_CHANGED_NEW_AREA")
--	GoGoFrame:RegisterEvent("BAG_UPDATE")
end --function

---------
function GoGo_OnEvent(event)
---------
	if event == "VARIABLES_LOADED" then
		GoGo_DebugLog = {}
		if not GoGo_Prefs then
			GoGo_Settings_Default()
		end --if
		if not GoGo_Prefs.version then
			GoGo_Settings_Default()
		elseif GoGo_Prefs.version ~= GetAddOnMetadata("GoGoMount", "Version") then
			GoGo_Settings_SetUpdates()
		end --if
		GoGo_Prefs.UnknownMounts = {}
		GoGo_Variables.VerMajor, GoGo_Variables.VerMinor, GoGo_Variables.VerBuild = tonumber(GetAddOnMetadata("GoGoMount", "Version"))
		GoGo_Variables.TestVersion = false
		GoGo_Variables.Debug = false
		_, GoGo_Variables.Player.Class = UnitClass("player")
		_, GoGo_Variables.Player.Race = UnitRace("player")
		if (GoGo_Variables.Player.Class == "DRUID") then
			GoGo_Variables.Druid = {}
			GoGoFrame:RegisterEvent("PLAYER_REGEN_DISABLED")
			GoGo_Druid_Panel()
			GoGo_Panel_UpdateViews("DRUID")
		elseif (GoGo_Variables.Player.Class == "SHAMAN") then
			GoGo_Variables.Shaman = {}
			GoGoFrame:RegisterEvent("PLAYER_REGEN_DISABLED")
		elseif (GoGo_Variables.Player.Class == "HUNTER") then
			GoGo_Hunter_Panel()
			GoGo_Panel_UpdateViews("HUNTER")
		end --if
		GoGo_Variables.AzerothZones = table.concat({GetMapZones(1)}, ":")..":"..table.concat({GetMapZones(2)}, ":")
		GoGo_Variables.OutlandZones = table.concat({GetMapZones(3)}, ":")..":"..GoGo_Variables.Localize.Zone.TwistingNether
		GoGo_Variables.NorthrendZones = table.concat({GetMapZones(4)}, ":")..":"..GoGo_Variables.Localize.Zone.TheFrozenSea
		GoGo_Variables.MaelstromZones = table.concat({GetMapZones(5)}, ":")
		GoGo_Panel_Options()
		GoGo_Panel_UpdateViews()
--		GoGo_Panel_GlobalFavorites_Populate()
		GoGo_BuildExcludeList()
		
	elseif event == "PLAYER_REGEN_DISABLED" then
		for i, button in ipairs({GoGoButton, GoGoButton2, GoGoButton3}) do
			if GoGo_Variables.Player.Class == "SHAMAN" then
				GoGo_FillButton(button, GoGo_InBook(GOGO_SPELLS["SHAMAN"]))
			elseif GoGo_Variables.Player.Class == "DRUID" then
				GoGo_ZoneCheck()  -- Checking to see what we can and can not do in zones
				GoGo_FillButton(button, GoGo_InBook(GOGO_SPELLS["DRUID"]))
			end --if
		end --for
	elseif event == "ZONE_CHANGED_NEW_AREA" then
		SetMapToCurrentZone()
		GoGo_Variables.Player.Zone = GetRealZoneText()
	elseif event == "TAXIMAP_OPENED" then
		GoGo_Dismount()
	elseif event == "UPDATE_BINDINGS" then
		if not InCombatLockdown() then  -- ticket 213
			GoGo_CheckBindings()
		end --if
	elseif event == "UI_ERROR_MESSAGE" then
		if GOGO_ERRORS[arg1] and not IsFlying() then
			GoGo_Dismount()
		end --if
	elseif (event == "PLAYER_ENTERING_WORLD") then
		GoGo_Variables.Player.Zone = GetRealZoneText()
		GoGo_Variables.Localize.SeaLegs_Name = GetSpellInfo(GoGo_Variables.Localize.SeaLegs)  -- 4.0.1 (without Cataclysm will not return a value here - used later on.

--		if GoGo_Variables.Debug then
--			GoGo_DebugAddLine("EVENT: Player Entering World")
--		end --if
--		GoGo_BuildMountSpellList()
--		GoGo_BuildMountItemList()
--		GoGo_BuildMountList()
--		GoGo_CheckForUnknownMounts()
--	elseif (event == "COMPANION_LEARNED") then
--		if GoGo_Variables.Debug then
--			GoGo_DebugAddLine("EVENT: Companion Learned")
--		end --if
--		GoGo_BuildMountSpellList()
--		GoGo_BuildMountList()
--		GoGo_CheckForUnknownMounts()

		--	elseif (event == "BAG_UPDATE") then   -- currently causing a noticable lag when moving bag items around
--		if GoGo_Variables.Debug then
--			GoGo_DebugAddLine("EVENT: Bag Update")
--		end --if
--		GoGo_BuildMountItemList()
--		GoGo_BuildMountList()
	elseif (event == "CHAT_MSG_ADDON") and (arg1 == "GoGoMountVER") and not GoGo_Prefs.DisableUpdateNotice then
		local major, minor, build = tonumber(arg2)
		if not GoGo_Variables.UpdateShown then
			local GoGo_ShowUpdate = false
			if major > GoGo_Variables.VerMajor then
				GoGo_ShowUpdate = true
			elseif (major == GoGo_Variables.VerMajor) and (minor > GoGo_Variables.VerMinor) then
				GoGo_ShowUpdate = true
			elseif (major == GoGo_Variables.VerMajor) and (minor > GoGo_Variables.VerMinor) and (build > GoGo_Variables.VerBuild) then
				GoGo_ShowUpdate = true
			end --if
			
			if GoGo_ShowUpdate then
				GoGo_Variables.UpdateShown = true
				GoGo_Msg(GoGo_Variables.Localize.String.NewVersionFound)
			end --if
		end --if
	end --if
end --function

---------
function GoGo_OnSlash(msg)
---------
	if GOGO_COMMANDS[string.lower(msg)] then
		GOGO_COMMANDS[string.lower(msg)]()
	elseif string.find(msg, "spell:%d+") or string.find(msg, "item:%d+") then
		local FItemID = string.gsub(msg,".-\124H([^\124]*)\124h.*", "%1");
		local idtype, itemid = strsplit(":",FItemID);
		if string.find(msg, "exclude", 1, true) then
			GoGo_GlobalExcludeModify(itemid)
		else
			GoGo_AddPrefMount(tonumber(itemid))
			GoGo_Msg("pref")
		end --if
	else
		GoGo_Msg("optiongui")
		GoGo_Msg("auto")
		GoGo_Msg("updatenotice")
		GoGo_Msg("mountnotice")
		if GoGo_Variables.Player.Class == "DRUID" then GoGo_Msg("druidclickform") end --if
		if GoGo_Variables.Player.Class == "DRUID" then GoGo_Msg("druidflightform") end --if
		GoGo_Msg("pref")
		GoGo_Msg("globalexclude")
	end --if
end --function

---------
function GoGo_PreClick(button)
---------
	if GoGo_Variables.Debug then
		_ = GoGo_DebugCollectInformation()
		GoGo_DebugAddLine("GoGo_PreClick: Starts")
	end --if
	
	if not InCombatLockdown() then
		GoGo_FillButton(button)
	end --if

	if IsMounted() or CanExitVehicle() then
		if GoGo_Variables.Debug then
			GoGo_DebugAddLine("GoGo_PreClick: Player is mounted and is being dismounted.")
		end --if
		GoGo_Dismount()
	elseif GoGo_Variables.Player.Class == "DRUID" and GoGo_IsShifted() and not InCombatLockdown() then
		if GoGo_Variables.Debug then
			GoGo_DebugAddLine("GoGo_PreClick: Player is a druid, is shifted and not in combat.")
		end --if
		GoGo_Dismount(button)
	elseif GoGo_Variables.Player.Class == "SHAMAN" and UnitBuff("player", GoGo_InBook(GoGo_Variables.Localize.GhostWolf)) then
		if GoGo_Variables.Debug then
			GoGo_DebugAddLine("GoGo_PreClick: Player is a shaman and is in wolf form.  Standing up.")
		end --if
		GoGo_Dismount(button)
	elseif not InCombatLockdown() then
		if GoGo_Variables.Debug then
			GoGo_DebugAddLine("GoGo_PreClick: Player not in combat, button pressed, looking for a mount.")
		end --if
		GoGo_FillButton(button, GoGo_GetMount())
	end --if
	
	if not GoGo_Variables.TestVersion then
		if ( IsInGuild() ) then
			SendAddonMessage("GoGoMountVER", GetAddOnMetadata("GoGoMount", "Version"), "GUILD")
		end --if
--			SendAddonMessage("GoGoMountVER", GetAddOnMetadata("GoGoMount", "Version"), "BATTLEGROUND")
--			SendAddonMessage("GoGoMountVER", GetAddOnMetadata("GoGoMount", "Version"), "RAID")
	end --if
	GoGo_Variables.Debug = false
end --function

---------
function GoGo_GetMount()
---------

	local selectedmount = GoGo_ChooseMount()

--	if (GoGo_Variables.Player.Class == "PALADIN") and GoGo_Prefs.PaliUseCrusader and GoGo_InBook(GoGo_Variables.Localize.CrusaderAura) then
--		local modifier = GetSpellInfo(GoGo_Variables.Localize.CrusaderAura)
--		selectedmount = selectedmount .. "\n /stopcasting;\n /cast " .. modifier
--	end --if
	
	return selectedmount
	
end --function

---------
function GoGo_ChooseMount()
---------
	GoGo_Variables.CanRide = true  -- resetting canride flag
	GoGo_Variables.CanFly = true  -- resetting canfly flag

	local mounts = {}
	local GoGo_FilteredMounts = {}
	GoGo_Variables.Player.Zone = GetRealZoneText()
	GoGo_Variables.Player.SubZone = GetSubZoneText()
	GoGo_Variables.EngineeringLevel = GoGo_GetProfSkillLevel(GoGo_Variables.Localize.Skill.Engineering)
	GoGo_Variables.TailoringLevel = GoGo_GetProfSkillLevel(GoGo_Variables.Localize.Skill.Tailoring)
	GoGo_Variables.RidingLevel = GoGo_GetRidingSkillLevel() or 0

	if (GoGo_Variables.Player.Class == "DRUID") then
		GoGo_Variables.Druid.FeralSwiftness, _ = GoGo_GetTalentInfo(GoGo_Variables.Localize.Talent.FeralSwiftness)
	elseif (GoGo_Variables.Player.Class == "SHAMAN") then
		GoGo_Variables.Shaman.AncestralSwiftness, _ = GoGo_GetTalentInfo(GoGo_Variables.Localize.Talent.AncestralSwiftness)
	end --if
	
	if GoGo_Variables.Debug then
		GoGo_DebugAddLine("GoGo_ChooseMount: " .. GoGo_Variables.Localize.Skill.Engineering .. " = "..GoGo_Variables.EngineeringLevel)
		GoGo_DebugAddLine("GoGo_ChooseMount: " .. GoGo_Variables.Localize.Skill.Tailoring .. " = "..GoGo_Variables.TailoringLevel)
		GoGo_DebugAddLine("GoGo_ChooseMount: " .. GoGo_Variables.Localize.Skill.Riding .. " = "..GoGo_Variables.RidingLevel)
	end --if

	if (table.getn(mounts) == 0) then
		if GoGo_Prefs[GoGo_Variables.Player.Zone] then
			GoGo_FilteredMounts = GoGo_Prefs[GoGo_Variables.Player.Zone] or {}
--			GoGo_DisableUnknownMountNotice = true
		end --if
	end --if
	if GoGo_Variables.Debug then
		GoGo_DebugAddLine("GoGo_ChooseMount: Checked for zone favorites.")
	end --if

	if (table.getn(mounts) == 0) and (table.getn(GoGo_FilteredMounts) == 0) then
		if GoGo_Prefs.GlobalPrefMounts then
			GoGo_FilteredMounts = GoGo_Prefs.GlobalPrefMounts or {}
--			GoGo_DisableUnknownMountNotice = true
		end --if
		if GoGo_Variables.Debug then
			GoGo_DebugAddLine("GoGo_ChooseMount: Checked for global favorites.")
		end --if
	end --if

	if (table.getn(mounts) == 0) and (table.getn(GoGo_FilteredMounts) == 0) then
		if GoGo_Variables.Debug then
			GoGo_DebugAddLine("GoGo_ChooseMount: Checking for spell and item mounts.")
		end --if
		-- Not updating bag items on bag changes right now so scan and update list
		GoGo_BuildMountSpellList()
		GoGo_BuildMountItemList()
		GoGo_BuildMountList()
		if not GoGo_Prefs.DisableMountNotice and not GoGo_DisableUnknownMountNotice then
			GoGo_CheckForUnknownMounts()
		end --if
		GoGo_FilteredMounts = GoGo_Variables.MountList or {}
	end --if

	if GoGo_Variables.Debug then
		GoGo_DebugAddLine("GoGo_ChooseMount: ** Searched all areas for mounts.")
	end --if
	
--	if (table.getn(GoGo_FilteredMounts) == 0) then
--		if GoGo_Variables.Player.Class == "SHAMAN" then
--			if GoGo_Variables.Debug then
--				GoGo_DebugAddLine("GoGo_ChooseMount: No mounts found. Forcing shaman shape form.")
--			end --if
--			return GoGo_InBook(GOGO_SPELLS["SHAMAN"])
--		elseif GoGo_Variables.Player.Class == "DRUID" then
--			if GoGo_Variables.Debug then
--				GoGo_DebugAddLine("GoGo_ChooseMount: No mounts found. Forcing druid shape form.")
--			end --if
--			return GoGo_InBook(GOGO_SPELLS["DRUID"])
--		else
--			if GoGo_Variables.Debug then
--				GoGo_DebugAddLine("GoGo_ChooseMount: No mounts found.  Giving up.")
--			end --if
--			return nil
--		end --if
--	end --if

	GoGo_UpdateMountData()  -- update mount information with changes from talents, glyphs, etc.

	if GoGo_Variables.EngineeringLevel <= 299 then
		GoGo_FilteredMounts = GoGo_FilterMountsOut(GoGo_FilteredMounts, 45)
		GoGo_FilteredMounts = GoGo_FilterMountsOut(GoGo_FilteredMounts, 46)
	elseif GoGo_Variables.EngineeringLevel >= 300 and GoGo_Variables.EngineeringLevel <= 374 then
		GoGo_FilteredMounts = GoGo_FilterMountsOut(GoGo_FilteredMounts, 46)
	elseif GoGo_Variables.EngineeringLevel >= 375 then
		-- filter nothing
	else
		GoGo_FilteredMounts = GoGo_FilterMountsOut(GoGo_FilteredMounts, 45)
		GoGo_FilteredMounts = GoGo_FilterMountsOut(GoGo_FilteredMounts, 46)
	end --if
	if GoGo_Variables.TailoringLevel <= 299 then
		GoGo_FilteredMounts = GoGo_FilterMountsOut(GoGo_FilteredMounts, 49)
		GoGo_FilteredMounts = GoGo_FilterMountsOut(GoGo_FilteredMounts, 48)
		GoGo_FilteredMounts = GoGo_FilterMountsOut(GoGo_FilteredMounts, 47)
	elseif GoGo_Variables.TailoringLevel >= 300 and GoGo_Variables.TailoringLevel <= 424 then
		GoGo_FilteredMounts = GoGo_FilterMountsOut(GoGo_FilteredMounts, 49)
		GoGo_FilteredMounts = GoGo_FilterMountsOut(GoGo_FilteredMounts, 47)
	elseif GoGo_Variables.TailoringLevel >= 425 and GoGo_Variables.TailoringLevel <= 449 then
		GoGo_FilteredMounts = GoGo_FilterMountsOut(GoGo_FilteredMounts, 47)
	elseif GoGo_Variables.TailoringLevel >= 450 then
		-- filter nothing
	else
		GoGo_FilteredMounts = GoGo_FilterMountsOut(GoGo_FilteredMounts, 49)
		GoGo_FilteredMounts = GoGo_FilterMountsOut(GoGo_FilteredMounts, 48)
		GoGo_FilteredMounts = GoGo_FilterMountsOut(GoGo_FilteredMounts, 47)
	end --if
	if GoGo_Variables.RidingLevel <= 224 then
		GoGo_FilteredMounts = GoGo_FilterMountsOut(GoGo_FilteredMounts, 36)
		GoGo_FilteredMounts = GoGo_FilterMountsOut(GoGo_FilteredMounts, 35)
	elseif GoGo_Variables.RidingLevel >= 225 and GoGo_Variables.RidingLevel <= 299 then
		GoGo_FilteredMounts = GoGo_FilterMountsOut(GoGo_FilteredMounts, 35)
	elseif GoGo_Variables.RidingLevel >= 300 then
		-- filter nothing
	else
		GoGo_FilteredMounts = GoGo_FilterMountsOut(GoGo_FilteredMounts, 36)
		GoGo_FilteredMounts = GoGo_FilterMountsOut(GoGo_FilteredMounts, 35)
	end --if

	if GoGo_Variables.RidingLevel <= 149 then
		GoGo_TempMounts = GoGo_FilterMountsOut(GoGo_TempMounts, 29)
	end --if

	if GoGo_Variables.RidingLevel <= 74 then
		GoGo_FilteredMounts = GoGo_FilterMountsOut(GoGo_FilteredMounts, 37)
		GoGo_FilteredMounts = GoGo_FilterMountsOut(GoGo_FilteredMounts, 38)
	elseif GoGo_Variables.RidingLevel >= 75 and GoGo_Variables.RidingLevel <= 149 then
		GoGo_FilteredMounts = GoGo_FilterMountsOut(GoGo_FilteredMounts, 37)
	end --if

	-- removing zone specific mounts
--[[	Checking for buff below rather than zone now
	if GoGo_Variables.Player.Zone ~= GoGo_Variables.Localize.Zone.Vashjir then
		if GoGo_Variables.Debug then
			GoGo_DebugAddLine("GoGo_ChooseMount: Removing Vashj'ir mounts since we are not in Vashj'ir.")
		end --if
		GoGo_FilteredMounts = GoGo_FilterMountsOut(GoGo_FilteredMounts, 55)
	end --if
]]

	GoGo_ZoneCheck()  -- Checking to see what we can and can not do in zones

					
	if GoGo_Variables.Player.Zone ~= GoGo_Variables.Localize.Zone.AQ40 then
		if GoGo_Variables.Debug then
			GoGo_DebugAddLine("GoGo_ChooseMount: Removing AQ40 mounts since we are not in AQ40.")
		end --if
		GoGo_FilteredMounts = GoGo_FilterMountsOut(GoGo_FilteredMounts, 50)
	end --if

	if GoGo_Variables.Localize.SeaLegs_Name then  -- check to see if this spell exists - only exists for 4.x with Cataclysm expansion
		if UnitBuff("player", GetSpellInfo(GoGo_Variables.Localize.SeaLegs)) then
			if GoGo_Variables.Debug then
				GoGo_DebugAddLine("GoGo_ChooseMount: Sea Legs buff found - not removing Vashj'ir mount.")
			end --if
			-- do nothing, we can use the abyssal seahorse
		else
			if GoGo_Variables.Debug then
				GoGo_DebugAddLine("GoGo_ChooseMount: Sea Legs buff not found - removing Vashj'ir mount.")
			end --if
			GoGo_FilteredMounts = GoGo_FilterMountsOut(GoGo_FilteredMounts, 55)
		end --if
	end --if

	if (GoGo_Variables.Player.Class == "DRUID" and GoGo_Prefs.DruidFormNotRandomize and not GoGo_IsMoving() and not IsFalling()) then
		GoGo_FilteredMounts = GoGo_FilterMountsOut(GoGo_FilteredMounts, 9998)
	end --if
	
	if GoGo_Variables.SelectPassengerMount then
		if GoGo_Variables.Debug then
			GoGo_DebugAddLine("GoGo_ChooseMount: Filtering out all mounts except passenger mounts since passenger mount only was requested.")
		end --if
		GoGo_FilteredMounts = GoGo_FilterMountsIn(GoGo_FilteredMounts, 2) or {}
	end --if

	if IsFalling() then  -- we're falling.. save us  (only grab instant cast spells)
		GoGo_FilteredMounts = GoGo_GetInstantMounts(GoGo_FilteredMounts) or {}
	end --if

	if IsIndoors() then  -- only select what we can use in here..
		GoGo_FilteredMounts = GoGo_GetIndoorMounts(GoGo_FilteredMounts) or {}
	end --if

	if GoGo_IsMoving() then
		GoGo_FilteredMounts = GoGo_GetInstantMounts(GoGo_FilteredMounts) or {}
	end --if
	
	GoGo_FilteredMounts = GoGo_FilterMountsOut(GoGo_FilteredMounts, 9999) or {}
	
	if GoGo_Variables.Debug then
		GoGo_DebugAddLine("GoGo_ChooseMount: Eliminated mounts we can't use, forced shape forms if no mounts found.  Now we select a mount.")
	end --if
	
	if IsSwimming() then  -- find a mount to use in water
		GoGo_Variables.SkipFlyingMount = true
		if not IsIndoors() then
			if (table.getn(mounts) == 0) then
				mounts = GoGo_GetSwimmingMounts450(GoGo_FilteredMounts) or {}
			end --if
			if (table.getn(mounts) == 0) then
				mounts = GoGo_GetSwimmingMounts100(GoGo_FilteredMounts) or {}
			end --if
			if (table.getn(mounts) == 0) then
				mounts = GoGo_GetSwimmingMounts60(GoGo_FilteredMounts) or {}
			end --if
			if (table.getn(mounts) == 0) then
				mounts = GoGo_GetSwimmingMounts50(GoGo_FilteredMounts) or {}
			end --if
			if (table.getn(mounts) == 0) then
				local GoGo_GroundMounts = GoGo_GetGroundMounts100(GoGo_FilteredMounts) or {}
				if table.getn(GoGo_GroundMounts) > 0 then
					for counter = 1, table.getn(GoGo_GroundMounts) do
						table.insert(mounts, GoGo_GroundMounts[counter])
					end --for
				end --if
				GoGo_GroundMounts = GoGo_GetGroundMounts60(GoGo_FilteredMounts) or {}
				if table.getn(GoGo_GroundMounts) > 0 then
					for counter = 1, table.getn(GoGo_GroundMounts) do
						table.insert(mounts, GoGo_GroundMounts[counter])
					end --for
				end --if
				GoGo_GroundMounts = GoGo_GetGroundMounts40(GoGo_FilteredMounts) or {}
				if table.getn(GoGo_GroundMounts) > 0 then
					for counter = 1, table.getn(GoGo_GroundMounts) do
						table.insert(mounts, GoGo_GroundMounts[counter])
					end --for
				end --if
				GoGo_GroundMounts = GoGo_GetGroundMounts35(GoGo_FilteredMounts) or {}
				if table.getn(GoGo_GroundMounts) > 0 then
					for counter = 1, table.getn(GoGo_GroundMounts) do
						table.insert(mounts, GoGo_GroundMounts[counter])
					end --for
				end --if
				GoGo_GroundMounts = GoGo_GetGroundMounts30(GoGo_FilteredMounts) or {}
				if table.getn(GoGo_GroundMounts) > 0 then
					for counter = 1, table.getn(GoGo_GroundMounts) do
						table.insert(mounts, GoGo_GroundMounts[counter])
					end --for
				end --if
				GoGo_GroundMounts = GoGo_GetGroundMounts15(GoGo_FilteredMounts) or {}
				if table.getn(GoGo_GroundMounts) > 0 then
					for counter = 1, table.getn(GoGo_GroundMounts) do
						table.insert(mounts, GoGo_GroundMounts[counter])
					end --for
				end --if
				GoGo_GroundMounts = GoGo_GetGroundMounts10(GoGo_FilteredMounts) or {}
				if table.getn(GoGo_GroundMounts) > 0 then
					for counter = 1, table.getn(GoGo_GroundMounts) do
						table.insert(mounts, GoGo_GroundMounts[counter])
					end --for
				end --if
				GoGo_GroundMounts = GoGo_GetGroundMounts0(GoGo_FilteredMounts) or {}
				if table.getn(GoGo_GroundMounts) > 0 then
					for counter = 1, table.getn(GoGo_GroundMounts) do
						table.insert(mounts, GoGo_GroundMounts[counter])
					end --for
				end --if
			end --if
		else  -- we are indoors
			if (table.getn(mounts) == 0) and (GoGo_Variables.Player.Class == "DRUID") and GoGo_InBook(GoGo_Variables.Localize.AquaForm) then
				return GoGo_InBook(GoGo_Variables.Localize.AquaForm)
			end --if
		end --if
	else		
		GoGo_FilteredMounts = GoGo_FilterMountsOut(GoGo_FilteredMounts, 53)
	end --if

	local GoGo_TempMounts = {}

	if (table.getn(mounts) == 0) and GoGo_CanFly() and not GoGo_Variables.SkipFlyingMount and GoGo_Variables.CanFly then
		if GoGo_Variables.Debug then
			GoGo_DebugAddLine("GoGo_ChooseMount: Looking for flying mounts since we past flight checks.")
		end --if

		-- Druid stuff... 
		-- Use flight forms if preferred
		if GoGo_Variables.Player.Class == "DRUID" and (GoGo_InBook(GoGo_Variables.Localize.FastFlightForm) or GoGo_InBook(GoGo_Variables.Localize.FlightForm)) and GoGo_Prefs.DruidFlightForm then
			if GoGo_Variables.Debug then
				GoGo_DebugAddLine("GoGo_ChooseMount: Druid with preferred flight forms option enabled.  Using flight form.")
			end --if
			return GoGo_InBook(GOGO_SPELLS["DRUID"])
		end --if

		if (table.getn(mounts) == 0) then
			mounts = GoGo_GetAirMounts310(GoGo_FilteredMounts)
		end --if

		-- no epic flyers found - add druid swift flight if available
		if (table.getn(mounts) == 0 and (GoGo_Variables.Player.Class == "Druid") and (GoGo_InBook(GoGo_Variables.Localize.FastFlightForm))) then
			table.insert(mounts, GoGo_Variables.Localize.FastFlightForm)
		end --if

		if (table.getn(mounts) == 0) then
			GoGo_TempMounts = GoGo_FilterMountsIn(GoGo_FilteredMounts, 9)
			mounts = GoGo_FilterMountsIn(GoGo_TempMounts, 22)
		end --if

		-- no slow flying mounts found - add druid flight if available
		if (table.getn(mounts) == 0 and (GoGo_Variables.Player.Class == "Druid") and (GoGo_InBook(GoGo_Variables.Localize.FlightForm))) then
			table.insert(mounts, GoGo_Variables.Localize.FlightForm)
		end --if
	end --if
	
	if (table.getn(GoGo_FilteredMounts) >= 1) then
		--GoGo_FilteredMounts = GoGo_FilterMountsOut(GoGo_FilteredMounts, 1)
		GoGo_FilteredMounts = GoGo_FilterMountsOut(GoGo_FilteredMounts, 36)
		GoGo_FilteredMounts = GoGo_FilterMountsOut(GoGo_FilteredMounts, 35)
	end --if

	if (table.getn(mounts) == 0) and (table.getn(GoGo_FilteredMounts) >= 1) then  -- no flying mounts selected yet - try to use loaned mounts
		GoGo_TempMounts = GoGo_FilterMountsIn(GoGo_FilteredMounts, 52) or {}
		if (table.getn(GoGo_TempMounts) >= 1) and (GoGo_Variables.Player.Zone == GoGo_Variables.Localize.Zone.SholazarBasin or GoGo_Variables.Player.Zone == GoGo_Variables.Localize.Zone.TheStormPeaks or GoGo_Variables.Player.Zone == GoGo_Variables.Localize.Zone.Icecrown) then
			mounts = GoGo_FilterMountsIn(GoGo_FilteredMounts, 52)
		end --if
		GoGo_FilteredMounts = GoGo_FilterMountsOut(GoGo_FilteredMounts, 52)
	end --if
	
	-- Set the oculus mounts as the only mounts available if we're in the oculus, not skiping flying and have them in inventory
	if (table.getn(mounts) == 0) and (table.getn(GoGo_FilteredMounts) >= 1) and (GoGo_Variables.Player.Zone == GoGo_Variables.Localize.Zone.TheOculus) and not GoGo_Variables.SkipFlyingMount then
		GoGo_TempMounts = GoGo_FilterMountsIn(GoGo_FilteredMounts, 54) or {}
		if (table.getn(GoGo_TempMounts) >= 1) then
			mounts = GoGo_TempMounts
			if GoGo_Variables.Debug then
				GoGo_DebugAddLine("GoGo_ChooseMount: In the Oculus, Oculus only mount found, using.")
			end --if
		else
			if GoGo_Variables.Debug then
				GoGo_DebugAddLine("GoGo_ChooseMount: In the Oculus, no oculus mount found in inventory.")
			end --if
		end --if
	else
		GoGo_FilteredMounts = GoGo_FilterMountsOut(GoGo_FilteredMounts, 54)
		if GoGo_Variables.Debug then
			GoGo_DebugAddLine("GoGo_ChooseMount: Not in Oculus or forced ground mount only.")
		end --if
	end --if
	
	
	-- Select ground mounts
	if (table.getn(mounts) == 0) and GoGo_CanRide() and GoGo_Variables.CanRide then
		if GoGo_Variables.Debug then
			GoGo_DebugAddLine("GoGo_ChooseMount: Looking for ground mounts since we can't fly.")
		end --if
	--	GoGo_TempMounts = GoGo_FilterMountsIn(GoGo_FilteredMounts, 21)
--		if GoGo_Variables.RidingLevel <= 225 and GoGo_CanFly() and GoGo_Variables.CanFly then
--			mounts = GoGo_FilterMountsOut(GoGo_TempMounts, 3)
--		else
--			mounts = GoGo_TempMounts
--		end --if
		if (table.getn(mounts) == 0) then
			mounts = GoGo_GetGroundMounts100(GoGo_FilteredMounts) or {}
		end --if
		if (table.getn(mounts) == 0) then
			mounts = GoGo_GetGroundMounts60(GoGo_FilteredMounts) or {}
		end --if
		if (table.getn(mounts) == 0) then
			mounts = GoGo_GetGroundMounts40(GoGo_FilteredMounts) or {}
		end --if
		if (table.getn(mounts) == 0) then
			mounts = GoGo_GetGroundMounts35(GoGo_FilteredMounts) or {}
		end --if
		if (table.getn(mounts) == 0) then
			mounts = GoGo_GetGroundMounts30(GoGo_FilteredMounts) or {}
		end --if
		if (table.getn(mounts) == 0) then
			mounts = GoGo_GetGroundMounts15(GoGo_FilteredMounts) or {}
		end --if
		if (table.getn(mounts) == 0) then
			mounts = GoGo_GetGroundMounts10(GoGo_FilteredMounts) or {}
		end --if
		if (table.getn(mounts) == 0) then
			mounts = GoGo_GetGroundMounts0(GoGo_FilteredMounts) or {}
		end --if
	end --if
	
	if table.getn(GoGo_FilteredMounts) >= 1 then
		GoGo_FilteredMounts = GoGo_FilterMountsOut(GoGo_FilteredMounts, 37)
		GoGo_FilteredMounts = GoGo_FilterMountsOut(GoGo_FilteredMounts, 38)
		GoGo_FilteredMounts = GoGo_FilterMountsOut(GoGo_FilteredMounts, 21)
		GoGo_FilteredMounts = GoGo_FilterMountsOut(GoGo_FilteredMounts, 20)
		GoGo_FilteredMounts = GoGo_FilterMountsOut(GoGo_FilteredMounts, 25)
	end --if
	
	if (table.getn(mounts) >= 1) then
		if GoGo_Variables.Debug then
			for a = 1, table.getn(mounts) do
				GoGo_DebugAddLine("GoGo_ChooseMount: Found mount " .. mounts[a] .. " - included in random pick.")
			end --for
		end --if
		selected = mounts[math.random(table.getn(mounts))]
		if type(selected) == "string" then
			if GoGo_Variables.Debug then
				GoGo_DebugAddLine("GoGo_ChooseMount: Selected string " .. selected)
			end --if
			return selected
		else
			selected = GoGo_GetIDName(selected)
			return selected
		end --if
	end --if
end --function

---------
function GoGo_FilterMountsOut(PlayerMounts, FilterID)
---------
	local GoGo_FilteringMounts = {}
	if not PlayerMounts then PlayerMounts = {} end --if
	if table.getn(PlayerMounts) == 0 then
		return GoGo_FilteringMounts
	end --if
	for a = 1, table.getn(PlayerMounts) do
		local MountID = PlayerMounts[a]
		for DBMountID, DBMountData in pairs(GoGo_Variables.MountDB) do
			if (DBMountID == MountID) and not DBMountData[FilterID] then
				table.insert(GoGo_FilteringMounts, MountID)
			end --if
		end --for
	end --for
	return GoGo_FilteringMounts
end --function

---------
function GoGo_FilterMountsIn(PlayerMounts, FilterID)
---------
	local GoGo_FilteringMounts = {}
	if not PlayerMounts then PlayerMounts = {} end --if
	if table.getn(PlayerMounts) == 0 then
		return GoGo_FilteringMounts
	end --if
	for a = 1, table.getn(PlayerMounts) do
		local MountID = PlayerMounts[a]
		for DBMountID, DBMountData in pairs(GoGo_Variables.MountDB) do
			if (DBMountID == MountID) and DBMountData[FilterID] then
				table.insert(GoGo_FilteringMounts, MountID)
			end --if
		end --for
	end --for
	return GoGo_FilteringMounts
end --function

---------
function GoGo_Dismount(button)
---------
	if IsMounted() then
		Dismount()
	elseif CanExitVehicle() then	
		VehicleExit()
	elseif GoGo_Variables.Player.Class == "DRUID" then
		if GoGo_IsShifted() and button then
			if GoGo_Prefs.DruidClickForm and not IsFlying() then
				GoGo_FillButton(button, GoGo_GetMount())
			else
--				CancelUnitBuff("player", GoGo_IsShifted())  -- protected by blizzard now
				GoGo_FillButton(button, GoGo_IsShifted())
			end --if
		end --if
	elseif GoGo_Variables.Player.Class == "SHAMAN" and UnitBuff("player", GoGo_InBook(GoGo_Variables.Localize.GhostWolf)) and button then
--		CancelUnitBuff("player", GoGo_InBook(GoGo_Variables.Localize.GhostWolf))
		GoGo_FillButton(button, GoGo_InBook(GoGo_Variables.Localize.GhostWolf))
	else
		return nil
	end --if
	return true
end --function

---------
function GoGo_InCompanions(item)
---------
	for slot = 1, GetNumCompanions("MOUNT") do
		local _, _, spellID = GetCompanionInfo("MOUNT", slot)
		if spellID and string.find(item, spellID) then
			if GoGo_Variables.Debug then 
				GoGo_DebugAddLine("GoGo_InCompanions: Found mount name  " .. GetSpellInfo(spellID) .. " in mount list.")
			end --if
			return GetSpellInfo(spellID)
		end --if
	end --for
end --function

---------
function GoGo_BuildMountList()
---------
	GoGo_Variables.MountList = {}
	if (table.getn(GoGo_Variables.MountSpellList) > 0) then
		for a=1, table.getn(GoGo_Variables.MountSpellList) do
			table.insert(GoGo_Variables.MountList, GoGo_Variables.MountSpellList[a])
		end --for
	end --if
	
	if (table.getn(GoGo_Variables.MountItemList) > 0) then
		for a=1, table.getn(GoGo_Variables.MountItemList) do
			table.insert(GoGo_Variables.MountList, GoGo_Variables.MountItemList[a])
		end --for
	end --if

	return GoGo_Variables.MountList
end  --function

---------
function GoGo_BuildMountSpellList()
---------
	GoGo_Variables.MountSpellList = {}
	if (GetNumCompanions("MOUNT") >= 1) then
		for slot = 1, GetNumCompanions("MOUNT"),1 do
			local _, _, SpellID = GetCompanionInfo("MOUNT", slot)
			if GoGo_Variables.Debug then 
				GoGo_DebugAddLine("GoGo_BuildMountSpellList: Found mount spell ID " .. SpellID .. " at slot " .. slot .. " and added to known mount list.")
			end --if
			table.insert(GoGo_Variables.MountSpellList, SpellID)
		end --for
	end --if
	
	if GoGo_Variables.Player.Class == "DRUID" then
		if GoGo_InBook(GoGo_Variables.Localize.AquaForm) then
			table.insert(GoGo_Variables.MountSpellList, GoGo_Variables.Localize.AquaForm)
		end --if
		if GoGo_InBook(GoGo_Variables.Localize.CatForm) then
			table.insert(GoGo_Variables.MountSpellList, GoGo_Variables.Localize.CatForm)
		end --if
		if GoGo_InBook(GoGo_Variables.Localize.FlightForm) then
			table.insert(GoGo_Variables.MountSpellList, GoGo_Variables.Localize.FlightForm)
		end --if
		if GoGo_InBook(GoGo_Variables.Localize.FastFlightForm) then
			table.insert(GoGo_Variables.MountSpellList, GoGo_Variables.Localize.FastFlightForm)
		end --if
		if GoGo_InBook(GoGo_Variables.Localize.TravelForm) then
			table.insert(GoGo_Variables.MountSpellList, GoGo_Variables.Localize.TravelForm)
		end --if
	elseif GoGo_Variables.Player.Class == "SHAMAN" then
		if GoGo_InBook(GoGo_Variables.Localize.GhostWolf) then
			table.insert(GoGo_Variables.MountSpellList, GoGo_Variables.Localize.GhostWolf)
		end --if
	elseif GoGo_Variables.Player.Class == "HUNTER" then
		if GoGo_InBook(GoGo_Variables.Localize.AspectPack) and GoGo_Prefs.AspectPack then
			table.insert(GoGo_Variables.MountSpellList, GoGo_Variables.Localize.AspectPack)
		elseif GoGo_InBook(GoGo_Variables.Localize.AspectCheetah) then
			table.insert(GoGo_Variables.MountSpellList, GoGo_Variables.Localize.AspectCheetah)
		end --if
		
	end --if

	if GoGo_Variables.Player.Race == "Worgen" then
		if (GoGo_InBook(GoGo_Variables.Localize.RunningWild)) then
			if GoGo_Variables.Debug then 
				GoGo_DebugAddLine("GoGo_BuildMountSpellList: We are a Worgen and have Running Wild - added to known mount list.")
			end --if
			table.insert(GoGo_Variables.MountSpellList, GoGo_Variables.Localize.RunningWild)
		end --if
	end --if
	return GoGo_Variables.MountSpellList
end  -- function

---------
function GoGo_BuildMountItemList()
---------
	GoGo_Variables.MountItemList = {}
	
	for a = 1, table.getn(GoGo_MountsItems) do
		local MountID = GoGo_MountsItems[a]
		if GoGo_InBags(MountID) then
			if GoGo_Variables.Debug then 
				GoGo_DebugAddLine("GoGo_BuildMountItemList: Found mount item ID " .. MountID .. " in a bag and added to known mount list.")
			end --if
			table.insert(GoGo_Variables.MountItemList, MountID)
		end --if
	end --for
	return GoGo_Variables.MountItemList
end --function

---------
function GoGo_InBags(item)
---------
	if GoGo_Variables.Debug then
		GoGo_DebugAddLine("GoGo_InBags: Searching for " .. item)
	end --if

	for bag = 0, NUM_BAG_FRAMES do
		for slot = 1, GetContainerNumSlots(bag) do
			local link = GetContainerItemLink(bag, slot)
			if link then
				local _, itemid, _ = strsplit(":",link,3)
				if tonumber(itemid) == item then
					if GoGo_Variables.Debug then 
						GoGo_DebugAddLine("GoGo_InBags: Found item ID " .. item .. " in bag " .. (bag+1) .. ", at slot " .. slot .. " and added to known mount list.")
					end --if
					return GetItemInfo(link)
				end --if
			end --if
		end --for
	end --for
end --function

---------
function GoGo_InBook(spell)
---------
	if GoGo_Variables.Debug then
		GoGo_DebugAddLine("GoGo_InBook: Searching for type " .. type(spell))
	end --if
	if type(spell) == "function" then
		return spell()
	else
		if type(spell) == "string" then
			if GoGo_Variables.Debug then
				GoGo_DebugAddLine("GoGo_InBook: Searching for " .. spell)
			end --if
			local slot = 1
			while GetSpellBookItemName(slot, "spell") do
				local name = GetSpellBookItemName(slot, "spell")
				if name == spell then
					if IsSpellKnown(spell) then  -- make sure we know the spell and not seeing it as a learnable spell in the book
						return spell
					end --if
				end --if
				slot = slot + 1
			end --while
		elseif type(spell) == "number" then
			local spellname = GetSpellInfo(spell)
			if GoGo_Variables.Debug then
				GoGo_DebugAddLine("GoGo_InBook: Searching for spell ID " .. spell)
			end --if
			local slot = 1
			while GetSpellBookItemName(slot, "spell") do
				local name = GetSpellBookItemName(slot, "spell")
				if name == spellname then
					if IsSpellKnown(spell) then  -- make sure we know the spell and not seeing it as a learnable spell in the book
						return name
					end --if
				end --if
				slot = slot + 1
			end --while
			-- blah
		end --if
	end --if
end --function

---------
function GoGo_IsShifted()
---------
	if GoGo_Variables.Debug then
		GoGo_DebugAddLine("GoGo_IsShifted:  GoGo_IsShifted starting")
	end --if
	for i = 1, GetNumShapeshiftForms() do
		local _, name, active = GetShapeshiftFormInfo(i)
		if active then
			if GoGo_Variables.Debug then
				GoGo_DebugAddLine("GoGo_IsShifted: Found " .. name)
			end --if
			return name
		end
	end --for
end --function

---------
function GoGo_InOutlands()
---------
	if string.find(GoGo_Variables.OutlandZones, GoGo_Variables.Player.Zone, 1, true) then
		return true
	end --if
end --function

---------
function GoGo_InNorthrend()
---------
	if string.find(GoGo_Variables.NorthrendZones, GoGo_Variables.Player.Zone, 1, true) then
		return true
	end --if
end --function

---------
function GoGo_InAzeroth()
---------
	if string.find(GoGo_Variables.AzerothZones, GoGo_Variables.Player.Zone, 1, true) then
		return true
	end --if
end --function

function GoGo_InMaelstrom()
---------
	if string.find(GoGo_Variables.MaelstromZones, GoGo_Variables.Player.Zone, 1, true) then
		return true
	end --if
end --function

---------
function GoGo_GlobalExcludeClear()
---------
	local GoGo_TempID = "0"
	if table.getn(GoGo_Prefs.GlobalExclude) > 0 then
		for GoGo_TempCounter = 1, table.getn(GoGo_Prefs.GlobalExclude) do
			GoGo_TempID = GoGo_Prefs.GlobalExclude[GoGo_TempCounter]
			GoGo_Variables.MountDB[GoGo_TempID][9999] = false
		end --for
	end --if
	GoGo_Prefs.GlobalExclude = {}
end --function

---------
function GoGo_GlobalExcludeAdd(SpellID)
---------
	SpellID = tonumber(SpellID)
	table.insert(GoGo_Prefs.GlobalExclude, SpellID)
	GoGo_Variables.MountDB[SpellID][9999] = true
end --function

---------
function GoGo_BuildExcludeList()
---------
	if table.getn(GoGo_Prefs.GlobalExclude) > 0 then
		local GoGo_TempTable = {}
		GoGo_TempTable = GoGo_Prefs.GlobalExclude
		GoGo_Prefs.GlobalExclude = {}
		for GoGo_TempCount = 1, table.getn(GoGo_TempTable) do
			GoGo_GlobalExcludeAdd(GoGo_TempTable[GoGo_TempCount])
		end --for
	end --if
end --function

---------
function GoGo_GlobalExcludeModify(SpellID)
---------
	local GoGo_RemovedFlag = false
	SpellID = tonumber(SpellID)
	if table.getn(GoGo_Prefs.GlobalExclude) > 0 then
		for GoGo_TempCounter = 1, table.getn(GoGo_Prefs.GlobalExclude) do
			if (GoGo_Prefs.GlobalExclude[GoGo_TempCounter] == SpellID) then
				GoGo_TempID = GoGo_Prefs.GlobalExclude[GoGo_TempCounter]
				if GoGo_Variables.Debug then
					GoGo_DebugAddLine("GoGo_GlobalExcludeModify: Removing from exclusion list: " .. SpellID .. " " .. GoGo_GetIDName(SpellID))
				end --if
				table.remove(GoGo_Prefs.GlobalExclude, GoGo_TempCounter)
				GoGo_Variables.MountDB[SpellID][9999] = false
				GoGo_RemovedFlag = true
			end --if
		end --for
	end --if
	
	if not GoGo_RemovedFlag then
		GoGo_GlobalExcludeAdd(SpellID)
	end --if
	GoGo_Msg("globalexclude")
end --function

---------
function GoGo_AddPrefMount(spell)
---------
	if GoGo_Variables.Debug then 
		GoGo_DebugAddLine("GoGo_AddPrefMount: Preference " .. spell)
	end --if

	if not GoGo_Prefs.GlobalPrefMount then
		GoGo_Variables.Player.Zone = GetRealZoneText()
		if not GoGo_Prefs[GoGo_Variables.Player.Zone] then GoGo_Prefs[GoGo_Variables.Player.Zone] = {} end
		table.insert(GoGo_Prefs[GoGo_Variables.Player.Zone], spell)
		if table.getn(GoGo_Prefs[GoGo_Variables.Player.Zone]) > 1 then
			local i = 2
			repeat
				if GoGo_Prefs[GoGo_Variables.Player.Zone][i] == GoGo_Prefs[GoGo_Variables.Player.Zone][i - 1] then
					table.remove(GoGo_Prefs[GoGo_Variables.Player.Zone], i)
				else
					i = i + 1
				end --if
			until i > table.getn(GoGo_Prefs[GoGo_Variables.Player.Zone])
		end --if
	else
		if not GoGo_Prefs.GlobalPrefMounts then GoGo_Prefs.GlobalPrefMounts = {} end
		table.insert(GoGo_Prefs.GlobalPrefMounts, spell)
		if table.getn(GoGo_Prefs.GlobalPrefMounts) > 1 then
			local i = 2
			repeat
				if GoGo_Prefs.GlobalPrefMounts[i] == GoGo_Prefs.GlobalPrefMounts[i - 1] then
					table.remove(GoGo_Prefs.GlobalPrefMounts, i)
				else
					i = i + 1
				end --if
			until i > table.getn(GoGo_Prefs.GlobalPrefMounts)
		end --if
	end --if
end --function

---------
function GoGo_CheckForUnknownMounts()
---------
	for a = 1, table.getn(GoGo_Variables.MountSpellList) do
		local MountID = GoGo_Variables.MountSpellList[a]
		if not GoGo_Variables.MountDB[MountID] then
			GoGo_Prefs.UnknownMounts[MountID] = true
			if GoGo_Variables.Debug then
				GoGo_DebugAddLine("GoGo_CheckForUnknownMounts: Unknown mount found:  " .. MountID)
			end --if
			if not GoGo_Prefs.DisableMountNotice and not GoGo_DisableUnknownMountNotice then
				GoGo_DisableUnknownMountNotice = true
				GoGo_Msg("UnknownMount")
			end --if
		end --for
	end --for
end --function

---------
function GoGo_GetIDName(itemid)
---------
	local tempname = ""
	local ItemName = ""
	if type(itemid) == "number" then
		local GoGo_TempMount = {}
		table.insert(GoGo_TempMount, itemid)
		if (table.getn(GoGo_FilterMountsIn(GoGo_TempMount, 4)) == 1) then
			return GetItemInfo(itemid) or "Unknown Mount"
		else
			return GetSpellInfo(itemid) or "Unknown Mount"
		end --if
	elseif type(itemid) == "table" then
		for a=1, table.getn(itemid) do
			tempname = itemid[a]
			local GoGo_TempTable = {}
			table.insert(GoGo_TempTable, tempname)
			if (table.getn(GoGo_FilterMountsIn(GoGo_TempTable, 4)) == 1) then
--				tempname = GetItemInfo(tempname)
				if GoGo_Variables.Debug then
					GoGo_DebugAddLine("GoGo_GetIDName: GetItemID for " .. tempname .. GetItemInfo(tempname))
				end --if
				ItemName = ItemName .. (GetItemInfo(tempname) or "Unknown Mount") .. ", "
			else
--				tempname = GetSpellInfo(tempname)
				if GoGo_Variables.Debug then
					GoGo_DebugAddLine("GoGo_GetIDName: GetSpellID for " .. tempname .. GetSpellInfo(tempname))
				end --if
				ItemName = ItemName .. (GetSpellInfo(tempname) or "Unknown Mount") .. ", "
			end --if
				if GoGo_Variables.Debug then
					GoGo_DebugAddLine("GoGo_GetIDName: Itemname string is " .. ItemName)
				end --if
		end --for
		return ItemName
	end --if
end --function

---------
function GoGo_GetTalentInfo(talentname)
---------
	if GoGo_Variables.Debug then 
		GoGo_DebugAddLine("GoGo_GetTalentInfo: Searching talent tree for " .. talentname)
	end --if
	local numTabs = GetNumTalentTabs()
	for tab=1, numTabs do
		local numTalents = GetNumTalents(tab)
		for talent=1, numTalents do
			local name, _, _, _, rank, maxrank = GetTalentInfo(tab,talent)
			if (talentname == name) then
				if GoGo_Variables.Debug then 
					GoGo_DebugAddLine("GoGo_GetTalentInfo: Found " .. talentname .. " with rank " .. rank)
				end --if
				return rank, maxrank
			end --if
		end --for
	end --for
	return 0,0
end --function

---------
function GoGo_FillButton(button, mount)
---------
	if mount then
		if GoGo_Variables.Debug then 
			GoGo_DebugAddLine("GoGo_FillButton: Casting " .. mount)
		end --if
		button:SetAttribute("macrotext", "/use "..mount)
	else
		button:SetAttribute("macrotext", nil)
	end --if
end --function

---------
function GoGo_CheckBindings()
---------
	for binding, button in pairs({GOGOBINDING = GoGoButton, GOGOBINDING2 = GoGoButton2, GOGOBINDING3 = GoGoButton3}) do
		ClearOverrideBindings(button)
		local key1, key2 = GetBindingKey(binding)
		if key1 then
			SetOverrideBindingClick(button, true, key1, button:GetName())
		end --if
		if key2 then
			SetOverrideBindingClick(button, true, key2, button:GetName())
		end --if
	end --if
end --function

---------
function GoGo_CanFly()
---------
	GoGo_Variables.Player.Zone = GetRealZoneText()
	GoGo_Variables.Player.SubZone = GetSubZoneText()

	local level = UnitLevel("player")

	if (level < 60) then
		if GoGo_Variables.Debug then
			GoGo_DebugAddLine("GoGo_CanFly: Failed - Player under level 60")
		end --if
		return false
	end --if
	
	if GoGo_InOutlands() then
		-- we can fly here
	elseif (GoGo_InNorthrend() and (GoGo_InBook(GoGo_Variables.Localize.ColdWeatherFlying))) then

		if GoGo_Variables.Player.Zone == GoGo_Variables.Localize.Zone.Wintergrasp then
			if GetWintergraspWaitTime() then
				if GoGo_Variables.Debug then
					GoGo_DebugAddLine("GoGo_CanFly: Player in Wintergrasp and battle ground is not active.")
				end --if
				-- timer ticking to start wg.. we can mount
			else
				if GoGo_Variables.Debug then
					GoGo_DebugAddLine("GoGo_CanFly: Failed - Player in Wintergrasp and battle ground is active.")
				end --if
				-- we should be in battle.. can't mount
				return false
			end --if
		end --if
	elseif (GoGo_InMaelstrom() and (GoGo_InBook(GoGo_Variables.Localize.FlightMastersLicense))) then
		-- we can fly here
	elseif (GoGo_InAzeroth() and (GoGo_InBook(GoGo_Variables.Localize.FlightMastersLicense))) then
		-- we can fly here
	else
		if GoGo_Variables.Debug then
			GoGo_DebugAddLine("GoGo_CanFly: Failed - Player does not meet any flyable conditions.")
		end --if
		return false  -- we can't fly anywhere else
	end --if
	
	return true
end --function

---------
function GoGo_ZoneCheck()
--------- 
	if GoGo_Variables.Player.Zone == GoGo_Variables.Localize.Zone.Deepholm then
		if GoGo_Variables.Player.SubZone == GoGo_Variables.Localize.Zone.TempleOfEarth then
			if GoGo_Variables.Debug then
				GoGo_DebugAddLine("GoGo_ZoneCheck: Deactivating Riding - in Deepholm / Temple of Earth.")
			end --if
			GoGo_Variables.CanRide = false
		elseif GoGo_Variables.Player.SubZone == GoGo_Variables.Localize.Zone.CrumblingDepths then
			if GoGo_Variables.Debug then
				GoGo_DebugAddLine("GoGo_ZoneCheck: Deactivating Flying - in Deepholm / Crumbling Depths.")
			end --if
			GoGo_Variables.CanRide = true
			GoGo_Variables.CanFly = false
		end --if
	elseif GoGo_Variables.Player.Zone == GoGo_Variables.Localize.Zone.TolBaradPeninsula then
		if GoGo_Variables.Debug then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Deactivating Flying - in Tol Barad Peninsula.")
		end --if
		GoGo_Variables.CanFly = false
	elseif GoGo_Variables.Player.Zone == GoGo_Variables.Localize.Zone.Dalaran then
		if not IsFlyableArea() then  -- have to use this.. flying is different in sewers and is different between 4.x with and without cataclysm
			if GoGo_Variables.Debug then
				GoGo_DebugAddLine("GoGo_ZoneCheck: Deactivating Flying - Player in " .. GoGo_Variables.Localize.Zone.Dalaran .. " and not in flyable area.")
			end --if
			GoGo_Variables.CanFly = false
		end --if
	elseif GoGo_Variables.Player.Zone == GoGo_Variables.Localize.Zone.DireMaul then
		if GoGo_Variables.Debug then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Deactivating Flying - in Dire Maul area.")
		end --if
		GoGo_Variables.CanFly = false
	elseif GoGo_Variables.Player.Zone == GoGo_Variables.Localize.Zone.Ironforge then
		if GoGo_Variables.Player.SubZone == GoGo_Variables.Localize.Zone.Ironforge then
			if not IsFlyableArea() then  -- area by the gate is flyable but subzone name does not change
				if GoGo_Variables.Debug then
					GoGo_DebugAddLine("GoGo_ZoneCheck: Deactivating Flying - in Ironforge / Ironforge.")
				end --if
				GoGo_Variables.CanFly = false
			end --if
		end --if
	end --if

--	if GoGo_InOutlands() or GoGo_InNorthrend() then
--		GoGo_Variables.MountDB[75973] = {[9] = true, [2] = true, [3] = true, [14] = true, [20] = true, [21] = true, [22] = true, [23] = false, [39] = true, [998] = true}  --make the [X-53 Touring Rocket] a ground / flying mount (Warcraft 4.x without cata can use this as a ground mount in Dalaran)
--	else
--		GoGo_Variables.MountDB[75973] = {[9] = true, [2] = true, [12] = true, [22] = true, [23] = false, [39] = true, [998] = true}  --make the [X-53 Touring Rocket] a flying mount only everywhere (since it can fly in Azeroth with Azeroth flying buff)
--	end --if

end --function

---------
function GoGo_CanRide()
---------
	local level = UnitLevel("player")
	if level >= 20 then
		if GoGo_Variables.Debug then
			GoGo_DebugAddLine("GoGo_CanRide: Passed - Player is over level 20.")
		end --if
		return true
	end --if
end --function

---------
function GoGo_IsMoving()
---------
    if GetUnitSpeed("player") ~= 0 then
        return true
    else
        return false
    end --if
end --function

---------
function GoGo_GetProfSkillLevel(searchname)
---------
	local prof1, prof2 = GetProfessions()
	if prof1 then
		local name, _, rank, maxrank, numspells, spelloffset, skillline = GetProfessionInfo(prof1)
		if (name == searchname) then
			return rank
		end --if
	end --if
	

	if prof2 then
		local name, _, rank, maxrank, numspells, spelloffset, skillline = GetProfessionInfo(prof2)
		if (name == searchname) then
			return rank
		end --if
	end --if
	
	return 0
end --function

---------
function GoGo_GlyphActive(spellid)
---------
	local TempSpellID = 0
--	for TempCount = 1, NUM_GLYPH_SLOTS do  -- NUM_GLYPH_SLOTS currently contains nil until glyph window is open in game
	for TempCount = 1, 10 do
		_, _, TempSpellID = GetGlyphSocketInfo(TempCount) or 0,0,0
		if spellid == TempSpellID then
			if GoGo_Variables.Debug then
				GoGo_DebugAddLine("GoGo_GlyphActive: Found active glyph " .. spellid .. " (" .. GetSpellInfo(spellid) .. ")")
			end --if
			return true
		end --if
	end --for
	if GoGo_Variables.Debug then
		GoGo_DebugAddLine("GoGo_GlyphActive: Not found active glyph " .. spellid .. " (" .. GetSpellInfo(spellid) .. ")")
	end --if

	return false
end --function

---------
function GoGo_GetSkillLevel(searchname)
---------  may not work after cata
	for skillIndex = 1, GetNumSkillLines() do
		skillName, isHeader, isExpanded, skillRank = GetSkillLineInfo(skillIndex)
		if isHeader == nil then
			if skillName == searchname then
				return skillRank
			end --if
		end --if
	end --for
end --function

---------
function GoGo_GetRidingSkillLevel()
--------- 
	if GoGo_InBook(GoGo_Variables.Localize.MasterRiding) then
		return 300
	elseif GoGo_InBook(GoGo_Variables.Localize.ArtisanRiding) then
		return 300
	elseif GoGo_InBook(GoGo_Variables.Localize.ExpertRiding) then
		return 225
	elseif GoGo_InBook(GoGo_Variables.Localize.JourneymanRiding) then
		return 150
	elseif GoGo_InBook(GoGo_Variables.Localize.ApprenticeRiding) then
		return 75
	else
		return 0
	end --if

	-- master riding just makes epic flying mounts faster - no need to search for it specifically
	
end --function

---------
function GoGo_CheckCoOrds(ZoneName, SubZoneName)
---------
	local posX, posY = GetPlayerMapPosition("Player")
	local CanFlyHere = false
	local ZoneName = GoGo_FlyCoOrds[ZoneName]
	local SubZoneName = ZoneName[SubZoneName]
	for a = 1, table.getn(SubZoneName) or 0 do
		if GoGo_Variables.Debug then
			GoGo_DebugAddLine("GoGo_CheckCoOrds: Checking CoOrds " .. a)
		end --if
		local PointAX, PointAY, PointBX, PointBY = SubZoneName[a][1], SubZoneName[a][2], SubZoneName[a][3], SubZoneName[a][4]
		if posX >= PointAX and posX <= PointBX and posY >= PointAY and posY <= PointBY then
			-- we are in the rectangle a
			return true
		end --if
	end --for
	return false
end --function

---------
function GoGo_Msg(msg)
---------
	if msg then
		if GOGO_MESSAGES[msg] then
			GoGo_Msg(GOGO_MESSAGES[msg]())
		else
			msg = string.gsub(msg, "<", LIGHTYELLOW_FONT_COLOR_CODE)
			msg = string.gsub(msg, ">", "|r")
			DEFAULT_CHAT_FRAME:AddMessage(GREEN_FONT_COLOR_CODE.."GoGo: |r"..msg)
		end --if
	end --if
end --function

---------
function GoGo_Id(itemstring)
---------
	local _, _, itemid = string.find(itemstring,"(item:%d+)")
	if itemid then
		return itemid.." - "..itemstring
	end --if
	local _, _, spellid = string.find(itemstring,"(spell:%d+)")
	if spellid then
		return spellid.." - "..itemstring
	end --if

end --function
	
---------
function GoGo_GetSwimmingMounts450(GoGo_FilteredMounts)
---------
	GoGo_FilteredMounts = GoGo_FilterMountsIn(GoGo_FilteredMounts, 30) or {}
	return GoGo_FilteredMounts
end --function

---------
function GoGo_GetSwimmingMounts100(GoGo_FilteredMounts)
---------
	GoGo_FilteredMounts = GoGo_FilterMountsIn(GoGo_FilteredMounts, 60) or {}
	return GoGo_FilteredMounts
end --function

---------
function GoGo_GetSwimmingMounts60(GoGo_FilteredMounts)
---------
	GoGo_FilteredMounts = GoGo_FilterMountsIn(GoGo_FilteredMounts, 27) or {}
	return GoGo_FilteredMounts
end --function

---------
function GoGo_GetSwimmingMounts50(GoGo_FilteredMounts)
---------
	GoGo_FilteredMounts = GoGo_FilterMountsIn(GoGo_FilteredMounts, 34) or {}
	return GoGo_FilteredMounts
end --function

---------
function GoGo_GetGroundMounts100(GoGo_FilteredMounts)
---------
	GoGo_FilteredMounts = GoGo_FilterMountsIn(GoGo_FilteredMounts, 21) or {}
	return GoGo_FilteredMounts
end --function

---------
function GoGo_GetGroundMounts60(GoGo_FilteredMounts)
---------
	GoGo_FilteredMounts = GoGo_FilterMountsIn(GoGo_FilteredMounts, 20) or {}
	return GoGo_FilteredMounts
end --function

---------
function GoGo_GetGroundMounts40(GoGo_FilteredMounts)
---------
	GoGo_FilteredMounts = GoGo_FilterMountsIn(GoGo_FilteredMounts, 28) or {}
	return GoGo_FilteredMounts
end --function

---------
function GoGo_GetGroundMounts35(GoGo_FilteredMounts)
---------
	GoGo_FilteredMounts = GoGo_FilterMountsIn(GoGo_FilteredMounts, 33) or {}
	return GoGo_FilteredMounts
end --function

---------
function GoGo_GetGroundMounts30(GoGo_FilteredMounts)
---------
	GoGo_FilteredMounts = GoGo_FilterMountsIn(GoGo_FilteredMounts, 26) or {}
	return GoGo_FilteredMounts
end --function

---------
function GoGo_GetGroundMounts15(GoGo_FilteredMounts)
---------
	GoGo_FilteredMounts = GoGo_FilterMountsIn(GoGo_FilteredMounts, 32) or {}
	return GoGo_FilteredMounts
end --function

---------
function GoGo_GetGroundMounts10(GoGo_FilteredMounts)
---------
	GoGo_FilteredMounts = GoGo_FilterMountsIn(GoGo_FilteredMounts, 31) or {}
	return GoGo_FilteredMounts
end --function

---------
function GoGo_GetGroundMounts0(GoGo_FilteredMounts)
---------
	GoGo_FilteredMounts = GoGo_FilterMountsIn(GoGo_FilteredMounts, 25) or {}
	return GoGo_FilteredMounts
end --function

---------
function GoGo_GetAirMounts310(GoGo_FilteredMounts)
---------
	-- Grabs 280% / 300% / 310% mounts since they're all the same and scale with the same requirements
	local GoGo_TempMounts = {}
	GoGo_TempMounts = GoGo_FilterMountsIn(GoGo_FilteredMounts, 23) or {}
	if GoGo_Variables.RidingLevel <= 299 then  -- if we only have a riding skill of 225 then we can only fly slowly - don't pick the fast mounts thinking we'll fly them fast
		GoGo_FilteredMounts = GoGo_FilterMountsOut(GoGo_TempMounts, 29)
	else
		GoGo_FilteredMounts = GoGo_TempMounts
	end --if


	return GoGo_FilteredMounts
end --function

---------
function GoGo_GetAirMounts150(GoGo_FilteredMounts)
---------
	-- Grabs 280% / 300% / 310% mounts since they're all the same and scale with the same requirements
	GoGo_FilteredMounts = GoGo_FilterMountsIn(GoGo_FilteredMounts, 22) or {}
	return GoGo_FilteredMounts
end --function

---------
function GoGo_GetInstantMounts(GoGo_FilteredMounts)
---------
	-- Grab all mounts flagged as instant cast for falling or moving conditions
	GoGo_FilteredMounts = GoGo_FilterMountsIn(GoGo_FilteredMounts, 7) or {}
	return GoGo_FilteredMounts
end --function

---------
function GoGo_GetIndoorMounts(GoGo_FilteredMounts)
---------
	GoGo_FilteredMounts = GoGo_FilterMountsIn(GoGo_FilteredMounts, 8) or {}
	return GoGo_FilteredMounts
end --function

---------
function GoGo_GetOculusMounts280(GoGo_FilteredMounts)
---------
	GoGo_FilteredMounts = GoGo_FilterMountsIn(GoGo_FilteredMounts, 54) or {}
	return GoGo_FilteredMounts
end --function

---------
function GoGo_UpdateMountData()
---------

	if (GoGo_Variables.Player.Class == "DRUID") and (GoGo_GetTalentInfo(GoGo_Variables.Localize.Talent.FeralSwiftness) == 1) then
		GoGo_Variables.MountDB[GoGo_Variables.Localize.CatForm][25] = true
		GoGo_Variables.MountDB[GoGo_Variables.Localize.CatForm][32] = true
		GoGo_Variables.MountDB[GoGo_Variables.Localize.CatForm][26] = false
		if GoGo_Variables.Debug then
			GoGo_DebugAddLine("GoGo_UpdateMountData: We're a druid with 1 Feral Swiftness point.  Modifying Catform speed data.")
		end --if
	elseif (GoGo_Variables.Player.Class == "DRUID") and (GoGo_GetTalentInfo(GoGo_Variables.Localize.Talent.FeralSwiftness) == 2) then
		GoGo_Variables.MountDB[GoGo_Variables.Localize.CatForm][25] = true
		GoGo_Variables.MountDB[GoGo_Variables.Localize.CatForm][32] = true
		GoGo_Variables.MountDB[GoGo_Variables.Localize.CatForm][26] = true
		if GoGo_Variables.Debug then
			GoGo_DebugAddLine("GoGo_UpdateMountData: We're a druid with 2 Feral Swiftness points.  Modifying Catform speed data.")
		end --if
	elseif (GoGo_Variables.Player.Class == "DRUID") then
		GoGo_Variables.MountDB[GoGo_Variables.Localize.CatForm][25] = true
		GoGo_Variables.MountDB[GoGo_Variables.Localize.CatForm][32] = false
		GoGo_Variables.MountDB[GoGo_Variables.Localize.CatForm][26] = false
		if GoGo_Variables.Debug then
			GoGo_DebugAddLine("GoGo_UpdateMountData: We're a druid with 0 Feral Swiftness points.  Modifying Catform speed data.")
		end --if
	end --if

	if (GoGo_Variables.Player.Class == "SHAMAN") and (GoGo_GlyphActive(GoGo_Variables.Localize.Glyph_GhostWolf)) then
		GoGo_Variables.MountDB[GoGo_Variables.Localize.GhostWolf][33] = true
		GoGo_Variables.MountDB[GoGo_Variables.Localize.GhostWolf][26] = true
		if GoGo_Variables.Debug then
			GoGo_DebugAddLine("GoGo_UpdateMountData: We're a shaman with Glyph of Ghost Wolf.  Modifying Ghost Wolf speed data.")
		end --if
	elseif (GoGo_Variables.Player.Class == "SHAMAN") then
		GoGo_Variables.MountDB[GoGo_Variables.Localize.GhostWolf][26] = true
		GoGo_Variables.MountDB[GoGo_Variables.Localize.GhostWolf][33] = false
		if GoGo_Variables.Debug then
			GoGo_DebugAddLine("GoGo_UpdateMountData: We're a shaman without Glyph of Ghost Wolf.  Modifying Ghost Wolf speed data.")
		end --if
	end --if

	if (GoGo_Variables.Player.Class == "SHAMAN") and (GoGo_Variables.Shaman.AncestralSwiftness == 2) then
		GoGo_Variables.MountDB[GoGo_Variables.Localize.GhostWolf][7] = true
		if GoGo_Variables.Debug then
			GoGo_DebugAddLine("GoGo_UpdateMountData: We're a shaman with 2 Ancestral Swiftness points.  Modifying Ghost Wolf spell data.")
		end --if
	else
		GoGo_Variables.MountDB[GoGo_Variables.Localize.GhostWolf][7] = false
		if GoGo_Variables.Debug then
			GoGo_DebugAddLine("GoGo_UpdateMountData: We're a shaman with 0 Ancestral Swiftness points.  Modifying Ghost Wolf spell data.")
		end --if
	end --if

	if (GoGo_Variables.Player.Class == "DRUID") and (GoGo_GlyphActive(GoGo_Variables.Localize.Glyph_AquaticForm)) then
		GoGo_Variables.MountDB[GoGo_Variables.Localize.AquaForm][60] = true
		GoGo_Variables.MountDB[GoGo_Variables.Localize.AquaForm][34] = true
		if GoGo_Variables.Debug then
			GoGo_DebugAddLine("GoGo_UpdateMountData: We're a druid with Glyph of Aquatic Form.  Modifying Aquatic Form speed data.")
		end --if
	elseif (GoGo_Variables.Player.Class == "DRUID") then
		GoGo_Variables.MountDB[GoGo_Variables.Localize.AquaForm][34] = true
		GoGo_Variables.MountDB[GoGo_Variables.Localize.AquaForm][60] = false
		if GoGo_Variables.Debug then
			GoGo_DebugAddLine("GoGo_UpdateMountData: We're a druid without Glyph of Aquatic Form.  Modifying Aquatic Form speed data.")
		end --if
	end --if

end --function

GOGO_ERRORS = {
	[SPELL_FAILED_NOT_MOUNTED] = true,
	[SPELL_FAILED_NOT_SHAPESHIFT] = true,
	[ERR_ATTACK_MOUNTED] = true,
}

GOGO_SPELLS = {
	["DRUID"] = function()
		if GoGo_InBook(GoGo_Variables.Localize.AquaForm) then
			if not GoGo_Variables.SkipFlyingMount and GoGo_CanFly() and GoGo_InBook(GoGo_Variables.Localize.FastFlightForm) and GoGo_Variables.CanFly then
				return "[swimming] "..GoGo_InBook(GoGo_Variables.Localize.AquaForm).."; [indoors]"..GoGo_InBook(GoGo_Variables.Localize.CatForm).."; [combat]"..GoGo_InBook(GoGo_Variables.Localize.TravelForm).."; "..GoGo_InBook(GoGo_Variables.Localize.FastFlightForm)
			elseif not GoGo_Variables.SkipFlyingMount and GoGo_CanFly() and GoGo_InBook(GoGo_Variables.Localize.FlightForm) and GoGo_Variables.CanFly then
				return "[swimming] "..GoGo_InBook(GoGo_Variables.Localize.AquaForm).."; [indoors]"..GoGo_InBook(GoGo_Variables.Localize.CatForm).."; [combat]"..GoGo_InBook(GoGo_Variables.Localize.TravelForm).."; "..GoGo_InBook(GoGo_Variables.Localize.FlightForm)
			else
				return "[swimming] "..GoGo_InBook(GoGo_Variables.Localize.AquaForm).."; [indoors]"..GoGo_InBook(GoGo_Variables.Localize.CatForm)..";"..GoGo_InBook(GoGo_Variables.Localize.TravelForm)
			end --if
		end --if
	end, --function
	["SHAMAN"] = function()
		return GoGo_InBook(GoGo_Variables.Localize.GhostWolf)
	end, --function
}

GOGO_COMMANDS = {
	["auto"] = function()
		GoGo_Prefs.autodismount = not GoGo_Prefs.autodismount
		GoGo_Msg("auto")
		GoGo_Panel_UpdateViews()
	end, --function
	["clear"] = function()
		if GoGo_Prefs.GlobalPrefMount then
			GoGo_Prefs.GlobalPrefMounts = nil
			if not InCombatLockdown() then
				for i, button in ipairs({GoGoButton, GoGoButton2}) do
					GoGo_FillButton(button)
				end --for
			end --if
		else
			GoGo_Prefs[GoGo_Variables.Player.Zone] = nil
			if not InCombatLockdown() then
				for i, button in ipairs({GoGoButton, GoGoButton2}) do
					GoGo_FillButton(button)
				end --for
			end --if
		end --if
		GoGo_Msg("pref")
	end, --function
	["updatenotice"] = function()
		GoGo_Prefs.DisableUpdateNotice = not GoGo_Prefs.DisableUpdateNotice
		GoGo_Msg("updatenotice")
		GoGo_Panel_UpdateViews()
	end, --function
	["mountnotice"] = function()
		GoGo_Prefs.DisableMountNotice = not GoGo_Prefs.DisableMountNotice
		GoGo_Msg("mountnotice")
		GoGo_Panel_UpdateViews()
	end, --function
	["druidclickform"] = function()
		GoGo_Prefs.DruidClickForm = not GoGo_Prefs.DruidClickForm
		GoGo_Msg("druidclickform")
		GoGo_Panel_UpdateViews()
	end, --function
	["druidflightform"] = function()
		GoGo_Prefs.DruidFlightForm = not GoGo_Prefs.DruidFlightForm
		GoGo_Msg("druidflightform")
		GoGo_Panel_UpdateViews()
	end, --function
	["options"] = function()
		InterfaceOptionsFrame_OpenToCategory(GoGo_Panel)
	end, --function
}

GOGO_MESSAGES = {
	["auto"] = function()
		if GoGo_Prefs.autodismount then
			return "Autodismount active - </gogo auto> to toggle"
		else
			return "Autodismount inactive - </gogo auto> to toggle"
		end --if
	end, --function
	["pref"] = function()
		local msg = ""
		if not GoGo_Prefs.GlobalPrefMount then
			local list = ""
			if GoGo_Prefs[GoGo_Variables.Player.Zone] then
				list = list .. GoGo_GetIDName(GoGo_Prefs[GoGo_Variables.Player.Zone])
				msg = GoGo_Variables.Player.Zone..": "..list.." - </gogo clear> to clear"
			else
				msg = GoGo_Variables.Player.Zone..": ?".." - </gogo ItemLink> or </gogo SpellName> to add"
			end --if
			if GoGo_Prefs.GlobalPrefMounts then
				list = list .. GoGo_GetIDName(GoGo_Prefs.GlobalPrefMounts)
				msg = msg .. "\nGlobal Preferred Mounts: "..list.." - Enable global mount preferences to change."
			end --if
			return msg
		else
			local list = ""
			if GoGo_Prefs.GlobalPrefMounts then
				list = list .. GoGo_GetIDName(GoGo_Prefs.GlobalPrefMounts)
				msg = "Global Preferred Mounts: "..list.." - </gogo clear> to clear"
			else
				msg =  "Global Preferred Mounts: ?".." - </gogo ItemLink> or </gogo SpellName> to add"
			end --if
			if GoGo_Prefs[GoGo_Variables.Player.Zone] then
				list = list .. GoGo_GetIDName(GoGo_Prefs[GoGo_Variables.Player.Zone])
				msg = msg .. "\n" .. GoGo_Variables.Player.Zone ..": "..list.." - Disable global mount preferences to change."
			end --if
			return msg
		end --if
	end, --function
	["globalexclude"] = function()
		local msg = ""
		if table.getn(GoGo_Prefs.GlobalExclude) == 0 then
			msg = "Excluded Mounts: ?".." - </gogo exclude [ItemLink]> or </gogo exclude [SpellName]> to add / remove"
			return msg
		else
			local list = ""
			list = list .. GoGo_GetIDName(GoGo_Prefs.GlobalExclude)
			msg = "Excluded Mounts: "..list.." - </gogo exclude [ItemLink]> or </gogo exclude [SpellName]> to add / remove"
			return msg
		end --if
	end, --function
	["updatenotice"] = function()
		if GoGo_Prefs.DisableUpdateNotice then
			return "Update notices from other players disabled - </gogo updatenotice> to toggle"
		else
			return "Update notices from other players enabled - </gogo updatenotice> to toggle"
		end --if
	end, --function
	["mountnotice"] = function()
		if GoGo_Prefs.DisableMountNotice then
			return "Update notices about unknown mounts are disabled - </gogo mountnotice> to toggle"
		else
			return "Update notices about unknown mounts are enabled - </gogo mountnotice> to toggle"
		end --if
	end, --function
	["druidclickform"] = function()
		if GoGo_Prefs.DruidClickForm then
			return "Single click form changes enabled - </gogo druidclickform> to toggle"
		else
			return "Single click form changes disabled - </gogo druidclickform> to toggle"
		end --if
	end, --function
	["druidflightform"] = function()
		if GoGo_Prefs.DruidFlightForm then
			return "Flight Forms always used over flying mounts - </gogo druidflightform> to toggle"
		else
			return "Flighing mounts selected, flight forms if moving - </gogo druidflightform> to toggle"
		end --if
	end, --function
	["UnknownMount"] = function() return GoGo_Variables.Localize.String.UnknownMountFound end, --function
	["optiongui"] = function() return "To open the GUI options window - </gogo options>" end, --function
}

---------
function GoGo_DebugAddLine(LogLine)
---------
	if not GoGo_Variables.DebugLine then GoGo_Variables.DebugLine = 1 end --if
	GoGo_DebugLog[GoGo_Variables.DebugLine] = LogLine
	GoGo_Msg(LogLine)
	GoGo_Variables.DebugLine = GoGo_Variables.DebugLine + 1
	
end --function

---------
function GoGo_Panel_OnLoad(GoGo_Panel)
---------
--	local GoGo_Panel = CreateFrame("FRAME", nil);
--	GoGo_Panel:SetScript("OnShow",function() GoGo_Panel_UpdateViews(); end);
	GoGo_Panel.name = "GoGoMount"
	GoGo_Panel.okay = function (self) GoGo_Panel_Okay("MAIN"); end;
	GoGo_Panel.default = function (self) GoGo_Settings_Default("ALL"); GoGo_Panel_UpdateViews(); end;
	InterfaceOptions_AddCategory(GoGo_Panel)
	
end --function

---------
function GoGo_Panel_Options()
---------
	GoGo_Panel_AutoDismount = CreateFrame("CheckButton", "GoGo_Panel_AutoDismount", GoGo_Panel, "OptionsCheckButtonTemplate")
	GoGo_Panel_AutoDismount:SetPoint("TOPLEFT", 16, -16)
	GoGo_Panel_AutoDismountText:SetText(GoGo_Variables.Localize.String.EnableAutoDismount)
	GoGo_Panel_AutoDismount:SetScript("OnClick",
		function(self)
			GoGo_Panel_Okay("MAIN")
		end --function
	)

	GoGo_Panel_GlobalPrefMount = CreateFrame("CheckButton", "GoGo_Panel_GlobalPrefMount", GoGo_Panel, "OptionsCheckButtonTemplate")
	GoGo_Panel_GlobalPrefMount:SetPoint("TOPLEFT", "GoGo_Panel_AutoDismount", "BOTTOMLEFT", 0, -4)
	GoGo_Panel_GlobalPrefMountText:SetText("Preferred mount changes apply to global setting")
	GoGo_Panel_GlobalPrefMount:SetScript("OnClick",
		function(self)
			GoGo_Panel_Okay("MAIN")
		end --function
	)

	GoGo_Panel_DisableUpdateNotice = CreateFrame("CheckButton", "GoGo_Panel_DisableUpdateNotice", GoGo_Panel, "OptionsCheckButtonTemplate")
	GoGo_Panel_DisableUpdateNotice:SetPoint("TOPLEFT", "GoGo_Panel_GlobalPrefMount", "BOTTOMLEFT", 0, -12)
	GoGo_Panel_DisableUpdateNoticeText:SetText(GoGo_Variables.Localize.String.DisableUpdateNotices)
	GoGo_Panel_DisableUpdateNotice:SetScript("OnClick",
		function(self)
			GoGo_Panel_Okay("MAIN")
		end --function
	)

	GoGo_Panel_DisableMountNotice = CreateFrame("CheckButton", "GoGo_Panel_DisableMountNotice", GoGo_Panel, "OptionsCheckButtonTemplate")
	GoGo_Panel_DisableMountNotice:SetPoint("TOPLEFT", "GoGo_Panel_DisableUpdateNotice", "BOTTOMLEFT", 0, -4)
	GoGo_Panel_DisableMountNoticeText:SetText(GoGo_Variables.Localize.String.DisableUnknownMountNotices)
	GoGo_Panel_DisableMountNotice:SetScript("OnClick",
		function(self)
			GoGo_Panel_Okay("MAIN")
		end --function
	)
end --function

---------
function GoGo_Druid_Panel()
---------
	GoGo_Druid_Panel = CreateFrame("Frame", nil, UIParent)
	GoGo_Druid_Panel.name = GoGo_Variables.Localize.String.DruidOptions
	GoGo_Druid_Panel.parent = "GoGoMount"
	GoGo_Druid_Panel.okay = function (self) GoGo_Panel_Okay("DRUID"); end;
	GoGo_Druid_Panel.default = function (self) GoGo_Settings_Default("DRUID"); GoGo_Panel_UpdateViews("DRUID"); end;  -- use clear command with default button
	InterfaceOptions_AddCategory(GoGo_Druid_Panel)

	GoGo_Druid_Panel_ClickForm = CreateFrame("CheckButton", "GoGo_Druid_Panel_ClickForm", GoGo_Druid_Panel, "OptionsCheckButtonTemplate")
	GoGo_Druid_Panel_ClickForm:SetPoint("TOPLEFT", 16, -16)
	GoGo_Druid_Panel_ClickFormText:SetText(GoGo_Variables.Localize.String.DruidSingleClick)
	GoGo_Druid_Panel_ClickForm:SetScript("OnClick",
		function(self)
			GoGo_Panel_Okay("DRUID")
		end --function
	)

	GoGo_Druid_Panel_FlightForm = CreateFrame("CheckButton", "GoGo_Druid_Panel_FlightForm", GoGo_Druid_Panel, "OptionsCheckButtonTemplate")
	GoGo_Druid_Panel_FlightForm:SetPoint("TOPLEFT", "GoGo_Druid_Panel_ClickForm", "BOTTOMLEFT", 0, -4)
	GoGo_Druid_Panel_FlightFormText:SetText(GoGo_Variables.Localize.String.DruidFlightPreference)
	GoGo_Druid_Panel_FlightForm:SetScript("OnClick",
		function(self)
			if self:GetChecked() then
				GoGo_Druid_Panel_NoShapeInRandom:SetChecked(0)
			end  --if
			GoGo_Panel_Okay("DRUID")
		end --function
	)
	
	GoGo_Druid_Panel_NoShapeInRandom = CreateFrame("CheckButton", "GoGo_Druid_Panel_NoShapeInRandom", GoGo_Druid_Panel, "OptionsCheckButtonTemplate")
	GoGo_Druid_Panel_NoShapeInRandom:SetPoint("TOPLEFT", "GoGo_Druid_Panel_FlightForm", "BOTTOMLEFT", 0, -4)
	GoGo_Druid_Panel_NoShapeInRandomText:SetText(GoGo_Variables.Localize.String.NoShapeInRandom)
	GoGo_Druid_Panel_NoShapeInRandom:SetScript("OnClick",
		function(self)
			if self:GetChecked() then
				GoGo_Druid_Panel_FlightForm:SetChecked(0)
			end --if
			GoGo_Panel_Okay("DRUID")
		end --function
	)
end --function

---------
function GoGo_Hunter_Panel()
---------
	GoGo_Hunter_Panel = CreateFrame("Frame", nil, UIParent)
	GoGo_Hunter_Panel.name = GoGo_Variables.Localize.String.HunterOptions
	GoGo_Hunter_Panel.parent = "GoGoMount"
	GoGo_Hunter_Panel.okay = function (self) GoGo_Panel_Okay("HUNTER"); end;
	GoGo_Hunter_Panel.default = function (self) GoGo_Settings_Default("HUNTER"); GoGo_Panel_UpdateViews("HUNTER"); end;  -- use clear command with default button
	InterfaceOptions_AddCategory(GoGo_Hunter_Panel)

	GoGo_Hunter_Panel_AspectOfPack = CreateFrame("CheckButton", "GoGo_Hunter_Panel_AspectOfPack", GoGo_Hunter_Panel, "OptionsCheckButtonTemplate")
	GoGo_Hunter_Panel_AspectOfPack:SetPoint("TOPLEFT", 16, -16)
	GoGo_Hunter_Panel_AspectOfPackText:SetText(GoGo_Variables.Localize.String.UseAspectOfThePackInstead)
	GoGo_Hunter_Panel_AspectOfPack:SetScript("OnClick",
		function(self)
			GoGo_Panel_Okay("HUNTER")
		end --function
	)
	
end --function

---------
function GoGo_Panel_UpdateViews(Class)
---------
	if Class == "DRUID" then
		GoGo_Druid_Panel_ClickForm:SetChecked(GoGo_Prefs.DruidClickForm)
		GoGo_Druid_Panel_FlightForm:SetChecked(GoGo_Prefs.DruidFlightForm)
		GoGo_Druid_Panel_NoShapeInRandom:SetChecked(GoGo_Prefs.DruidFormNotRandomize)
	elseif Class == "HUNTER" then
		GoGo_Hunter_Panel_AspectOfPack:SetChecked(GoGo_Prefs.AspectPack)
	else
		GoGo_Panel_AutoDismount:SetChecked(GoGo_Prefs.autodismount)
		GoGo_Panel_DisableUpdateNotice:SetChecked(GoGo_Prefs.DisableUpdateNotice)
		GoGo_Panel_DisableMountNotice:SetChecked(GoGo_Prefs.DisableMountNotice)
		GoGo_Panel_GlobalPrefMount:SetChecked(GoGo_Prefs.GlobalPrefMount)
	end --if
	
	if GoGo_Prefs.autodismount then
		GoGoFrame:RegisterEvent("UI_ERROR_MESSAGE")
	else
		GoGoFrame:UnregisterEvent("UI_ERROR_MESSAGE")
	end --if
end -- function

---------
function GoGo_Panel_Okay(Panel)
---------
	if Panel == "MAIN" then
		GoGo_Prefs.autodismount = GoGo_Panel_AutoDismount:GetChecked()
		GoGo_Prefs.DisableUpdateNotice = GoGo_Panel_DisableUpdateNotice:GetChecked()
		GoGo_Prefs.DisableMountNotice = GoGo_Panel_DisableMountNotice:GetChecked()
		GoGo_Prefs.GlobalPrefMount = GoGo_Panel_GlobalPrefMount:GetChecked()
	elseif Panel == "DRUID" then
		GoGo_Prefs.DruidClickForm = GoGo_Druid_Panel_ClickForm:GetChecked()
		GoGo_Prefs.DruidFlightForm = GoGo_Druid_Panel_FlightForm:GetChecked()
		GoGo_Prefs.DruidFormNotRandomize = GoGo_Druid_Panel_NoShapeInRandom:GetChecked()
	elseif Panel == "HUNTER" then
		GoGo_Prefs.AspectPack = GoGo_Hunter_Panel_AspectOfPack:GetChecked()
	end--if
end --function

---------
function GoGo_Settings_Default(Class)
---------
	if Class == "DRUID" then
		GoGo_Prefs.DruidClickForm = true
		GoGo_Prefs.DruidFlightForm = false
		GoGo_Prefs.DruidFormNotRandomize = false
	elseif Class == "HUNTER" then
		GoGo_Prefs.AspectPack = false
	elseif Class == "ALL" then
		GoGo_Prefs.autodismount = true
		GoGo_Prefs.DisableUpdateNotice = false
		GoGo_Prefs.DisableMountNotice = false
		GoGo_Prefs.GlobalPrefMount = false
	else
		GoGo_Prefs = {}
		GoGo_Prefs.GlobalExclude = {}
		GoGo_Prefs.version = GetAddOnMetadata("GoGoMount", "Version")
		GoGo_Prefs.autodismount = true
		GoGo_Prefs.DisableUpdateNotice = false
		GoGo_Prefs.DisableMountNotice = false
		GoGo_Prefs.DruidClickForm = true
		GoGo_Prefs.DruidFlightForm = false
		GoGo_Prefs.UnknownMounts = {}
		GoGo_Prefs.GlobalPrefMounts = {}
		GoGo_Prefs.GlobalPrefMount = false
		GoGo_Prefs.AspectPack = false
		GoGo_Prefs.DruidFormNotRandomize = false
	end --if
end --function

---------
function GoGo_Settings_SetUpdates()
---------
	GoGo_Prefs.version = GetAddOnMetadata("GoGoMount", "Version")
	if not GoGo_Prefs.autodismount then GoGo_Prefs.autodismount = false end
	if not GoGo_Prefs.DisableUpdateNotice then GoGo_Prefs.DisableUpdateNotice = false end
	if not GoGo_Prefs.DisableMountNotice then GoGo_Prefs.DisableMountNotice = false end
	if not GoGo_Prefs.DruidClickForm then GoGo_Prefs.DruidClickForm = false end
	if not GoGo_Prefs.DruidFlightForm then GoGo_Prefs.DruidFlightForm = false end
	if not GoGo_Prefs.GlobalPrefMount then GoGo_Prefs.GlobalPrefMount = false end
	if not GoGo_Prefs.AspectPack then GoGo_Prefs.AspectPack = false end
	if not GoGo_Prefs.DruidFormNotRandomize then GoGo_Prefs.DruidFormNotRandomize = false end
	GoGo_Prefs.UnknownMounts = {}
	if not GoGo_Prefs.GlobalExclude then
		GoGo_Prefs.GlobalExclude = {}
	end --if
	
end --function

---------
function GoGo_DebugCollectInformation()
---------
	GoGo_DebugAddLine("Information: GoGoMount Version " .. GetAddOnMetadata("GoGoMount", "Version"))
	if GetLocale() == "enUS" then
		GoGo_DebugAddLine("Information: Client locale is enUS")
	elseif GetLocale() == "enGB" then
		GoGo_DebugAddLine("Information: Client locale is enGB")
	elseif GetLocale() == "frFR" then
		GoGo_DebugAddLine("Information: Client locale is frFR")
	elseif GetLocale() == "deDE" then
		GoGo_DebugAddLine("Information: Client locale is deDE")
	elseif GetLocale() == "esES" then
		GoGo_DebugAddLine("Information: Client locale is esES")
	elseif GetLocale() == "esMX" then
		GoGo_DebugAddLine("Information: Client locale is esMX")
	elseif GetLocale() == "koKR" then
		GoGo_DebugAddLine("Information: Client locale is koKR")
	elseif GetLocale() == "zhTW" then
		GoGo_DebugAddLine("Information: Client locale is zhTW")
	elseif GetLocale() == "zhCN" then
		GoGo_DebugAddLine("Information: Client locale is zhCN")
	end --if
	GoGo_DebugAddLine("Information: Location = " .. GetRealZoneText() .. " - " .. GetZoneText() .. " - " ..GetSubZoneText() .. " - " .. GetMinimapZoneText())
	GoGo_DebugAddLine("Information: Current unit speed is " .. GetUnitSpeed("player"))
	local level = UnitLevel("player")
	GoGo_DebugAddLine("Information: We are level " .. level)
	GoGo_DebugAddLine("Information: We are a " .. GoGo_Variables.Player.Race .. " " .. GoGo_Variables.Player.Class)
	if GoGo_CanFly() then
		GoGo_DebugAddLine("Information: We can fly here as per GoGo_CanFly()")
	else
		GoGo_DebugAddLine("Information: We can not fly here as per GoGo_CanFly()")
	end --if
	if IsOutdoors() then
		GoGo_DebugAddLine("Information: We are outdoors as per IsOutdoors()")
	else
		GoGo_DebugAddLine("Information: We are not outdoors as per IsOutdoors()")
	end --if
	if IsIndoors() then
		GoGo_DebugAddLine("Information: We are indoors as per IsIndoors()")
	else
		GoGo_DebugAddLine("Information: We are not indoors as per IsIndoors()")
	end --if
	if IsInInstance() then
		GoGo_DebugAddLine("Information: We are in an instance as per IsInInstance()")
	else
		GoGo_DebugAddLine("Information: We are not in an instance as per IsInInstance()")
	end --if
	if IsFlyableArea() then
		GoGo_DebugAddLine("Information: We can fly here as per IsFlyableArea()")
	else
		GoGo_DebugAddLine("Information: We can not fly here as per IsFlyableArea()")
	end --if
	if IsFlying() then
		GoGo_DebugAddLine("Information: We are flying as per IsFlying()")
	else
		GoGo_DebugAddLine("Information: We are not flying as per IsFlying()")
	end --if
	if IsSwimming() then
		GoGo_DebugAddLine("Information: We are swimming as per IsSwimming()")
	else
		GoGo_DebugAddLine("Information: We are not swimming as per IsSwimming()")
	end --if
	if IsFalling() then
		GoGo_DebugAddLine("Information: We are falling as per IsFalling()")
	else
		GoGo_DebugAddLine("Information: We are not falling as per IsFalling()")
	end --if
	if GoGo_IsMoving() then
		GoGo_DebugAddLine("Information: We are moving as per GoGo_IsMoving()")
	else
		GoGo_DebugAddLine("Information: We are not moving as per GoGo_IsMoving()")
	end --if
	local posX, posY = GetPlayerMapPosition("Player")
	GoGo_DebugAddLine("Information: Player location: X = ".. posX .. ", Y = " .. posY)
	
	local buffs, i = { }, 1
	local buff = UnitBuff("player", i)
	while buff do
		buffs[#buffs + 1] = buff
		i = i + 1
		buff = UnitBuff("player", i)
	end --while
	if #buffs < 1 then
		buffs = "We are unbuffed"
	else
		buffs[1] = "We are buffed with: "..buffs[1]
		buffs = table.concat(buffs, ", ")
	end --if
	GoGo_DebugAddLine("Information: " .. buffs)
	GoGo_DebugAddLine("Information: Azeroth Zones:  " .. GoGo_Variables.AzerothZones)
	GoGo_DebugAddLine("Information: Outland Zones:  " .. GoGo_Variables.OutlandZones)
	GoGo_DebugAddLine("Information: Northrend Zones:  " .. GoGo_Variables.NorthrendZones)
	GoGo_DebugAddLine("Information: Maelstrom Zones:  " .. GoGo_Variables.MaelstromZones)
	GoGo_DebugAddLine("Information: Mount List:")
	GoGo_BuildMountSpellList()
	GoGo_BuildMountItemList()
	GoGo_BuildMountList()
	GoGo_DebugAddLine("Information: End of information.")

end --function
