if GetLocale() == "zhTW" then
	BINDING_HEADER_GOGOHEADER = "GoGoMount" -- Needs review
	BINDING_NAME_GOGOBINDING = "坐騎/解除坐騎" -- Needs review
	BINDING_NAME_GOGOBINDING2 = "坐騎/解除坐騎(無飛行)" -- Needs review
	BINDING_NAME_GOGOBINDING3 = "坐騎/解除有乘客的坐騎" -- Needs review
	GoGo_Variables.Localize = {
			Skill = {
				Engineering = "工程學",
				Riding = "騎術", -- Needs review
				Tailoring = "裁縫",
			},
			String = {
				CurrentZoneFavorites = "當前地區的偏好", -- Needs review
				DisableUnknownMountNotices = "停用未知的坐騎通知", -- Needs review
				DisableUpdateNotices = "停用更新通知", -- Needs review
				-- DruidFlightPreference = "",
				DruidSingleClick = "單擊後從變身形態轉換為旅行形態", -- Needs review
				EnableAutoDismount = "啟用自動解除坐騎", -- Needs review
				Favorites = "偏好", -- Needs review
				GlobalFavorites = "總體偏好", -- Needs review
				GlobalPreferences = "總體優先", -- Needs review
				NewVersionFound = "可從GoGoMount的更新獲得並可開始使用", -- Needs review
				UnknownMountFound = "在你的坐騎清單中找到未知的坐騎。請回報它，以便加入到GoGoMount的新版本中。", -- Needs review
			},
			Talent = {
				-- AncestralSwiftness = "",
				FeralSwiftness = "迅捷飛行形態",
			},
			Zone = {
				AQ40 = "安其拉",
				-- CrumblingDepths = "",
				Dalaran = "達拉然",
				-- Deepholm = "",
				DireMaul = "厄運之槌",
				Icecrown = "寒冰皇冠", -- Needs review
				-- Ironforge = "",
				KrasusLanding = "卡薩斯平臺",
				SholazarBasin = "休拉薩盆地", -- Needs review
				-- TempleOfEarth = "",
				TheFrozenSea = "冰凍之海",
				-- TheOculus = "",
				TheStormPeaks = "風暴群山", -- Needs review
				TheUnderbelly = "城底區",
				TheVioletCitadel = "紫羅蘭城塞",
				-- TolBaradPeninsula = "",
				TwistingNether = "扭曲虛空",
				-- Vashjir = "",
				Wintergrasp = "冬握湖",
			},
}
end --if