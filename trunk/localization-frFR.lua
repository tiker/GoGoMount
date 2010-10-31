if GetLocale() == "frFR" then
	BINDING_HEADER_GOGOHEADER = "GoGoMount" -- Needs review
	BINDING_NAME_GOGOBINDING = "Monter/descendre de la monture" -- Needs review
	BINDING_NAME_GOGOBINDING2 = "Monter/descendre de la monture non volante" -- Needs review
	BINDING_NAME_GOGOBINDING3 = "Monter/descendre de la monture à passager" -- Needs review
	GoGo_Variables.Localize = {
			Skill = {
				Engineering = "Ingénierie", -- Needs review
				Riding = "Monte", -- Needs review
				Tailoring = "Couture", -- Needs review
			},
			String = {
				CurrentZoneFavorites = "Favoris de la zone actuelle", -- Needs review
				DisableUnknownMountNotices = "Désactiver les annonces de monture inconnue", -- Needs review
				DisableUpdateNotices = "Désactiver les annonces de mise à jour", -- Needs review
				-- DruidFlightPreference = "",
				DruidSingleClick = "Clic pour passer à la monture suivante", -- Needs review
				EnableAutoDismount = "Activer la descente de monture automatique", -- Needs review
				Favorites = "Favoris", -- Needs review
				GlobalFavorites = "Favoris globaux", -- Needs review
				GlobalPreferences = "Préférences globales", -- Needs review
				NewVersionFound = "Une mise à jour de GoGoMount est disponible et est utilisée par", -- Needs review
				UnknownMountFound = "Une monture inconnue a été trouvée dans votre liste. Veuillez la communiquer afin qu'elle soit ajoutée à une future version de GoGoMount", -- Needs review
			},
			Talent = {
				AncestralSwiftness = "Rapidité ancestrale", -- Needs review
				FeralSwiftness = "Célérité farouche", -- Needs review
			},
			Zone = {
				AQ40 = "Temple d'Ahn'Qiraj", -- Needs review
				-- CrumblingDepths = "",
				Dalaran = "Dalaran", -- Needs review
				-- Deepholm = "",
				DireMaul = "Hache-Tripes", -- Needs review
				Icecrown = "La Couronne de glace", -- Needs review
				Ironforge = "Forgefer", -- Needs review
				KrasusLanding = "Aire de Krasus", -- Needs review
				SholazarBasin = "Bassin de Sholazar", -- Needs review
				-- TempleOfEarth = "",
				TheFrozenSea = "La mer Gelée", -- Needs review
				TheOculus = "L'Oculus", -- Needs review
				TheStormPeaks = "Les pics Foudroyés", -- Needs review
				TheUnderbelly = "Les Entrailles", -- Needs review
				TheVioletCitadel = "Citadelle Pourpre", -- Needs review
				-- TolBaradPeninsula = "",
				TwistingNether = "Le Néant distordu", -- Needs review
				-- Vashjir = "",
				Wintergrasp = "Joug-d'hiver", -- Needs review
			},
	}
end --if