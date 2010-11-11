if GetLocale() == "frFR" then
	BINDING_HEADER_GOGOHEADER = "GoGoMount"
	BINDING_NAME_GOGOBINDING = "Monter/descendre de monture"
	BINDING_NAME_GOGOBINDING2 = "Monter/descendre de monture (non volante)"
	BINDING_NAME_GOGOBINDING3 = "Monter/descendre de monture avec passager"
	GoGo_Variables.Localize = {
			Skill = {
				Engineering = "Ingénierie",
				Riding = "Monte",
				Tailoring = "Couture",
			},
			String = {
				AutomaticallyRemoveBuffs = "Supprimer automatiquement les buffs qui empêchent les montures",
				CurrentZoneFavorites = "Favoris de la zone actuelle",
				DisableUnknownMountNotices = "Désactiver les annonces de monture inconnue",
				DisableUpdateNotices = "Désactiver les annonces de mise à jour",
				DruidFlightPreference = "Always use flight forms instead of when moving only", -- Requires localization
				DruidOptions = "Options pour Druides",
				DruidSingleClick = "Passer d'une forme à une forme de voyage en un seul clic",
				EnableAutoDismount = "Activer la descente de monture automatique",
				Favorites = "Favoris",
				GlobalFavorites = "Favoris globaux",
				GlobalPreferences = "Préférences globales",
				HunterOptions = "Options pour Chasseurs",
				NewVersionFound = "Une nouvelle version de GoGoMount est disponible",
				NoShapeInRandom = "Do not randomize shape forms with mounts", -- Requires localization
				UnknownMountFound = "Une monture inconnue a été trouvée dans votre liste. Veuillez la communiquer afin qu'elle soit ajoutée à une future version de GoGoMount",
				UseAspectOfThePackInstead = "Utiliser Aspect de la meute au lieu d'Aspect du guépard",
			},
			Talent = {
				AncestralSwiftness = "Rapidité ancestrale",
				FeralSwiftness = "Célérité farouche",
			},
			Zone = {
				AQ40 = "Temple d'Ahn'Qiraj", -- Needs review
				CrumblingDepths = "Crumbling Depths", -- Requires localization
				Dalaran = "Dalaran",
				Deepholm = "Deepholm", -- Requires localization
				DireMaul = "Hache-Tripes", -- Needs review
				Icecrown = "La Couronne de glace",
				Ironforge = "Forgefer",
				KrasusLanding = "Aire de Krasus", -- Needs review
				SholazarBasin = "Bassin de Sholazar", -- Needs review
				TempleOfEarth = "Temple of Earth", -- Requires localization
				TheFrozenSea = "La mer Gelée", -- Needs review
				TheOculus = "L'Oculus", -- Needs review
				TheStormPeaks = "Les pics Foudroyés",
				TheTempleOfAtalHakkar = "The Temple of Atal'Hakkar", -- Requires localization
				TheUnderbelly = "Les Entrailles", -- Needs review
				TheVioletCitadel = "Citadelle Pourpre", -- Needs review
				TolBarad = "Tol Barad", -- Requires localization
				TolBaradPeninsula = "Tol Barad Peninsula", -- Requires localization
				TwistingNether = "Le Néant distordu", -- Needs review
				Vashjir = "Vashj'ir", -- Requires localization
				Wintergrasp = "Joug-d'hiver",
			},
}
end --if