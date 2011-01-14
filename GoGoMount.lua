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
function GoGo_OnEvent(self, event, ...)
---------
	local arg1, arg2, arg3, arg4 = ...
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
		GoGo_Variables.VerMajor, GoGo_Variables.VerMinor, GoGo_Variables.VerBuild = strsplit(".", GetAddOnMetadata("GoGoMount", "Version"))
		GoGo_Variables.VerMajor, GoGo_Variables.VerMinor, GoGo_Variables.VerBuild = tonumber(GoGo_Variables.VerMajor), tonumber(GoGo_Variables.VerMinor), tonumber(GoGo_Variables.VerBuild)
		GoGo_Variables.TestVersion = true
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
		GoGo_UpdateZonePrefs()
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
		GoGo_Variables.ExpansionAccount = GetAccountExpansionLevel()
		GoGo_Variables.ExpansionGame =  GetExpansionLevel()
	elseif (event == "CHAT_MSG_ADDON") and (arg1 == "GoGoMountVER") and not GoGo_Prefs.DisableUpdateNotice then
		local major, minor, build = strsplit(".", arg2)
		local major, minor, build = tonumber(major), tonumber(minor), tonumber(build)
		
		if not GoGo_Variables.UpdateShown then
			local GoGo_ShowUpdate = false
			if major > GoGo_Variables.VerMajor then
				GoGo_ShowUpdate = true
			elseif (major == GoGo_Variables.VerMajor) and (minor > GoGo_Variables.VerMinor) then
				GoGo_ShowUpdate = true
			elseif (major == GoGo_Variables.VerMajor) and (minor == GoGo_Variables.VerMinor) and (build > GoGo_Variables.VerBuild) then
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
			GoGo_GlobalExcludeModify(tonumber(itemid))
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
			if GoGo_Variables.Debug then
				GoGo_DebugAddLine("GoGo_PreClick: Is in guild - sending GoGoMount version information to guild addon channel.")
			end --if
			SendAddonMessage("GoGoMountVER", GetAddOnMetadata("GoGoMount", "Version"), "GUILD")
		else
			if GoGo_Variables.Debug then
				GoGo_DebugAddLine("GoGo_PreClick: Is not in guild - not sending GoGoMount version information to guild addon channel.")
			end --if
		end --if
		if UnitInRaid("player") and not UnitInBattleground("player") then
			if GoGo_Variables.Debug then
				GoGo_DebugAddLine("GoGo_PreClick: Is in raid - sending GoGoMount version information to raid addon channel.")
			end --if
			SendAddonMessage("GoGoMountVER", GetAddOnMetadata("GoGoMount", "Version"), "RAID")
		end --if
		if UnitInParty("player") and not UnitInBattleground("player") then
			if GoGo_Variables.Debug then
				GoGo_DebugAddLine("GoGo_PreClick: Is in party - sending GoGoMount version information to party addon channel.")
			end --if
			SendAddonMessage("GoGoMountVER", GetAddOnMetadata("GoGoMount", "Version"), "PARTY")
		end --if
		if UnitInBattleground("player") then
			if GoGo_Variables.Debug then
				GoGo_DebugAddLine("GoGo_PreClick: Is in battle ground - sending GoGoMount version information to battle ground addon channel.")
			end --if
			SendAddonMessage("GoGoMountVER", GetAddOnMetadata("GoGoMount", "Version"), "BATTLEGROUND")
		end --if
	end --if
	GoGo_Variables.Debug = false
end --function

---------
function GoGo_GetMount()
---------
	local selectedmount = GoGo_ChooseMount()	-- find a mount to use
	selectedmount = GoGo_RemoveBuffs(selectedmount)	-- remove buffs that could prevent us from mounting
	return selectedmount	-- returning the mount or macro to the button
end --function

---------
function GoGo_ChooseMount()
---------
	GoGo_Variables.CanRide = true  -- resetting canride flag
	GoGo_Variables.NoFlying = false -- resetting flag to prevent flying

	local mounts = {}
	GoGo_Variables.FilteredMounts = {}
	GoGo_GetMountDB()
	
	GoGo_Variables.Player.Zone = GetRealZoneText()
	GoGo_Variables.Player.SubZone = GetSubZoneText()
	GoGo_Variables.Player.MiniSubZone = GetMinimapZoneText()
	GoGo_Variables.Player.ZoneID = GetCurrentMapAreaID()
	GoGo_Variables.EngineeringLevel = GoGo_GetProfSkillLevel(GoGo_Variables.Localize.Skill.Engineering)
	GoGo_Variables.TailoringLevel = GoGo_GetProfSkillLevel(GoGo_Variables.Localize.Skill.Tailoring)
	GoGo_Variables.RidingLevel = GoGo_GetRidingSkillLevel() or 0
	GoGo_Variables.Player.Level = UnitLevel("player")

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
		if GoGo_Prefs.Zones[GoGo_Variables.Player.Zone] then
			GoGo_Variables.FilteredMounts = GoGo_Prefs.Zones[GoGo_Variables.Player.Zone] or {}
--			GoGo_Variables.UnknownMountMsgShown = true
		end --if
	end --if
	if GoGo_Variables.Debug then
		GoGo_DebugAddLine("GoGo_ChooseMount: Checked for zone favorites.")
	end --if

	if (table.getn(mounts) == 0) and (table.getn(GoGo_Variables.FilteredMounts) == 0) then
		if GoGo_Prefs.GlobalPrefMounts then
			GoGo_Variables.FilteredMounts = GoGo_Prefs.GlobalPrefMounts or {}
--			GoGo_Variables.UnknownMountMsgShown = true
		end --if
		if GoGo_Variables.Debug then
			GoGo_DebugAddLine("GoGo_ChooseMount: Checked for global favorites.")
		end --if
	end --if

	if (table.getn(mounts) == 0) and (table.getn(GoGo_Variables.FilteredMounts) == 0) then
		if GoGo_Variables.Debug then
			GoGo_DebugAddLine("GoGo_ChooseMount: Checking for spell and item mounts.")
		end --if
		-- Not updating bag items on bag changes right now so scan and update list
		GoGo_BuildMountSpellList()
		GoGo_BuildMountItemList()
		GoGo_BuildMountList()
		if not GoGo_Prefs.DisableMountNotice and not GoGo_Variables.UnknownMountMsgShown then
			GoGo_CheckForUnknownMounts()
		end --if
		GoGo_Variables.FilteredMounts = GoGo_Variables.MountList or {}
	end --if

	if GoGo_Variables.Debug then
		GoGo_DebugAddLine("GoGo_ChooseMount: ** Searched all areas for mounts and found " .. (table.getn(GoGo_Variables.FilteredMounts) or 0) .. " mounts.")
	end --if
		
	GoGo_ZoneCheck()  -- Checking to see what we can and can not do in zones
	GoGo_UpdateMountData()  -- update mount information with changes from talents, glyphs, etc.

	if GoGo_Variables.EngineeringLevel <= 299 then
		GoGo_Variables.FilteredMounts = GoGo_FilterMountsOut(GoGo_Variables.FilteredMounts, 45)
		GoGo_Variables.FilteredMounts = GoGo_FilterMountsOut(GoGo_Variables.FilteredMounts, 46)
	elseif GoGo_Variables.EngineeringLevel >= 300 and GoGo_Variables.EngineeringLevel <= 374 then
		GoGo_Variables.FilteredMounts = GoGo_FilterMountsOut(GoGo_Variables.FilteredMounts, 46)
	elseif GoGo_Variables.EngineeringLevel >= 375 then
		-- filter nothing
	else
		GoGo_Variables.FilteredMounts = GoGo_FilterMountsOut(GoGo_Variables.FilteredMounts, 45)
		GoGo_Variables.FilteredMounts = GoGo_FilterMountsOut(GoGo_Variables.FilteredMounts, 46)
	end --if
	if GoGo_Variables.TailoringLevel <= 299 then
		GoGo_Variables.FilteredMounts = GoGo_FilterMountsOut(GoGo_Variables.FilteredMounts, 49)
		GoGo_Variables.FilteredMounts = GoGo_FilterMountsOut(GoGo_Variables.FilteredMounts, 48)
		GoGo_Variables.FilteredMounts = GoGo_FilterMountsOut(GoGo_Variables.FilteredMounts, 47)
	elseif GoGo_Variables.TailoringLevel >= 300 and GoGo_Variables.TailoringLevel <= 424 then
		GoGo_Variables.FilteredMounts = GoGo_FilterMountsOut(GoGo_Variables.FilteredMounts, 49)
		GoGo_Variables.FilteredMounts = GoGo_FilterMountsOut(GoGo_Variables.FilteredMounts, 47)
	elseif GoGo_Variables.TailoringLevel >= 425 and GoGo_Variables.TailoringLevel <= 449 then
		GoGo_Variables.FilteredMounts = GoGo_FilterMountsOut(GoGo_Variables.FilteredMounts, 47)
	elseif GoGo_Variables.TailoringLevel >= 450 then
		-- filter nothing
	else
		GoGo_Variables.FilteredMounts = GoGo_FilterMountsOut(GoGo_Variables.FilteredMounts, 49)
		GoGo_Variables.FilteredMounts = GoGo_FilterMountsOut(GoGo_Variables.FilteredMounts, 48)
		GoGo_Variables.FilteredMounts = GoGo_FilterMountsOut(GoGo_Variables.FilteredMounts, 47)
	end --if
	if GoGo_Variables.RidingLevel <= 224 then
		GoGo_Variables.FilteredMounts = GoGo_FilterMountsOut(GoGo_Variables.FilteredMounts, 36)
		GoGo_Variables.FilteredMounts = GoGo_FilterMountsOut(GoGo_Variables.FilteredMounts, 35)
	elseif GoGo_Variables.RidingLevel >= 225 and GoGo_Variables.RidingLevel <= 299 then
		GoGo_Variables.FilteredMounts = GoGo_FilterMountsOut(GoGo_Variables.FilteredMounts, 35)
	elseif GoGo_Variables.RidingLevel >= 300 then
		-- filter nothing
	else
		GoGo_Variables.FilteredMounts = GoGo_FilterMountsOut(GoGo_Variables.FilteredMounts, 36)
		GoGo_Variables.FilteredMounts = GoGo_FilterMountsOut(GoGo_Variables.FilteredMounts, 35)
	end --if

	if GoGo_Variables.RidingLevel <= 149 then
		GoGo_TempMounts = GoGo_FilterMountsOut(GoGo_TempMounts, 29)
	end --if

	if GoGo_Variables.RidingLevel <= 74 then
		GoGo_Variables.FilteredMounts = GoGo_FilterMountsOut(GoGo_Variables.FilteredMounts, 37)
		GoGo_Variables.FilteredMounts = GoGo_FilterMountsOut(GoGo_Variables.FilteredMounts, 38)
	elseif GoGo_Variables.RidingLevel >= 75 and GoGo_Variables.RidingLevel <= 149 then
		GoGo_Variables.FilteredMounts = GoGo_FilterMountsOut(GoGo_Variables.FilteredMounts, 37)
	end --if

	if IsSwimming() then
		GoGo_CheckSwimSurface()
	else
		GoGo_Variables.FilteredMounts = GoGo_FilterMountsOut(GoGo_Variables.FilteredMounts, 53)
	end --if

	if (GoGo_Variables.Player.Level < 60) then
		if GoGo_Variables.Debug then
			GoGo_DebugAddLine("GoGo_ChooseMount: Disabling flying - under level 60")
		end --if
		GoGo_Variables.NoFlying = true
	end --if

	if GoGo_Variables.ExpansionAccount == 3 then  -- only exists for 4.x with Cataclysm expansion
		if UnitBuff("player", GetSpellInfo(GoGo_Variables.Localize.SeaLegs)) then
			if GoGo_Variables.Debug then
				GoGo_DebugAddLine("GoGo_ChooseMount: Sea Legs buff found - not removing Vashj'ir mount.")
			end --if
			-- do nothing, we can use the abyssal seahorse
			if IsSwimming() then
				GoGo_Variables.NoFlying = true  -- block flying since we're swimming in vashir and most likely have water breathing buff
			end --if
		else
			if GoGo_Variables.Debug then
				GoGo_DebugAddLine("GoGo_ChooseMount: Sea Legs buff not found - removing Vashj'ir mount.")
			end --if
			GoGo_Variables.FilteredMounts = GoGo_FilterMountsOut(GoGo_Variables.FilteredMounts, 401)
		end --if
	end --if

	if (GoGo_Variables.Player.Class == "DRUID" and GoGo_Prefs.DruidFormNotRandomize and not GoGo_IsMoving() and not IsFalling()) then
		GoGo_Variables.FilteredMounts = GoGo_FilterMountsOut(GoGo_Variables.FilteredMounts, 9998)
	end --if
	
	if GoGo_Variables.SelectPassengerMount then
		if GoGo_Variables.Debug then
			GoGo_DebugAddLine("GoGo_ChooseMount: Filtering out all mounts except passenger mounts since passenger mount only was requested.")
		end --if
		GoGo_Variables.FilteredMounts = GoGo_FilterMountsIn(GoGo_Variables.FilteredMounts, 2) or {}
	end --if

	if GoGo_Variables.ZoneExclude.NorthrendLoanedMounts then
		GoGo_Variables.FilteredMounts = GoGo_FilterMountsOut(GoGo_Variables.FilteredMounts, 52) or {}
		if GoGo_Variables.Debug then
			GoGo_DebugAddLine("GoGo_ChooseMount: Eliminated loaned mounts - " .. (table.getn(GoGo_Variables.FilteredMounts) or 0) .. " mounts left.")
		end --if
	end --if

	if GoGo_Variables.ZoneExclude.TheOculus then
		GoGo_Variables.FilteredMounts = GoGo_FilterMountsOut(GoGo_Variables.FilteredMounts, 54)
		if GoGo_Variables.Debug then
			GoGo_DebugAddLine("GoGo_ChooseMount: Eliminated Oculus mounts - " .. (table.getn(GoGo_Variables.FilteredMounts) or 0) .. " mounts left.")
		end --if
	end --if
	
	if GoGo_Variables.ZoneExclude.AQ40 then
		GoGo_Variables.FilteredMounts = GoGo_FilterMountsOut(GoGo_Variables.FilteredMounts, 201) or {}
		if GoGo_Variables.Debug then
			GoGo_DebugAddLine("GoGo_ChooseMount: Eliminated AQ40 mounts - " .. (table.getn(GoGo_Variables.FilteredMounts) or 0) .. " mounts left.")
		end --if
	end --if

	if GoGo_Variables.ZoneExclude.ThousandNeedles then
		GoGo_Variables.FilteredMounts = GoGo_FilterMountsOut(GoGo_Variables.FilteredMounts, 200) or {}
		if GoGo_Variables.Debug then
			GoGo_DebugAddLine("GoGo_ChooseMount: Eliminated Thousand Needles boat - " .. (table.getn(GoGo_Variables.FilteredMounts) or 0) .. " mounts left.")
		end --if
	end --if

	if not GoGo_Variables.SwimSurface then
		GoGo_Variables.FilteredMounts = GoGo_FilterMountsOut(GoGo_Variables.FilteredMounts, 55) or {}
		if GoGo_Variables.Debug then
			GoGo_DebugAddLine("GoGo_ChooseMount: Eliminated mounts requiring water surface - " .. (table.getn(GoGo_Variables.FilteredMounts) or 0) .. " mounts left.")
		end --if
	end --if

	if IsFalling() then  -- we're falling.. save us  (only grab instant cast spells)
		GoGo_Variables.FilteredMounts = GoGo_GetInstantMounts(GoGo_Variables.FilteredMounts) or {}
		if GoGo_Variables.Debug then
			GoGo_DebugAddLine("GoGo_ChooseMount: Eliminated all mounts except instant casts - " .. (table.getn(GoGo_Variables.FilteredMounts) or 0) .. " mounts left.")
		end --if
	end --if

	if GoGo_Variables.ZoneExclude.RestrictedIndoorMounts then  -- only select what we can use in here..
		GoGo_Variables.FilteredMounts = GoGo_GetIndoorMounts(GoGo_Variables.FilteredMounts) or {}
		if GoGo_Variables.Debug then
			GoGo_DebugAddLine("GoGo_ChooseMount: Eliminated all mounts except indoor mounts - " .. (table.getn(GoGo_Variables.FilteredMounts) or 0) .. " mounts left.")
		end --if
	end --if

	if GoGo_IsMoving() then
		GoGo_Variables.FilteredMounts = GoGo_GetInstantMounts(GoGo_Variables.FilteredMounts) or {}
		if GoGo_Variables.Debug then
			GoGo_DebugAddLine("GoGo_ChooseMount: Eliminated all mounts except instant casts - " .. (table.getn(GoGo_Variables.FilteredMounts) or 0) .. " mounts left.")
		end --if
	end --if

	GoGo_BuildExcludeList()
	GoGo_Variables.FilteredMounts = GoGo_FilterMountsOut(GoGo_Variables.FilteredMounts, 9999) or {}
	if GoGo_Variables.Debug then
		GoGo_DebugAddLine("GoGo_ChooseMount: Eliminated excluded mounts - " .. (table.getn(GoGo_Variables.FilteredMounts) or 0) .. " mounts left.")
	end --if
	
	if GoGo_Variables.ZoneExclude.UseMountGroup then
		GoGo_Variables.FilteredMounts = GoGo_FilterMountsIn(GoGo_Variables.FilteredMounts, GoGo_Variables.ZoneExclude.UseMountGroup) or {}
		if GoGo_Variables.Debug then
			GoGo_DebugAddLine("GoGo_ChooseMount: Selected specific group of mounts - " .. GoGo_Variables.ZoneExclude.UseMountGroup .. " - " .. (table.getn(GoGo_Variables.FilteredMounts) or 0) .. " mounts left.")
		end --if
	end --if
	
	if GoGo_Variables.ZoneExclude.CanFly and not GoGo_Variables.SkipFlyingMount and not GoGo_Variables.NoFlying then
		GoGo_Variables.CanFly = true
	else
		GoGo_Variables.CanFly = false
	end --if 
	
	if GoGo_Variables.Debug then
		GoGo_DebugAddLine("GoGo_ChooseMount: Eliminated mounts we can't use; " .. (table.getn(GoGo_Variables.FilteredMounts) or 0) .. " mounts left.")
	end --if

	if IsSwimming() and not GoGo_Variables.CanFly then  -- find a mount to use in water
		if GoGo_Variables.Debug then
			GoGo_DebugAddLine("GoGo_ChooseMount: Swimming and can't fly.")
		end --if
		if not IsIndoors() then
			mounts = GoGo_GetBestWaterMounts(GoGo_Variables.FilteredMounts) or {}
		else  -- we are indoors
			if (table.getn(mounts) == 0) and (GoGo_Variables.Player.Class == "DRUID") and GoGo_InBook(GoGo_Variables.Localize.AquaForm) then
				return GoGo_InBook(GoGo_Variables.Localize.AquaForm)
			end --if
		end --if
	elseif IsSwimming() and GoGo_Variables.CanFly then
		if GoGo_Variables.Debug then
			GoGo_DebugAddLine("GoGo_ChooseMount: Swimming but can fly.")
		end --if
		mounts = GoGo_GetBestAirMounts(GoGo_Variables.FilteredMounts) or {}
		if table.getn(mounts) == 0 then	
			mounts = GoGo_GetBestWaterMounts(GoGo_Variables.FilteredMounts) or {}
		end --if
	end --if

	GoGo_Variables.FilteredMounts = GoGo_FilterMountsOut(GoGo_Variables.FilteredMounts, 53)

	if (table.getn(mounts) == 0) and GoGo_Variables.CanFly then
		if GoGo_Variables.Debug then
			GoGo_DebugAddLine("GoGo_ChooseMount: Looking for flying mounts since we past flight checks.")
		end --if
		mounts = GoGo_GetBestAirMounts(GoGo_Variables.FilteredMounts)
	else
		if GoGo_Variables.Debug then
			GoGo_DebugAddLine("GoGo_ChooseMount: Not looking for flying mounts since we didn't past flight checks (or found a better mount to use).")
		end --if
	end --if
	
	if (table.getn(GoGo_Variables.FilteredMounts) >= 1) then
		GoGo_Variables.FilteredMounts = GoGo_FilterMountsOut(GoGo_Variables.FilteredMounts, "FlightOnly")
		if GoGo_Variables.Debug then
			GoGo_DebugAddLine("GoGo_ChooseMount: Eliminated mounts that require skill 225 or 300 to use; " .. (table.getn(GoGo_Variables.FilteredMounts) or 0) .. " mounts left.")
		end --if
	end --if

	-- Set the oculus mounts as the only mounts available if we're in the oculus, not skiping flying and have them in inventory
	if (table.getn(mounts) == 0) and (table.getn(GoGo_Variables.FilteredMounts) > 0) and not GoGo_Variables.ZoneExclude.TheOculus and not GoGo_Variables.SkipFlyingMount then  -- skip flying is here because we already know we can't normally fly here
		mounts = GoGo_FilterMountsIn(GoGo_Variables.FilteredMounts, 54) or {}
		if (table.getn(mounts) > 0) then
			if GoGo_Variables.Debug then
				GoGo_DebugAddLine("GoGo_ChooseMount: In the Oculus, Oculus only mount found, using.")
			end --if
		else
			if GoGo_Variables.Debug then
				GoGo_DebugAddLine("GoGo_ChooseMount: In the Oculus, no oculus mount found in inventory.")
			end --if
		end --if
	end --if

	-- Select ground mounts
	if (table.getn(mounts) == 0) and GoGo_Variables.CanRide then
		if GoGo_Variables.Debug then
			GoGo_DebugAddLine("GoGo_ChooseMount: Looking for ground mounts since we can't fly.")
		end --if
		if GoGo_Variables.Debug then
			GoGo_DebugAddLine("GoGo_ChooseMount: Ground mount count = " .. table.getn(GoGo_Variables.FilteredMounts) .. ".")
		end --if
		if (table.getn(mounts) == 0) then
			mounts = GoGo_GetBestGroundMounts(GoGo_Variables.FilteredMounts) or {}
		end --if
		if GoGo_Variables.Debug then
			GoGo_DebugAddLine("GoGo_ChooseMount: Mount count of 100% = " .. table.getn(mounts) .. ".")
		end --if
	end --if
	
	if table.getn(GoGo_Variables.FilteredMounts) >= 1 then
		GoGo_Variables.FilteredMounts = GoGo_FilterMountsOut(GoGo_Variables.FilteredMounts, 37)
		GoGo_Variables.FilteredMounts = GoGo_FilterMountsOut(GoGo_Variables.FilteredMounts, 38)
	end --if
	
	if (table.getn(mounts) >= 1) then
		if GoGo_Variables.Debug then
			for a = 1, table.getn(mounts) do
				GoGo_DebugAddLine("GoGo_ChooseMount: Found mount " .. mounts[a] .. " - included in random pick.")
			end --for
		end --if
		local selected = mounts[math.random(table.getn(mounts))]

		if GoGo_Variables.Debug then
			if 	GoGo_Variables.MountDB[selected][10001] then
				GoGo_DebugAddLine("GoGo_ChooseMount: Under water mount speed should be " .. GoGo_Variables.MountDB[selected][10001])
			end --if
			if 	GoGo_Variables.MountDB[selected][10002] then
				GoGo_DebugAddLine("GoGo_ChooseMount: Ground mount speed should be " .. GoGo_Variables.MountDB[selected][10002])
			end --if
			if 	GoGo_Variables.MountDB[selected][10003] then
				GoGo_DebugAddLine("GoGo_ChooseMount: Air mount speed should be " .. GoGo_Variables.MountDB[selected][10003])
			end --if
			if 	GoGo_Variables.MountDB[selected][10004] then
				GoGo_DebugAddLine("GoGo_ChooseMount: Water surface mount speed should be " .. GoGo_Variables.MountDB[selected][10004])
			end --if
		end --if

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
	if Value == nil then
		local Value = true
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
function GoGo_FilterMountsIn(PlayerMounts, FilterID, Value)
---------
	local GoGo_FilteringMounts = {}
	if not PlayerMounts then PlayerMounts = {} end --if
	if table.getn(PlayerMounts) == 0 then
		return GoGo_FilteringMounts
	end --if
	if Value == nil then
		local Value = true
	end --if
	for a = 1, table.getn(PlayerMounts) do
		local MountID = PlayerMounts[a]
		for DBMountID, DBMountData in pairs(GoGo_Variables.MountDB) do
			if (DBMountID == MountID) and DBMountData[FilterID] then
				if Value and DBMountData[FilterID] == Value then
					table.insert(GoGo_FilteringMounts, MountID)
				elseif Value == nil then
					table.insert(GoGo_FilteringMounts, MountID)
				end --if
			end --if
		end --for
	end --for
	return GoGo_FilteringMounts
end --function

---------
function GoGo_UpdateMountSpeedDB(PlayerMounts, FilterID, SpeedID, Value)  -- eg. mount list, select filter, speed id to set, value to set
---------
	local GoGo_TempMountDB = {}
	local GoGo_TempLoopCounter
	GoGo_TempMountDB = GoGo_FilterMountsIn(PlayerMounts, FilterID)
	if GoGo_Variables.Debug then
		GoGo_DebugAddLine("GoGo_UpdateMountSpeedDB: FilterID = " .. FilterID .. ", SpeedID = " .. SpeedID .. ", Value = " .. Value)
		GoGo_DebugAddLine("GoGo_UpdateMountSpeedDB: Number of mounts to be modified:  " .. (table.getn(GoGo_TempMountDB) or 0))
	end --if
	for GoGo_TempLoopCounter=1, table.getn(GoGo_TempMountDB) do
		GoGo_Variables.MountDB[GoGo_TempMountDB[GoGo_TempLoopCounter]][SpeedID] = Value
	end --for
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
			if IsUsableSpell(GoGo_Variables.MountSpellList[a]) then
				table.insert(GoGo_Variables.MountList, GoGo_Variables.MountSpellList[a])
			end --if
		end --for
	end --if
	
	if (table.getn(GoGo_Variables.MountItemList) > 0) then
		for a=1, table.getn(GoGo_Variables.MountItemList) do
			if IsUsableItem(GoGo_Variables.MountItemList[a]) then
				table.insert(GoGo_Variables.MountList, GoGo_Variables.MountItemList[a])
			end --if
		end --for
	end --if
	GoGo_Variables.MountItemList = {}
	GoGo_Variables.MountSpellList = {}
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
function GoGo_RemoveBuffs(mount)
---------
	if mount == nil then
		return
	end --if
	if not GoGo_Prefs.RemoveBuffs then
		return mount
	end --if
	if GoGo_Variables.Debug then
		GoGo_DebugAddLine("GoGo_RemoveBuffs: Removing buffs preventing mounting.")
	end --if
	local macro = ""
	local spellid = 0
	for spellid = 1, table.getn(GoGo_Variables.DebuffDB) do
		if GoGo_Variables.Debug then
			GoGo_DebugAddLine("GoGo_RemoveBuffs: Checking for " .. GoGo_Variables.DebuffDB[spellid] .. " (" .. GetSpellInfo(GoGo_Variables.DebuffDB[spellid]) .. ")")
		end --if
		if UnitBuff("player", GetSpellInfo(GoGo_Variables.DebuffDB[spellid])) then
			if GoGo_Variables.Debug then
				GoGo_DebugAddLine("GoGo_RemoveBuffs: Found and removing buff " .. GoGo_Variables.DebuffDB[spellid] .. " (" .. GetSpellInfo(GoGo_Variables.DebuffDB[spellid]) .. ")")
			end --if
			macro = macro .. "/cancelaura " .. GetSpellInfo(GoGo_Variables.DebuffDB[spellid]) .. " \n"
		end --if
	end --for
	if macro ~= "" then
		mount = macro .. "/use " .. mount
	end --if
	return mount
end --if

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
function GoGo_AddPrefMount(SpellID)
---------
	if GoGo_Variables.Debug then 
		GoGo_DebugAddLine("GoGo_AddPrefMount: Preference " .. spell)
	end --if

	local GoGo_RemovedFlag = false
	SpellID = tonumber(SpellID)
	if not GoGo_Prefs.GlobalPrefMount then
		GoGo_Variables.Player.Zone = GetRealZoneText()
		if not GoGo_Prefs.Zones[GoGo_Variables.Player.Zone] then GoGo_Prefs.Zones[GoGo_Variables.Player.Zone] = {} end
		if table.getn(GoGo_Prefs.Zones[GoGo_Variables.Player.Zone]) > 0 then
			for GoGo_TempCounter = 1, table.getn(GoGo_Prefs.Zones[GoGo_Variables.Player.Zone]) do
				if (GoGo_Prefs.Zones[GoGo_Variables.Player.Zone][GoGo_TempCounter] == SpellID) then
					local GoGo_TempID = GoGo_Prefs.Zones[GoGo_Variables.Player.Zone][GoGo_TempCounter]
					if GoGo_Variables.Debug then
						GoGo_DebugAddLine("GoGo_AddPrefMount: Removing from exclusion list: " .. SpellID .. " " .. GoGo_GetIDName(SpellID))
					end --if
					table.remove(GoGo_Prefs.Zones[GoGo_Variables.Player.Zone], GoGo_TempCounter)
					GoGo_RemovedFlag = true
					if table.getn(GoGo_Prefs.Zones[GoGo_Variables.Player.Zone]) == 0 then
						GoGo_Prefs.Zones[GoGo_Variables.Player.Zone] = nil
					end --if
				end --if
			end --for
		end --if
		if not GoGo_RemovedFlag then
			table.insert(GoGo_Prefs.Zones[GoGo_Variables.Player.Zone],SpellID)
		end --if
	else
		if not GoGo_Prefs.GlobalPrefMounts then GoGo_Prefs.GlobalPrefMounts = {} end
		if table.getn(GoGo_Prefs.GlobalPrefMounts) > 0 then
			for GoGo_TempCounter = 1, table.getn(GoGo_Prefs.GlobalPrefMounts) do
				if (GoGo_Prefs.GlobalPrefMounts[GoGo_TempCounter] == SpellID) then
					local GoGo_TempID = GoGo_Prefs.GlobalPrefMounts[GoGo_TempCounter]
					if GoGo_Variables.Debug then
						GoGo_DebugAddLine("GoGo_AddPrefMount: Removing from exclusion list: " .. SpellID .. " " .. GoGo_GetIDName(SpellID))
					end --if
					table.remove(GoGo_Prefs.GlobalPrefMounts, GoGo_TempCounter)
					GoGo_RemovedFlag = true
					if table.getn(GoGo_Prefs.GlobalPrefMounts) == 0 then
						GoGo_Prefs.GlobalPrefMounts = nil
					end --if
				end --if
			end --for
		end --if
		if not GoGo_RemovedFlag then
			table.insert(GoGo_Prefs.GlobalPrefMounts,SpellID)
		end --if
	end --if
end --function

---------
function GoGo_UpdateZonePrefs()
---------
	if GoGo_Prefs[GoGo_Variables.Player.Zone] then
		GoGo_Prefs.Zones[GoGo_Variables.Player.Zone] = GoGo_Prefs[GoGo_Variables.Player.Zone]
		GoGo_Prefs[GoGo_Variables.Player.Zone] = nil
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
			if not GoGo_Prefs.DisableMountNotice and not GoGo_Variables.UnknownMountMsgShown then
				GoGo_Variables.UnknownMountMsgShown = true
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
		if string.find(mount, "/use ", 1, true) then
			button:SetAttribute("macrotext", mount)
		else
			button:SetAttribute("macrotext", "/use "..mount)
		end --if
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
function GoGo_ZoneCheck()
--------- 
	--Resetting zone flags (if true then don't use)
	GoGo_Variables.ZoneExclude.NorthrendLoanedMounts = true
	GoGo_Variables.ZoneExclude.TheOculus = true
	GoGo_Variables.ZoneExclude.AQ40 = true
	GoGo_Variables.ZoneExclude.ThousandNeedles = true
	GoGo_Variables.ZoneExclude.CanFly = false
	GoGo_Variables.ZoneExclude.UseMountGroup = nil
	
	if GoGo_Variables.Debug then
		GoGo_DebugAddLine("GoGo_ZoneCheck: Beginning function.")
	end --if

	if (GoGo_InNorthrend()) then
		if not (GoGo_InBook(GoGo_Variables.Localize.ColdWeatherFlying)) then
			if GoGo_Variables.Player.Zone == GoGo_Variables.Localize.Zone.SholazarBasin then
				if GoGo_Variables.Debug then
					GoGo_DebugAddLine("GoGo_ZoneCheck: Not removing loaned mounts since we are in Sholazar Basin.")
				end --if
				GoGo_Variables.ZoneExclude.NorthrendLoanedMounts = false
			elseif GoGo_Variables.Player.Zone == GoGo_Variables.Localize.Zone.TheStormPeaks then
				if GoGo_Variables.Debug then
					GoGo_DebugAddLine("GoGo_ZoneCheck: Not removing loaned mounts since we are in The Storm Peaks.")
				end --if
				GoGo_Variables.ZoneExclude.NorthrendLoanedMounts = false
			elseif GoGo_Variables.Player.Zone == GoGo_Variables.Localize.Zone.Icecrown then
				if GoGo_Variables.Debug then
					GoGo_DebugAddLine("GoGo_ZoneCheck: Not removing loaned mounts since we are in Icecrown.")
				end --if
				GoGo_Variables.ZoneExclude.NorthrendLoanedMounts = false
			end --if
			if GoGo_Variables.ZoneExclude.NorthrendLoanedMounts then
				GoGo_Variables.ZoneExclude.CanFly = false
			end --if
		elseif GoGo_InBook(GoGo_Variables.Localize.ColdWeatherFlying) then
			if GoGo_Variables.Player.Zone == GoGo_Variables.Localize.Zone.Wintergrasp then
				if GetWintergraspWaitTime() then
					if GoGo_Variables.Debug then
						GoGo_DebugAddLine("GoGo_ZoneCheck: Player in Wintergrasp and battle ground is not active.")
					end --if
					GoGo_Variables.ZoneExclude.CanFly = true
				else
					if GoGo_Variables.Debug then
						GoGo_DebugAddLine("GoGo_ZoneCheck: Failed - Player in Wintergrasp and battle ground is active.")
					end --if
					-- we should be in battle.. can't mount
					GoGo_Variables.ZoneExclude.CanFly = false
				end --if
			elseif GoGo_Variables.Player.Zone == GoGo_Variables.Localize.Zone.Dalaran then
				if not IsFlyableArea() then  -- have to use this.. flying is different in sewers and is different between 4.x with and without cataclysm
					if GoGo_Variables.Debug then
						GoGo_DebugAddLine("GoGo_ZoneCheck: Deactivating Flying - Player in " .. GoGo_Variables.Localize.Zone.Dalaran .. " and not in flyable area.")
					end --if
					GoGo_Variables.ZoneExclude.CanFly = false
				else
					if GoGo_Variables.Debug then
						GoGo_DebugAddLine("GoGo_ZoneCheck: Activating Flying - Player in " .. GoGo_Variables.Localize.Zone.Dalaran .. " and in flyable area.")
					end --if
					GoGo_Variables.ZoneExclude.CanFly = true
				end --if
			else
				-- all other areas in northrend
				if GoGo_Variables.Debug then
					GoGo_DebugAddLine("GoGo_ZoneCheck: Activating Flying - Player in Northrend and in flyable area.")
				end --if
				GoGo_Variables.ZoneExclude.CanFly = true
			end --if
		end --if
	elseif (GoGo_InOutlands()) then
		GoGo_Variables.ZoneExclude.CanFly = true
	elseif (GoGo_InMaelstrom()) then
		if (GoGo_InBook(GoGo_Variables.Localize.FlightMastersLicense)) then
			if GoGo_Variables.Player.Zone == GoGo_Variables.Localize.Zone.Deepholm then
				if GoGo_Variables.Player.SubZone == GoGo_Variables.Localize.Zone.CrumblingDepths then
					if GoGo_Variables.Debug then
						GoGo_DebugAddLine("GoGo_ZoneCheck: Deactivating Flying - in Deepholm / Crumbling Depths.")
					end --if
					GoGo_Variables.ZoneExclude.CanFly = false
				elseif GoGo_Variables.Player.MiniSubZone == GoGo_Variables.Localize.Zone.CrumblingDepths then
					if GoGo_Variables.Debug then
						GoGo_DebugAddLine("GoGo_ZoneCheck: Deactivating Flying - in Deepholm / Crumbling Depths.")
					end --if
					GoGo_Variables.ZoneExclude.CanFly = false
				else
					GoGo_Variables.ZoneExclude.CanFly = true
				end --if
			else
				GoGo_Variables.ZoneExclude.CanFly = true
			end --if
		end --if
	elseif GoGo_Variables.Player.ZoneID == 766 then  -- AQ40
		if GoGo_Variables.Debug then
			GoGo_DebugAddLine("GoGo_ZoneCheck: Including AQ40 mounts since we are not in AQ40.")
		end --if
		GoGo_Variables.ZoneExclude.AQ40 = false
	elseif (GoGo_InAzeroth()) then
		if (GoGo_InBook(GoGo_Variables.Localize.FlightMastersLicense)) then
			if GoGo_Variables.Player.Zone == GoGo_Variables.Localize.Zone.TolBaradPeninsula then
				if GoGo_Variables.Debug then
					GoGo_DebugAddLine("GoGo_ZoneCheck: Deactivating Flying - in Tol Barad Peninsula.")
				end --if
				GoGo_Variables.ZoneExclude.CanFly = false
			elseif GoGo_Variables.Player.Zone == GoGo_Variables.Localize.Zone.TolBarad then
				if GoGo_Variables.Debug then
					GoGo_DebugAddLine("GoGo_ZoneCheck: Deactivating Flying - in Tol Barad.")
				end --if
				GoGo_Variables.ZoneExclude.CanFly = false
			elseif GoGo_Variables.Player.Zone == GoGo_Variables.Localize.Zone.ShimmeringExpanse then
				if GoGo_Variables.Player.SubZone == GoGo_Variables.Localize.Zone.SilverTideHollow then
					if GoGo_Variables.Debug then
						GoGo_DebugAddLine("GoGo_ZoneCheck: Deactivating Flying - in Shimmering Expanse / Silver Tide Hollow.")
					end --if
					GoGo_Variables.ZoneExclude.CanFly = false
				elseif GoGo_Variables.Player.SubZone == GoGo_Variables.Localize.Zone.Nespirah then
					if GoGo_Variables.Debug then
						GoGo_DebugAddLine("GoGo_ZoneCheck: Deactivating Flying - in Shimmering Expanse / Nesphirah.")
					end --if
					GoGo_Variables.ZoneExclude.CanFly = false
				else
					GoGo_Variables.ZoneExclude.CanFly = true
				end --if
			else
				GoGo_Variables.ZoneExclude.CanFly = true
			end --if
		else  -- don't have flight master's license
			GoGo_Variables.ZoneExclude.CanFly = false
		end --if
		if GoGo_Variables.Player.Zone == GoGo_Variables.Localize.Zone.AbyssalDepths then
			if GoGo_Variables.Player.SubZone == GoGo_Variables.Localize.Zone.DarkbreakCove then
				if GoGo_Variables.Debug then
					GoGo_DebugAddLine("GoGo_ZoneCheck: Deactivating Flying - in Abyssal Depths / Darkbreak Cove.  Specifying mount group 'TenebrousCavern'.")
				end --if
				GoGo_Variables.ZoneExclude.CanFly = false
				GoGo_Variables.ZoneExclude.UseMountGroup = "TenebrousCavern"
			elseif GoGo_Variables.Player.SubZone == GoGo_Variables.Localize.Zone.Lghorek then
				if GoGo_Variables.Debug then
					GoGo_DebugAddLine("GoGo_ZoneCheck: Deactivating Flying - in Abyssal Depths / L'ghorek.")
				end --if
				GoGo_Variables.ZoneExclude.CanFly = false
			elseif GoGo_Variables.Player.SubZone == GoGo_Variables.Localize.Zone.TenebrousCavern then
				if GoGo_Variables.Debug then
					GoGo_DebugAddLine("GoGo_ZoneCheck: Deactivating Flying - in Abyssal Depths / Tenebrous Cavern.  Specifying mount group 'TenebrousCavern'.")
				end --if
				GoGo_Variables.ZoneExclude.CanFly = false
				GoGo_Variables.ZoneExclude.UseMountGroup = "TenebrousCavern"
			elseif GoGo_Variables.Player.SubZone == GoGo_Variables.Localize.Zone.TheCerebrillum then
				if GoGo_Variables.Debug then
					GoGo_DebugAddLine("GoGo_ZoneCheck: Deactivating Flying - in Abyssal Depths / The Cerebrillum.")
				end --if
				GoGo_Variables.ZoneExclude.CanFly = false
			elseif GoGo_InBook(GoGo_Variables.Localize.FlightMastersLicense) then
				if GoGo_Variables.Debug then
					GoGo_DebugAddLine("GoGo_ZoneCheck: Activating Flying - in Abyssal Depths (not in known no fly area).")
				end --if
				GoGo_Variables.ZoneExclude.CanFly = true
			end --if
		elseif GoGo_Variables.Player.Zone == GoGo_Variables.Localize.Zone.IsleOfQuelDanas then
			GoGo_Variables.ZoneExclude.CanFly = false
		elseif GoGo_Variables.Player.Zone == GoGo_Variables.Localize.Zone.TheExodar then
			GoGo_Variables.ZoneExclude.CanFly = false
		elseif GoGo_Variables.Player.Zone == GoGo_Variables.Localize.Zone.BloodmystIsle then
			GoGo_Variables.ZoneExclude.CanFly = false
		elseif GoGo_Variables.Player.Zone == GoGo_Variables.Localize.Zone.EversongWoods then
			GoGo_Variables.ZoneExclude.CanFly = false
		elseif GoGo_Variables.Player.Zone == GoGo_Variables.Localize.Zone.SilvermoonCity then
			GoGo_Variables.ZoneExclude.CanFly = false
		elseif GoGo_Variables.Player.Zone == GoGo_Variables.Localize.Zone.Ghostlands then
			GoGo_Variables.ZoneExclude.CanFly = false
		elseif GoGo_Variables.Player.ZoneID == 13 then  -- The Steam Pools
			if GoGo_InBook(GoGo_Variables.Localize.FlightMastersLicense) then
				GoGo_Variables.ZoneExclude.CanFly = true
			else
				GoGo_Variables.ZoneExclude.CanFly = false
			end --if
		elseif GoGo_Variables.Player.ZoneID == 61 then  -- Thousand Needles
			if GoGo_InBook(GoGo_Variables.Localize.FlightMastersLicense) then
				GoGo_Variables.ZoneExclude.CanFly = true
			end --if
			GoGo_Variables.ZoneExclude.ThousandNeedles = false
		end --if
	elseif (GoGo_Variables.Player.Zone == GoGo_Variables.Localize.Zone.TheTempleOfAtalHakkar) and GoGo_InBook(GoGo_Variables.Localize.FlightMastersLicense) then
		GoGo_Variables.ZoneExclude.CanFly = true
	elseif GoGo_Variables.Player.ZoneID == 14 and GoGo_InBook(GoGo_Variables.Localize.FlightMastersLicense) then		-- Blackrock Mountain
		GoGo_Variables.ZoneExclude.CanFly = true
	elseif (GoGo_Variables.Player.Zone == GoGo_Variables.Localize.Zone.DireMaul) and GoGo_InBook(GoGo_Variables.Localize.FlightMastersLicense) then
		if not IsInInstance() then
			if GoGo_Variables.Debug then
				GoGo_DebugAddLine("GoGo_ZoneCheck: Activating Flying - in Dire Maul area not part of Azeroth.")
			end --if
			GoGo_Variables.ZoneExclude.CanFly = true
		end --if
	elseif IsInInstance() then
		if GoGo_Variables.Player.Zone == GoGo_Variables.Localize.Zone.TheOculus then
			GoGo_Variables.ZoneExclude.CanFly = false
			GoGo_Variables.ZoneExclude.TheOculus = false
		elseif GoGo_Variables.Player.Zone == GoGo_Variables.Localize.Zone.TheVortexPinnacle then
			if GoGo_Variables.Debug then
				GoGo_DebugAddLine("GoGo_ZoneCheck: Can't fly.  Specifying mount group 'DefaultInstance'.")
			end --if
			GoGo_Variables.ZoneExclude.CanFly = false
			GoGo_Variables.ZoneExclude.UseMountGroup = "DefaultInstance"
		end --if
	elseif GoGo_IsInBattleGround() then
		GoGo_Variables.ZoneExclude.CanFly = false
	end --if

	if IsIndoors() then	-- indoor zone exclusions go here
		GoGo_Variables.ZoneExclude.RestrictedIndoorMounts = true -- restricting mounts to indoor mounts only unless something below says otherwise
	else
		GoGo_Variables.ZoneExclude.RestrictedIndoorMounts = false
	end --if
end --function

---------
function GoGo_IsInBattleGround()
---------
  for GoGo_TempCount = 1, MAX_BATTLEFIELD_QUEUES do
    local Status, MapName = GetBattlefieldStatus(GoGo_TempCount);
    if(Status=="active")then
      return MapName;
    end --if
  end --if
end --function

---------
function GoGo_CanRide()
---------
	if GoGo_Variables.Player.Level >= 20 then
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
function GoGo_CheckSwimSurface()
---------
	GoGo_Variables.SwimSurface = true

	if GoGo_Prefs.DisableWaterFlight then  -- don't want to fly from water as per client option
		GoGo_Variables.NoFlying = true
		GoGo_Variables.SwimSurface = false
		return
	end --if
	
	for GoGo_TempCount = 1, MIRRORTIMER_NUMTIMERS do
		local timer, value, maxvalue, scale, paused, label = GetMirrorTimerInfo(GoGo_TempCount)
		if timer == "BREATH" then
			if (scale == -1) then
				if GoGo_Variables.Debug then
					GoGo_DebugAddLine("GoGo_CheckSwimSurface: Breath timer bar found and it's slowly draining.  Disabling flying.")
				end --if
				GoGo_Variables.NoFlying = true
				GoGo_Variables.SwimSurface = false
			else
				if GoGo_Variables.Debug then
					GoGo_DebugAddLine("GoGo_CheckSwimSurface: Breath timer not bar found.  Looks like we can fly here.")
				end --if
			end --if
		end --if	
	end --for
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
		return 325
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
function GoGo_GetBestAirMounts(GoGo_FilteredMounts)
---------
	-- Use flight forms if preferred
	local mounts = {}
	local GoGo_TempAirSpeed = {451,418,410,380,275,250}
	--[[	451 = +310% + 10% Mount Up guild perk
		418 = +280% + 10% Mount Up guild perk
		410 = +310%  (Master flight)
		380 = +280%  (300 riding)
		275 = +150 + 10% Mount Up guild perk
		250 = +150%  (225 riding)
	]]
	local GoGo_TempLoopCount = 1
	local GoGo_SearchString = table.concat(GoGo_FilteredMounts, ":")
	if GoGo_Variables.Player.Class == "DRUID" and GoGo_Prefs.DruidFlightForm then
		if GoGo_Variables.Debug then
			GoGo_DebugAddLine("GoGo_GetBestAirMounts: Druid with preferred flight forms option enabled.  Using flight form.")
		end --if
		if string.find(GoGo_SearchString, GoGo_Variables.Localize.FastFlightForm, 1, true) then
			if GoGo_Variables.Debug then
				GoGo_DebugAddLine("GoGo_GetBestAirMounts: Found FastFlightForm")
			end --if
			table.insert(mounts, GoGo_Variables.Localize.FastFlightForm)
		elseif string.find(GoGo_SearchString, GoGo_Variables.Localize.FlightForm, 1, true) then
			if GoGo_Variables.Debug then
				GoGo_DebugAddLine("GoGo_GetBestAirMounts: Found FlightForm")
			end --if
			table.insert(mounts, GoGo_Variables.Localize.FlightForm)
		else
			if GoGo_Variables.Debug then
				GoGo_DebugAddLine("GoGo_GetBestAirMounts: No flight forms found")
				GoGo_DebugAddLine("GoGo_GetBestAirMounts: GoGo_SearchString: "..GoGo_SearchString)
			end --if
		end --if
	end --if

	while (table.getn(mounts) == 0) and (GoGo_TempLoopCount <= table.getn(GoGo_TempAirSpeed)) do
		mounts = GoGo_FilterMountsIn(GoGo_FilteredMounts, 10003, GoGo_TempAirSpeed[GoGo_TempLoopCount])
		GoGo_TempLoopCount = GoGo_TempLoopCount + 1
	end --while

	return mounts
end --function

---------
function GoGo_GetBestGroundMounts(GoGo_FilteredMounts)
---------
	-- Use flight forms if preferred
	local mounts = {}
	local GoGo_TempGroundSpeed = {220,200,176,160,140,135,130,115,110,100}
	--[[	220 = +100% + 10% Mount Up guild perk
		200 = +100%  (150 riding)
		176 = +60% + 10% Mount Up guild perk
		160 = +60%  (75 riding)
		140 = +40% (Druid Travel form)
		135 = +35%  (Shaman wolf form with glyph)
		130 = +30% (Druid with 2 Feral Swiftness talent points, Shaman wolf form, Hunter aspects)
		115 = +15% (Druid with 1 Feral Swiftness talent point)
		110 = +0% +10% Mount Up guild perk (only effects sea turtle)
		100 = +0%  (Riding turtle, etc.)
	]]
	local GoGo_TempLoopCount = 1

	while (table.getn(mounts) == 0) and (GoGo_TempLoopCount <= table.getn(GoGo_TempGroundSpeed)) do
		mounts = GoGo_FilterMountsIn(GoGo_FilteredMounts, 10002, GoGo_TempGroundSpeed[GoGo_TempLoopCount])
		GoGo_TempLoopCount = GoGo_TempLoopCount + 1
	end --while

	return mounts
end --function

---------
function GoGo_GetBestWaterMounts(GoGo_FilteredMounts)
---------
	local mounts = {}
	local GoGo_TempSwimSpeed = {371,270,135,108,101,67}
	local GoGo_TempSwimSurfaceSpeed = {371,286,270,67}
	local GoGo_TempLoopCount = 1
	if not GoGo_Variables.SwimSurface then
		if GoGo_Variables.Debug then
			GoGo_DebugAddLine("GoGo_GetBestWaterMounts: Under water mount selection.")
		end --if
		while (table.getn(mounts) == 0) and (GoGo_TempLoopCount <= table.getn(GoGo_TempSwimSpeed)) do
			mounts = GoGo_FilterMountsIn(GoGo_FilteredMounts, 10001, GoGo_TempSwimSpeed[GoGo_TempLoopCount])
			GoGo_TempLoopCount = GoGo_TempLoopCount + 1
		end --while
	else
		if GoGo_Variables.Debug then
			GoGo_DebugAddLine("GoGo_GetBestWaterMounts: Water surface mount selection.")
		end --if
		while (table.getn(mounts) == 0) and (GoGo_TempLoopCount <= table.getn(GoGo_TempSwimSurfaceSpeed)) do
			mounts = GoGo_FilterMountsIn(GoGo_FilteredMounts, 10004, GoGo_TempSwimSurfaceSpeed[GoGo_TempLoopCount])
			GoGo_TempLoopCount = GoGo_TempLoopCount + 1
		end --while
	end --if
	if GoGo_Variables.Debug then
		GoGo_DebugAddLine("GoGo_GetBestWaterMounts: " .. table.getn(mounts) .. " water mounts found in " .. (GoGo_TempLoopCount - 1) .. " loop count.")
	end --if
	return mounts
end --function

---------
function GoGo_UpdateMountData()
---------

	if (GoGo_Variables.Player.Class == "DRUID") and (GoGo_GetTalentInfo(GoGo_Variables.Localize.Talent.FeralSwiftness) == 1) then
		GoGo_Variables.MountDB[GoGo_Variables.Localize.CatForm][10002] = 115
		if GoGo_Variables.Debug then
			GoGo_DebugAddLine("GoGo_UpdateMountData: We're a druid with 1 Feral Swiftness point.  Modifying Catform speed data.")
		end --if
	elseif (GoGo_Variables.Player.Class == "DRUID") and (GoGo_GetTalentInfo(GoGo_Variables.Localize.Talent.FeralSwiftness) == 2) then
		GoGo_Variables.MountDB[GoGo_Variables.Localize.CatForm][10002] = 130
		if GoGo_Variables.Debug then
			GoGo_DebugAddLine("GoGo_UpdateMountData: We're a druid with 2 Feral Swiftness points.  Modifying Catform speed data.")
		end --if
	elseif (GoGo_Variables.Player.Class == "DRUID") then
		if GoGo_Variables.Debug then
			GoGo_DebugAddLine("GoGo_UpdateMountData: We're a druid with 0 Feral Swiftness points.  Doing nothing.")
		end --if
	end --if

	if (GoGo_Variables.Player.Class == "SHAMAN") and (GoGo_GlyphActive(GoGo_Variables.Localize.Glyph_GhostWolf)) then
		GoGo_Variables.MountDB[GoGo_Variables.Localize.GhostWolf][10002] = 135
		if GoGo_Variables.Debug then
			GoGo_DebugAddLine("GoGo_UpdateMountData: We're a shaman with Glyph of Ghost Wolf.  Modifying Ghost Wolf speed data.")
		end --if
	elseif (GoGo_Variables.Player.Class == "SHAMAN") then
		if GoGo_Variables.Debug then
			GoGo_DebugAddLine("GoGo_UpdateMountData: We're a shaman without Glyph of Ghost Wolf.  Not doing anything.")
		end --if
	end --if

	if (GoGo_Variables.Player.Class == "SHAMAN") and (GoGo_Variables.Shaman.AncestralSwiftness == 2) then
		GoGo_Variables.MountDB[GoGo_Variables.Localize.GhostWolf][7] = true
		if GoGo_Variables.Debug then
			GoGo_DebugAddLine("GoGo_UpdateMountData: We're a shaman with 2 Ancestral Swiftness points.  Modifying Ghost Wolf spell data.")
		end --if
	elseif (GoGo_Variables.Player.Class == "SHAMAN") then
		GoGo_Variables.MountDB[GoGo_Variables.Localize.GhostWolf][7] = false
		if GoGo_Variables.Debug then
			GoGo_DebugAddLine("GoGo_UpdateMountData: We're a shaman with 0 Ancestral Swiftness points.  Modifying Ghost Wolf spell data.")
		end --if
	end --if

	if (GoGo_Variables.Player.Class == "DRUID") and (GoGo_GlyphActive(GoGo_Variables.Localize.Glyph_AquaticForm)) then
		GoGo_Variables.MountDB[GoGo_Variables.Localize.AquaForm][10001] = 135
		GoGo_Variables.MountDB[GoGo_Variables.Localize.AquaForm][10004] = 135
		if GoGo_Variables.Debug then
			GoGo_DebugAddLine("GoGo_UpdateMountData: We're a druid with Glyph of Aquatic Form.  Modifying Aquatic Form speed data.")
		end --if
	end --if

	if not GoGo_Variables.ZoneExclude.ThousandNeedles then  -- we are in thousand needles - ground mounts swim faster with buff
		local GoGo_TempMountDB = {}
		local GoGo_TempLoopCounter
		if UnitBuff("player", GetSpellInfo(75627)) and IsSwimming() then
			if GoGo_Variables.Debug then
				GoGo_DebugAddLine("GoGo_UpdateMountData: In Thousand Needles with buff.  Updating water speed of ground mounts.")
			end --if

			GoGo_TempMountDB = GoGo_FilterMountsIn(GoGo_Variables.FilteredMounts, 400)
			if GoGo_Variables.Debug then
				GoGo_DebugAddLine("GoGo_UpdateMountData: Number of mounts to increase water speed on:  " .. (table.getn(GoGo_TempMountDB) or 0))
			end --if
			for GoGo_TempLoopCounter=1, table.getn(GoGo_TempMountDB) do
				GoGo_Variables.MountDB[GoGo_TempMountDB[GoGo_TempLoopCounter]][10001] = 108
				GoGo_Variables.MountDB[GoGo_TempMountDB[GoGo_TempLoopCounter]][10004] = 108
			end --for
		end --if
	end --if
	
	if (GoGo_Variables.Player.ZoneID == 610) or (GoGo_Variables.Player.ZoneID == 614) or (GoGo_Variables.Player.ZoneID == 615) then
		if GoGo_Variables.ExpansionAccount == 3 then  -- only exists for 4.x with Cataclysm expansion
			if UnitBuff("player", GetSpellInfo(GoGo_Variables.Localize.SeaLegs)) then
				GoGo_UpdateMountSpeedDB(GoGo_Variables.FilteredMounts, 404, 10001, 270)
				GoGo_UpdateMountSpeedDB(GoGo_Variables.FilteredMounts, 404, 10004, 270)
			end --if
		end --if
	end --if
	
	-- mount speed updates based on riding skill
	if GoGo_GetRidingSkillLevel() == 325 then  -- increase air mounts to 410
		GoGo_UpdateMountSpeedDB(GoGo_Variables.FilteredMounts, 300, 10003, 410)
	elseif GoGo_GetRidingSkillLevel() == 300 then  -- increase air mounts to 380
		GoGo_UpdateMountSpeedDB(GoGo_Variables.FilteredMounts, 301, 10003, 380)
	end --if

	if GoGo_GetRidingSkillLevel() >= 150 then  -- increase ground mounts to 200
		GoGo_UpdateMountSpeedDB(GoGo_Variables.FilteredMounts, 330, 10002, 200)
	end --if	

	-- Mount Up guild perk updates
	if IsInGuild() and GetGuildPerkInfo(2) then
		if GoGo_Variables.Debug then
			GoGo_DebugAddLine("GoGo_UpdateMountData: In guild, with Mount Up perk")
		end --if
		if not UnitInBattleground("player") then
			if GoGo_Variables.Debug then
				GoGo_DebugAddLine("GoGo_UpdateMountData: Increasing mount speed data because of Mount Up")
			end --if
			local GoGo_TempMountDB = {}
			GoGo_TempMountDB = GoGo_FilterMountsIn(GoGo_Variables.FilteredMounts, 402) or {}  -- ground mounts to modify
			for GoGo_TempCounter = 1, table.getn(GoGo_TempMountDB) do
				if GoGo_Variables.MountDB[GoGo_TempMountDB[GoGo_TempCounter]][10002] == 200 then
					GoGo_Variables.MountDB[GoGo_TempMountDB[GoGo_TempCounter]][10002] = 220
				elseif GoGo_Variables.MountDB[GoGo_TempMountDB[GoGo_TempCounter]][10002] == 160 then
					GoGo_Variables.MountDB[GoGo_TempMountDB[GoGo_TempCounter]][10002] = 176
				elseif GoGo_Variables.MountDB[GoGo_TempMountDB[GoGo_TempCounter]][10002] == 100 then
					GoGo_Variables.MountDB[GoGo_TempMountDB[GoGo_TempCounter]][10002] = 110
				end --if
			end --for
			GoGo_TempMountDB = GoGo_FilterMountsIn(GoGo_Variables.FilteredMounts, 403) or {}  -- air mounts to modify
			for GoGo_TempCounter = 1, table.getn(GoGo_TempMountDB) do
				if GoGo_Variables.MountDB[GoGo_TempMountDB[GoGo_TempCounter]][10003] == 250 then
					GoGo_Variables.MountDB[GoGo_TempMountDB[GoGo_TempCounter]][10003] = 275
				elseif GoGo_Variables.MountDB[GoGo_TempMountDB[GoGo_TempCounter]][10003] == 380 then
					GoGo_Variables.MountDB[GoGo_TempMountDB[GoGo_TempCounter]][10003] = 418
				elseif GoGo_Variables.MountDB[GoGo_TempMountDB[GoGo_TempCounter]][10003] == 410 then
					GoGo_Variables.MountDB[GoGo_TempMountDB[GoGo_TempCounter]][10003] = 451
				end --if
			end --for
		else
			if GoGo_Variables.Debug then
				GoGo_DebugAddLine("GoGo_UpdateMountData: Not increasing mount speed data because of Mount Up - in battle ground")
			end --if
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
		if GoGo_Prefs.DruidClickForm then
			if GoGo_InBook(GoGo_Variables.Localize.AquaForm) then
				if not GoGo_Variables.SkipFlyingMount and GoGo_InBook(GoGo_Variables.Localize.FastFlightForm) and GoGo_Variables.CanFly then
					return "/cancelform [flying] \n/use [swimming] "..GoGo_InBook(GoGo_Variables.Localize.AquaForm).."; [indoors]"..GoGo_InBook(GoGo_Variables.Localize.CatForm).."; [combat]"..GoGo_InBook(GoGo_Variables.Localize.TravelForm).."; "..GoGo_InBook(GoGo_Variables.Localize.FastFlightForm)
				elseif not GoGo_Variables.SkipFlyingMount and GoGo_InBook(GoGo_Variables.Localize.FlightForm) and GoGo_Variables.CanFly then
					return "/cancelform [flying] \n/use [swimming] "..GoGo_InBook(GoGo_Variables.Localize.AquaForm).."; [indoors]"..GoGo_InBook(GoGo_Variables.Localize.CatForm).."; [combat]"..GoGo_InBook(GoGo_Variables.Localize.TravelForm).."; "..GoGo_InBook(GoGo_Variables.Localize.FlightForm)
				else
					return "/cancelform [flying] \n/use [swimming] "..GoGo_InBook(GoGo_Variables.Localize.AquaForm).."; [indoors]"..GoGo_InBook(GoGo_Variables.Localize.CatForm)..";"..GoGo_InBook(GoGo_Variables.Localize.TravelForm)
				end --if
			end --if
		else
			local GoGo_NumForms = GetNumShapeshiftForms()
			local GoGo_FormName = ""
			local GoGo_CastString = "/use "
			for GoGo_TempCount = 1, GoGo_NumForms do
				_, GoGo_FormName = GetShapeshiftFormInfo(GoGo_TempCount)
				GoGo_CastString = GoGo_CastString .. "[form:" .. GoGo_TempCount .. "] "..GoGo_FormName..";"
			end --for
			if GoGo_InBook(GoGo_Variables.Localize.AquaForm) then
				if not GoGo_Variables.SkipFlyingMount and GoGo_InBook(GoGo_Variables.Localize.FastFlightForm) and GoGo_Variables.CanFly then
					GoGo_CastString = GoGo_CastString .. "[swimming] "..GoGo_InBook(GoGo_Variables.Localize.AquaForm).."; [indoors]"..GoGo_InBook(GoGo_Variables.Localize.CatForm).."; [combat]"..GoGo_InBook(GoGo_Variables.Localize.TravelForm).."; "..GoGo_InBook(GoGo_Variables.Localize.FastFlightForm)
				elseif not GoGo_Variables.SkipFlyingMount and GoGo_InBook(GoGo_Variables.Localize.FlightForm) and GoGo_Variables.CanFly then
					GoGo_CastString = GoGo_CastString .. "[swimming] "..GoGo_InBook(GoGo_Variables.Localize.AquaForm).."; [indoors]"..GoGo_InBook(GoGo_Variables.Localize.CatForm).."; [combat]"..GoGo_InBook(GoGo_Variables.Localize.TravelForm).."; "..GoGo_InBook(GoGo_Variables.Localize.FlightForm)
				else
					GoGo_CastString = GoGo_CastString .. "[swimming] "..GoGo_InBook(GoGo_Variables.Localize.AquaForm).."; [indoors]"..GoGo_InBook(GoGo_Variables.Localize.CatForm)..";"..GoGo_InBook(GoGo_Variables.Localize.TravelForm)
				end --if
			end --if
			return GoGo_CastString
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
			GoGo_Prefs.Zones[GoGo_Variables.Player.Zone] = nil
			if not InCombatLockdown() then
				for i, button in ipairs({GoGoButton, GoGoButton2}) do
					GoGo_FillButton(button)
				end --for
			end --if
		end --if
		GoGo_Msg("pref")
	end, --function
	["debug"] = function()
		GoGo_Variables.Debug=true
		GoGo_Msg("debug")
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
			if GoGo_Prefs.Zones[GoGo_Variables.Player.Zone] then
				list = list .. GoGo_GetIDName(GoGo_Prefs.Zones[GoGo_Variables.Player.Zone])
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
			if GoGo_Prefs.Zones[GoGo_Variables.Player.Zone] then
				list = list .. GoGo_GetIDName(GoGo_Prefs.Zones[GoGo_Variables.Player.Zone])
				msg = msg .. "\n" .. GoGo_Variables.Player.Zone ..": "..list.." - Disable global mount preferences to change."
			end --if
			return msg
		end --if
	end, --function
	["debug"] = function()
		if GoGo_Variables.Debug then
			return "GoGoMount debugging enabled for 1 GoGoButton click."
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

	GoGo_Panel_DisableWaterFlight = CreateFrame("CheckButton", "GoGo_Panel_DisableWaterFlight", GoGo_Panel, "OptionsCheckButtonTemplate")
	GoGo_Panel_DisableWaterFlight:SetPoint("TOPLEFT", "GoGo_Panel_DisableMountNotice", "BOTTOMLEFT", 0, -4)
	GoGo_Panel_DisableWaterFlightText:SetText(GoGo_Variables.Localize.String.DisableFlyingFromWater)
	GoGo_Panel_DisableWaterFlight:SetScript("OnClick",
		function(self)
			GoGo_Panel_Okay("MAIN")
		end --function
	)
	
	GoGo_Panel_RemoveBuffs = CreateFrame("CheckButton", "GoGo_Panel_RemoveBuffs", GoGo_Panel, "OptionsCheckButtonTemplate")
	GoGo_Panel_RemoveBuffs:SetPoint("TOPLEFT", "GoGo_Panel_DisableWaterFlight", "BOTTOMLEFT", 0, -4)
	GoGo_Panel_RemoveBuffsText:SetText(GoGo_Variables.Localize.String.RemoveBuffs)
	GoGo_Panel_RemoveBuffs:SetScript("OnClick",
		function(self)
			GoGo_Panel_Okay("MAIN")
		end --function
	)

	--[[	
	local GoGo_Panel_ClearGlobalFavorites = CreateFrame("FRAME")
	local GoGo_Panel_ClearGlobalFavorites_Text = GoGo_Panel_ClearGlobalFavorites:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
	GoGo_Panel_ClearGlobalFavorites_Text:SetText(GoGo_Variables.Localize.String.ClearGlobalFavoriteMounts)
	GoGo_Panel_ClearGlobalFavorites_Text:SetNonSpaceWrap(true)
	GoGo_Panel_ClearGlobalFavorites_Text:SetJustifyH("LEFT")
	GoGo_Panel_ClearGlobalFavorites_Text:SetJustifyV("TOP")
	GoGo_Panel_ClearGlobalFavorites_Text:SetWidth(350)
	GoGo_Panel_ClearGlobalFavorites_Text:SetPoint("BOTTOMLEFT", 16, 112)
	GoGo_Panel_ClearGlobalFavorites_Button = CreateFrame("Button","GoGo_Panel_ClearGlobalFavorites_Button",GoGo_Panel,"UIPanelButtonTemplate")
	GoGo_Panel_ClearGlobalFavorites_Button:SetPoint("BOTTOMLEFT",16,16)
	GoGo_Panel_ClearGlobalFavorites_Button:SetWidth(80)
	GoGo_Panel_ClearGlobalFavorites_Button:SetHeight(22)
	GoGo_Panel_ClearGlobalFavorites_Button:SetText(GoGo_Variables.Localize.String.Clear)
	]]
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
function GoGo_Panel_UpdateViews(Class)  -- check to see what's calling this (improve performance)
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
		GoGo_Panel_DisableWaterFlight:SetChecked(GoGo_Prefs.DisableWaterFlight)
		GoGo_Panel_RemoveBuffs:SetChecked(GoGo_Prefs.RemoveBuffs)
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
		GoGo_Prefs.DisableWaterFlight = GoGo_Panel_DisableWaterFlight:GetChecked()
		GoGo_Prefs.RemoveBuffs = GoGo_Panel_RemoveBuffs:GetChecked()
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
		GoGo_Prefs.DisableWaterFlight = true
		GoGo_Prefs.RemoveBuffs = true
	else
		GoGo_Prefs = {}
		GoGo_Prefs.Zones = {}
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
		GoGo_Prefs.DisableWaterFlight = true
		GoGo_Prefs.RemoveBuffs = true
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
	if not GoGo_Prefs.DisableWaterFlight then GoGo_Prefs.DisableWaterFlight = false end
	if not GoGo_Prefs.RemoveBuffs then GoGo_Prefs.RemoveBuffs = false end

	GoGo_Prefs.UnknownMounts = {}
	if not GoGo_Prefs.GlobalExclude then
		GoGo_Prefs.GlobalExclude = {}
	end --if
	if not GoGo_Prefs.Zones then
		GoGo_Prefs.Zones = {}
	end --if
	
	-- old variables no longer used so we're removing them from the saved variables
	GoGo_Prefs.preferflight = nil
	GoGo_Prefs.RemoveDebuffs = nil
	GoGo_Prefs.checkspells = nil
	GoGo_Prefs.PaliUseCrusader = nil
	
end --function

---------
function GoGo_DebugCollectInformation()
---------
	GoGo_DebugAddLine("Information: GoGoMount Version " .. GetAddOnMetadata("GoGoMount", "Version"))
	if GoGo_Variables.ExpansionAccount == 0 then
		GoGo_DebugAddLine("Information: Account - World of Warcraft (Classic) enabled.")
	elseif GoGo_Variables.ExpansionAccount == 1 then
		GoGo_DebugAddLine("Information: Account - World of Warcraft: The Burning Crusade enabled.")
	elseif GoGo_Variables.ExpansionAccount == 2 then
		GoGo_DebugAddLine("Information: Account - World of Warcraft: Wrath of the Lich King enabled.")
	elseif GoGo_Variables.ExpansionAccount == 3 then
		GoGo_DebugAddLine("Information: Account - World of Warcraft: Cataclysm enabled.")
	end --if
	if GoGo_Variables.ExpansionGame == 0 then
		GoGo_DebugAddLine("Information: Game - World of Warcraft (Classic) enabled.")
	elseif GoGo_Variables.ExpansionGame == 1 then
		GoGo_DebugAddLine("Information: Game - World of Warcraft: The Burning Crusade enabled.")
	elseif GoGo_Variables.ExpansionGame == 2 then
		GoGo_DebugAddLine("Information: Game - World of Warcraft: Wrath of the Lich King enabled.")
	elseif GoGo_Variables.ExpansionGame == 3 then
		GoGo_DebugAddLine("Information: Game - World of Warcraft: Cataclysm enabled.")
	end --if
	GoGo_DebugAddLine("Information: Client locale is " .. GetLocale())
	
	GoGo_DebugAddLine("Information: Location = " .. GetRealZoneText() .. " - " .. GetZoneText() .. " - " ..GetSubZoneText() .. " - " .. GetMinimapZoneText())
	GoGo_DebugAddLine("Information: Current zone area ID as per GetCurrentMapAreaID(): " .. GetCurrentMapAreaID())
	local posX, posY = GetPlayerMapPosition("Player")
	GoGo_DebugAddLine("Information: Player location: X = ".. posX .. ", Y = " .. posY)
	GoGo_DebugAddLine("Information: Current unit speed is " .. GetUnitSpeed("player"))
	local level = UnitLevel("player")
	GoGo_DebugAddLine("Information: We are level " .. level)
	GoGo_DebugAddLine("Information: We are a " .. GoGo_Variables.Player.Race .. " " .. GoGo_Variables.Player.Class)
	if IsInGuild() and GetGuildPerkInfo(2) then
		GoGo_DebugAddLine("Information: We are in a guild with the Mount Up perk")
	end --if
	if InCombatLockdown() then
		GoGo_DebugAddLine("Information: We are in combat as per InCombatLockdown()")
	else
		GoGo_DebugAddLine("Information: We are not in combat as per InCombatLockdown()")
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
	GoGo_DebugAddLine("Information: End of information.")	
end --function
