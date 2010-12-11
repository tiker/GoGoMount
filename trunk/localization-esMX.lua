if GetLocale() == "esMX" then
	BINDING_HEADER_GOGOHEADER = "GoGoMount" -- Needs review
	BINDING_NAME_GOGOBINDING = "Montar/Desmontar" -- Needs review
	BINDING_NAME_GOGOBINDING2 = "Montar/Desmontar (no voladora)" -- Needs review
	BINDING_NAME_GOGOBINDING3 = "Montar/Desmontar Monturas de Pasajeros" -- Needs review
	GoGo_Variables.Localize = {
			Skill = {
				Engineering = "Ingeniería", -- Needs review
				Riding = "Equitación", -- Needs review
				Tailoring = "Sastrería", -- Needs review
			},
			String = {
				AutomaticallyRemoveBuffs = "Automatically remove buffs that prevent mounting", -- Requires localization
				Clear = "Clear", -- Requires localization
				ClearGlobalFavoriteMounts = "Clear global favorite mounts", -- Requires localization
				CurrentZoneFavorites = "Favoritos de Zona Actual", -- Needs review
				DisableFlyingFromWater = "Disable flying from water", -- Requires localization
				DisableUnknownMountNotices = "Desactivar notificaciones de monturas desconocidas", -- Needs review
				DisableUpdateNotices = "Desactivar notificaciones de actualizaciones", -- Needs review
				DruidFlightPreference = "Always use flight forms instead of when moving only", -- Requires localization
				DruidOptions = "Druid Options", -- Requires localization
				DruidSingleClick = "Un click en mayúsculas (shift) para las formas de viaje", -- Needs review
				EnableAutoDismount = "Activar desmonte automático", -- Needs review
				Favorites = "Favoritos", -- Needs review
				GlobalFavorites = "Favoritos Globales", -- Needs review
				GlobalPreferences = "Preferencias Globales", -- Needs review
				HunterOptions = "Hunter Options", -- Requires localization
				NewVersionFound = "Una nueva actualización de GoGoMount está disponible y es usada por ", -- Needs review
				NoShapeInRandom = "Do not randomize shape forms with mounts", -- Requires localization
				UnknownMountFound = "Una montura desconocida ha sido encontrada en la lista de tus monturas. Por favor, reporte esto para que pueda ser añadido en futuras versiones de GoGoMount.", -- Needs review
				UseAspectOfThePackInstead = "Use Aspect Of The Pack instead of Aspect Of The Cheeta", -- Requires localization
			},
			Talent = {
				AncestralSwiftness = "Presteza ancestral", -- Needs review
				FeralSwiftness = "Presteza feral", -- Needs review
			},
			Zone = {
				AQ40 = "Templo de Ahn'Qiraj", -- Needs review
				AbyssalDepths = "Abyssal Depths", -- Requires localization
				CrumblingDepths = "Crumbling Depths", -- Requires localization
				Dalaran = "Dalaran", -- Needs review
				DarkbreakCove = "Darkbreak Cove", -- Requires localization
				Deepholm = "Deepholm", -- Requires localization
				DireMaul = "La Masacre", -- Needs review
				Icecrown = "Corona de Hielo", -- Needs review
				Ironforge = "Forjaz", -- Needs review
				KrasusLanding = "Alto de Kraus", -- Needs review
				LegionsRest = "Legion's Rest", -- Requires localization
				Lghorek = "L'ghorek", -- Requires localization
				Nespirah = "Nespirah", -- Requires localization
				ShimmeringExpanse = "Shimmering Expanse", -- Requires localization
				SholazarBasin = "Cuenca de Sholazar", -- Needs review
				SilverTideHollow = "Silver Tide Hollow", -- Requires localization
				TempleOfEarth = "Temple of Earth", -- Requires localization
				TenebrousCavern = "Tenebrous Cavern", -- Requires localization
				TheFrozenSea = "El Mar Gélido", -- Needs review
				TheOculus = "El Oculus", -- Needs review
				TheStormPeaks = "Las Cumbres Tormentosas", -- Needs review
				TheTempleOfAtalHakkar = "The Temple of Atal'Hakkar", -- Requires localization
				TheUnderbelly = "Los Bajos Fondos", -- Needs review
				TheVioletCitadel = "La Ciudadela Violeta", -- Needs review
				TheVortexPinnacle = "La Cumbre del Vórtice",
				TolBarad = "Tol Barad", -- Requires localization
				TolBaradPeninsula = "Tol Barad Peninsula", -- Requires localization
				TwistingNether = "El Vacío Abisal", -- Needs review
				Vashjir = "Vashj'ir", -- Requires localization
				Wintergrasp = "Conquista del Invierno", -- Needs review
			},
}
end --if
