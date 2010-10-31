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
				CurrentZoneFavorites = "Favoritos de Zona Actual", -- Needs review
				DisableUnknownMountNotices = "Desactivar notificaciones de monturas desconocidas", -- Needs review
				DisableUpdateNotices = "Desactivar notificaciones de actualizaciones", -- Needs review
				-- DruidFlightPreference = "",
				DruidSingleClick = "Un click en mayúsculas (shift) para las formas de viaje", -- Needs review
				EnableAutoDismount = "Activar desmonte automático", -- Needs review
				Favorites = "Favoritos", -- Needs review
				GlobalFavorites = "Favoritos Globales", -- Needs review
				GlobalPreferences = "Preferencias Globales", -- Needs review
				NewVersionFound = "Una nueva actualización de GoGoMount está disponible y es usada por ", -- Needs review
				UnknownMountFound = "Una montura desconocida ha sido encontrada en la lista de tus monturas. Por favor, reporte esto para que pueda ser añadido en futuras versiones de GoGoMount.", -- Needs review
			},
			Talent = {
				AncestralSwiftness = "Presteza ancestral", -- Needs review
				FeralSwiftness = "Presteza feral", -- Needs review
			},
			Zone = {
				AQ40 = "Templo de Ahn'Qiraj", -- Needs review
				-- CrumblingDepths = "",
				Dalaran = "Dalaran", -- Needs review
				-- Deepholm = "",
				DireMaul = "La Masacre", -- Needs review
				Icecrown = "Corona de Hielo", -- Needs review
				Ironforge = "Forjaz", -- Needs review
				KrasusLanding = "Alto de Kraus", -- Needs review
				SholazarBasin = "Cuenca de Sholazar", -- Needs review
				-- TempleOfEarth = "",
				TheFrozenSea = "El Mar Gélido", -- Needs review
				TheOculus = "El Oculus", -- Needs review
				TheStormPeaks = "Las Cumbres Tormentosas", -- Needs review
				TheUnderbelly = "Los Bajos Fondos", -- Needs review
				TheVioletCitadel = "La Ciudadela Violeta", -- Needs review
				-- TolBaradPeninsula = "",
				TwistingNether = "El Vacío Abisal", -- Needs review
				-- Vashjir = "",
				Wintergrasp = "Conquista del Invierno", -- Needs review
			},
}
end --if
