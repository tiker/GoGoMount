if GetLocale() == "frFR" then
	BINDING_HEADER_GOGOHEADER = "GoGoMount" -- Needs review
	BINDING_NAME_GOGOBINDING = "Monter/descendre de la monture" -- Needs review
	BINDING_NAME_GOGOBINDING2 = "Monter/descendre de la monture non volante" -- Needs review
	BINDING_NAME_GOGOBINDING3 = "Monter/descendre de la monture � passager" -- Needs review
	GoGo_Variables.Localize = {
			Skill = {
				Engineering = "Ing�nierie", -- Needs review
				Riding = "Monte", -- Needs review
				Tailoring = "Couture", -- Needs review
			},
			String = {
				CurrentZoneFavorites = "Favoris de la zone actuelle", -- Needs review
				DisableUnknownMountNotices = "D�sactiver les annonces de monture inconnue", -- Needs review
				DisableUpdateNotices = "D�sactiver les annonces de mise � jour", -- Needs review
				-- DruidFlightPreference = "",
				DruidSingleClick = "Clic pour passer � la monture suivante", -- Needs review
				EnableAutoDismount = "Activer la descente de monture automatique", -- Needs review
				Favorites = "Favoris", -- Needs review
				GlobalFavorites = "Favoris globaux", -- Needs review
				GlobalPreferences = "Pr�f�rences globales", -- Needs review
				NewVersionFound = "Une mise � jour de GoGoMount est disponible et est utilis�e par", -- Needs review
				UnknownMountFound = "Une monture inconnue a �t� trouv�e dans votre liste. Veuillez la communiquer afin qu'elle soit ajout�e � une future version de GoGoMount", -- Needs review
			},
			Talent = {
				AncestralSwiftness = "Rapidit� ancestrale", -- Needs review
				FeralSwiftness = "C�l�rit� farouche", -- Needs review
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
				TheFrozenSea = "La mer Gel�e", -- Needs review
				TheOculus = "L'Oculus", -- Needs review
				TheStormPeaks = "Les pics Foudroy�s", -- Needs review
				TheUnderbelly = "Les Entrailles", -- Needs review
				TheVioletCitadel = "Citadelle Pourpre", -- Needs review
				-- TolBaradPeninsula = "",
				TwistingNether = "Le N�ant distordu", -- Needs review
				-- Vashjir = "",
				Wintergrasp = "Joug-d'hiver", -- Needs review
			},
	}
end --if