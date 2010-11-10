﻿if GetLocale() == "zhCN" then
	BINDING_HEADER_GOGOHEADER = "GoGoMount" -- Needs review
	BINDING_NAME_GOGOBINDING = "召唤坐骑/解散坐骑 按键绑定" -- Needs review
	BINDING_NAME_GOGOBINDING2 = "召唤/解散坐骑 (非飞行坐骑) 按键绑定" -- Needs review
	BINDING_NAME_GOGOBINDING3 = "召唤/解散多人坐骑 按键绑定" -- Needs review
	GoGo_Variables.Localize = {
			Skill = {
				Engineering = "工程学", -- Needs review
				Riding = "骑术", -- Needs review
				Tailoring = "裁缝", -- Needs review
			},
			String = {
				AutomaticallyRemoveBuffs = "Automatically remove buffs that prevent mounting", -- Requires localization
				CurrentZoneFavorites = "当前地域收藏", -- Needs review
				DisableUnknownMountNotices = "关闭未知坐骑提示", -- Needs review
				DisableUpdateNotices = "关闭更新提示", -- Needs review
				DruidFlightPreference = "在角色移动的情况下总是使用飞行形态", -- Needs review
				DruidOptions = "Druid Options", -- Requires localization
				DruidSingleClick = "一键切换至旅行形态", -- Needs review
				EnableAutoDismount = "开启自动解散坐骑", -- Needs review
				Favorites = "收藏", -- Needs review
				GlobalFavorites = "全局收藏", -- Needs review
				GlobalPreferences = "全局优先", -- Needs review
				HunterOptions = "Hunter Options", -- Requires localization
				NewVersionFound = "GoGoMount 有新版本可更新", -- Needs review
				NoShapeInRandom = "Do not randomize shape forms with mounts", -- Requires localization
				UnknownMountFound = "在您的坐骑列表中发现一个未知的坐骑.请报告以便在未来版本中加入 注意 - 信息根据条件显示", -- Needs review
				UseAspectOfThePackInstead = "Use Aspect Of The Pack instead of Aspect Of The Cheeta", -- Requires localization
			},
			Talent = {
				AncestralSwiftness = "Ancestral Swiftness", -- Requires localization
				FeralSwiftness = "野性狼魂", -- Needs review
			},
			Zone = {
				AQ40 = "安其拉神殿", -- Needs review
				CrumblingDepths = "Crumbling Depths", -- Requires localization
				Dalaran = "达拉然", -- Needs review
				Deepholm = "Deepholm", -- Requires localization
				DireMaul = "Dire Maul", -- Requires localization
				Icecrown = "冰冠冰川", -- Needs review
				Ironforge = "Ironforge", -- Requires localization
				KrasusLanding = "克拉苏斯平台", -- Needs review
				SholazarBasin = "索拉查盆地", -- Needs review
				TempleOfEarth = "Temple of Earth", -- Requires localization
				TheFrozenSea = "冰冻之海", -- Needs review
				TheOculus = "魔环", -- Needs review
				TheStormPeaks = "风暴峭壁", -- Needs review
				TheTempleOfAtalHakkar = "The Temple of Atal'Hakkar", -- Requires localization
				TheUnderbelly = "达拉然下水道", -- Needs review
				TheVioletCitadel = "紫罗兰城堡", -- Needs review
				TolBarad = "Tol Barad", -- Requires localization
				TolBaradPeninsula = "Tol Barad Peninsula", -- Requires localization
				TwistingNether = "扭曲虚空", -- Needs review
				Vashjir = "Vashj'ir", -- Requires localization
				Wintergrasp = "冬拥湖", -- Needs review
			},
}
end --if