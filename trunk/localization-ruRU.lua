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
				-- CurrentZoneFavorites = "",
				DisableUnknownMountNotices = "Отключить уведомления о неизвестных средствах передвижения",
				DisableUpdateNotices = "Отключить уведомления об обновлении",
				DruidFlightPreference = "Всегда использовать облик птицы (иначе только при передвижении)",
				DruidSingleClick = "Одиночное нажатие при использовании в обликах друида",
				EnableAutoDismount = "Включить автоматическое спешивание",
				-- Favorites = "",
				-- GlobalFavorites = "",
				GlobalPreferences = "Глобальные предпочтения", -- Needs review
				NewVersionFound = "Доступна новая версия GoGoMount.",
				UnknownMountFound = "В списке ваших транспортных средств обнаружено неизвестное средство передвижения. Пожалуйста, сообщите о нем, чтобы мы могли добавить его в будущих версиях GoGoMount.",
			},
			Talent = {
				AncestralSwiftness = "Быстрота духов предков",
				FeralSwiftness = "Звериная быстрота",
			},
			Zone = {
				AQ40 = "Ан'Кираж", -- Needs review
				-- CrumblingDepths = "",
				Dalaran = "Даларан",
				-- Deepholm = "",
				DireMaul = "Забытый Город", -- Needs review
				Icecrown = "Ледяная Корона",
				Ironforge = "Стальгорн",
				KrasusLanding = "Площадка Краса",
				SholazarBasin = "Низина Шолазар",
				-- TempleOfEarth = "",
				TheFrozenSea = "Ледяное море", -- Needs review
				TheOculus = "Окулус", -- Needs review
				TheStormPeaks = "Грозовая Гряда",
				TheUnderbelly = "Клоака",
				TheVioletCitadel = "Аметистовая крепость",
				-- TolBaradPeninsula = "",
				TwistingNether = "Круговерть Пустоты", -- Needs review
				-- Vashjir = "",
				Wintergrasp = "Озеро Ледяных Оков", -- Needs review
			},
}
end --if