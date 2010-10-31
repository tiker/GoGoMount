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
				CurrentZoneFavorites = "當前地區的偏好",
				DisableUnknownMountNotices = "停用未知的坐騎通知",
				DisableUpdateNotices = "停用更新通知",
				DruidFlightPreference = "當角色移動時使用飛行型態取代座騎",
				DruidSingleClick = "單擊後從變身形態轉換為旅行形態",
				EnableAutoDismount = "啟用自動解除坐騎",
				Favorites = "偏好",
				GlobalFavorites = "總體偏好",
				GlobalPreferences = "總體優先",
				NewVersionFound = "已有GoGoMount的更新版本",
				UnknownMountFound = "在你的坐騎清單中找到未知的坐騎。請回報它，以便加入到GoGoMount的新版本中。",
			},
			Talent = {
				AncestralSwiftness = "先祖迅捷",
				FeralSwiftness = "迅捷飛行形態",
			},
			Zone = {
				AQ40 = "安其拉",
				CrumblingDepths = "破碎深淵",
				Dalaran = "達拉然",
				Deepholm = "地深之源",
				DireMaul = "厄運之槌",
				Icecrown = "寒冰皇冠",
				Ironforge = "鐵爐堡",
				KrasusLanding = "卡薩斯平臺",
				SholazarBasin = "休拉薩盆地",
				TempleOfEarth = "大地神殿",
				TheFrozenSea = "冰凍之海",
				TheOculus = "奧核之眼",
				TheStormPeaks = "風暴群山",
				TheUnderbelly = "城底區",
				TheVioletCitadel = "紫羅蘭城塞",
				TolBaradPeninsula = "托巴拉德半島",
				TwistingNether = "扭曲虛空",
				Vashjir = "瓦許爾",
				Wintergrasp = "冬握湖",
			},
}
end --if