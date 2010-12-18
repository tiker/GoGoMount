if GetLocale() == "ruRU" then
	BINDING_HEADER_GOGOHEADER = "GoGoMount"
	BINDING_NAME_GOGOBINDING = "Оседлать/Спешиться"
	BINDING_NAME_GOGOBINDING2 = "Оседлать/Спешиться (наземный транспорт)"
	BINDING_NAME_GOGOBINDING3 = "Оседлать/Спешиться (транспорт с пассажирами)"
	GoGo_Variables.Localize = {
			Skill = {
				Engineering = "Инженерное дело", -- Needs review
				Riding = "Верховая езда", -- Needs review
				Tailoring = "Портняжное дело", -- Needs review
			},
			String = {
				AutomaticallyRemoveBuffs = "Automatically remove buffs that prevent mounting", -- Requires localization
				Clear = "Clear", -- Requires localization
				ClearGlobalFavoriteMounts = "Clear global favorite mounts", -- Requires localization
				CurrentZoneFavorites = "Current Zone Favorites", -- Requires localization
				DisableFlyingFromWater = "Disable flying from water", -- Requires localization
				DisableUnknownMountNotices = "Отключить уведомления о неизвестных средствах передвижения",
				DisableUpdateNotices = "Отключить уведомления об обновлении",
				DruidFlightPreference = "Всегда использовать облик птицы (иначе только при передвижении)",
				DruidOptions = "Druid Options", -- Requires localization
				DruidSingleClick = "Одиночное нажатие при использовании в обликах друида",
				EnableAutoDismount = "Включить автоматическое спешивание",
				Favorites = "Favorites", -- Requires localization
				GlobalFavorites = "Global Favorites", -- Requires localization
				GlobalPreferences = "Глобальные предпочтения", -- Needs review
				HunterOptions = "Hunter Options", -- Requires localization
				NewVersionFound = "Доступна новая версия GoGoMount.",
				NoShapeInRandom = "Do not randomize shape forms with mounts", -- Requires localization
				RemoveBuffs = "Remove buffs that can prevent mounting", -- Requires localization
				UnknownMountFound = "В списке ваших транспортных средств обнаружено неизвестное средство передвижения. Пожалуйста, сообщите о нем, чтобы мы могли добавить его в будущих версиях GoGoMount.",
				UseAspectOfThePackInstead = "Use Aspect Of The Pack instead of Aspect Of The Cheeta", -- Requires localization
			},
			Talent = {
				AncestralSwiftness = "Быстрота духов предков",
				FeralSwiftness = "Звериная быстрота",
			},
			Zone = {
				AQ40 = "Ан'Кираж", -- Needs review
				AbyssalDepths = "Abyssal Depths", -- Requires localization
				CrumblingDepths = "Crumbling Depths", -- Requires localization
				Dalaran = "Даларан",
				DarkbreakCove = "Darkbreak Cove", -- Requires localization
				Deepholm = "Deepholm", -- Requires localization
				DireMaul = "Забытый Город", -- Needs review
				Icecrown = "Ледяная Корона",
				Ironforge = "Стальгорн",
				KrasusLanding = "Площадка Краса",
				LegionsRest = "Legion's Rest", -- Requires localization
				Lghorek = "L'ghorek", -- Requires localization
				Nespirah = "Nespirah", -- Requires localization
				ShimmeringExpanse = "Shimmering Expanse", -- Requires localization
				SholazarBasin = "Низина Шолазар",
				SilverTideHollow = "Silver Tide Hollow", -- Requires localization
				TempleOfEarth = "Temple of Earth", -- Requires localization
				TenebrousCavern = "Tenebrous Cavern", -- Requires localization
				TheCerebrillum = "The Cerebrillum", -- Requires localization
				TheFrozenSea = "Ледяное море", -- Needs review
				TheOculus = "Окулус", -- Needs review
				TheStormPeaks = "Грозовая Гряда",
				TheTempleOfAtalHakkar = "The Temple of Atal'Hakkar", -- Requires localization
				TheUnderbelly = "Клоака",
				TheVioletCitadel = "Аметистовая крепость",
				TheVortexPinnacle = "Вершина смерча",
				TolBarad = "Tol Barad", -- Requires localization
				TolBaradPeninsula = "Tol Barad Peninsula", -- Requires localization
				TwistingNether = "Круговерть Пустоты", -- Needs review
				Vashjir = "Vashj'ir", -- Requires localization
				Wintergrasp = "Озеро Ледяных Оков", -- Needs review
			},
}
end --if