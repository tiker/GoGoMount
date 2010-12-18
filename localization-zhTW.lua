if GetLocale() == "zhTW" then
	BINDING_HEADER_GOGOHEADER = "GoGoMount"
	BINDING_NAME_GOGOBINDING = "坐騎/解除坐騎"
	BINDING_NAME_GOGOBINDING2 = "坐騎/解除坐騎(無飛行)"
	BINDING_NAME_GOGOBINDING3 = "坐騎/解除有乘客的坐騎"
	GoGo_Variables.Localize = {
			Skill = {
				Engineering = "工程學",
				Riding = "騎術",
				Tailoring = "裁縫",
			},
			String = {
				AutomaticallyRemoveBuffs = "自動移除防止騎乘的增益",
				Clear = "Clear", -- Requires localization
				ClearGlobalFavoriteMounts = "Clear global favorite mounts", -- Requires localization
				CurrentZoneFavorites = "當前地區的偏好",
				DisableFlyingFromWater = "Disable flying from water", -- Requires localization
				DisableUnknownMountNotices = "停用未知的坐騎通知",
				DisableUpdateNotices = "停用更新通知",
				DruidFlightPreference = "當角色移動時使用飛行型態取代座騎",
				DruidOptions = "Druid Options", -- Requires localization
				DruidSingleClick = "單擊後從變身形態轉換為旅行形態",
				EnableAutoDismount = "啟用自動解除坐騎",
				Favorites = "偏好",
				GlobalFavorites = "總體偏好",
				GlobalPreferences = "總體優先",
				HunterOptions = "Hunter Options", -- Requires localization
				NewVersionFound = "已有GoGoMount的更新版本",
				NoShapeInRandom = "Do not randomize shape forms with mounts", -- Requires localization
				RemoveBuffs = "Remove buffs that can prevent mounting", -- Requires localization
				UnknownMountFound = "在你的坐騎清單中找到未知的坐騎。請回報它，以便加入到GoGoMount的新版本中。",
				UseAspectOfThePackInstead = "Use Aspect Of The Pack instead of Aspect Of The Cheeta", -- Requires localization
			},
			Talent = {
				AncestralSwiftness = "先祖迅捷",
				FeralSwiftness = "迅捷飛行形態",
			},
			Zone = {
				AQ40 = "安其拉",
				AbyssalDepths = "Abyssal Depths", -- Requires localization
				CrumblingDepths = "破碎深淵",
				Dalaran = "達拉然",
				DarkbreakCove = "Darkbreak Cove", -- Requires localization
				Deepholm = "地深之源",
				DireMaul = "厄運之槌",
				Icecrown = "寒冰皇冠",
				Ironforge = "鐵爐堡",
				KrasusLanding = "卡薩斯平臺",
				LegionsRest = "Legion's Rest", -- Requires localization
				Lghorek = "L'ghorek", -- Requires localization
				Nespirah = "Nespirah", -- Requires localization
				ShimmeringExpanse = "Shimmering Expanse", -- Requires localization
				SholazarBasin = "休拉薩盆地",
				SilverTideHollow = "Silver Tide Hollow", -- Requires localization
				TempleOfEarth = "大地神殿",
				TenebrousCavern = "Tenebrous Cavern", -- Requires localization
				TheCerebrillum = "The Cerebrillum", -- Requires localization
				TheFrozenSea = "冰凍之海",
				TheOculus = "奧核之眼",
				TheStormPeaks = "風暴群山",
				TheTempleOfAtalHakkar = "The Temple of Atal'Hakkar", -- Requires localization
				TheUnderbelly = "城底區",
				TheVioletCitadel = "紫羅蘭城塞",
				TheVortexPinnacle = "The Vortex Pinnacle", -- Requires localization
				TolBarad = "Tol Barad", -- Requires localization
				TolBaradPeninsula = "托巴拉德半島",
				TwistingNether = "扭曲虛空",
				Vashjir = "瓦許爾",
				Wintergrasp = "冬握湖",
			},
}
end --if