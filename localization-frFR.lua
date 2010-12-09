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
				Clear = "Effacer",
				ClearGlobalFavoriteMounts = "Effacer les montures favorites globales",
				CurrentZoneFavorites = "Favoris de la zone actuelle",
				DisableUnknownMountNotices = "Désactiver les annonces de monture inconnue",
				DisableUpdateNotices = "Désactiver les annonces de mise à jour",
				DruidFlightPreference = "Toujours utiliser la forme de vol même sans se déplacer",
				DruidOptions = "Options pour Druides",
				DruidSingleClick = "Passer d'une forme à une forme de voyage en un seul clic",
				EnableAutoDismount = "Activer la descente de monture automatique",
				Favorites = "Favoris",
				GlobalFavorites = "Favoris globaux",
				GlobalPreferences = "Préférences globales",
				HunterOptions = "Options pour Chasseurs",
				NewVersionFound = "Une nouvelle version de GoGoMount est disponible",
				NoShapeInRandom = "Ne pas randomiser les formes avec les montures",
				UnknownMountFound = "Une monture inconnue a été trouvée. Communiquez-le pour l'ajouter à une future version de GoGoMount.",
				UseAspectOfThePackInstead = "Utiliser Aspect de la meute au lieu d'Aspect du guépard",
			},
			Talent = {
				AncestralSwiftness = "Rapidité ancestrale",
				FeralSwiftness = "Célérité farouche",
			},
			Zone = {
				AQ40 = "Temple d'Ahn'Qiraj",
				CrumblingDepths = "Crumbling Depths", -- Needs review
				Dalaran = "Dalaran",
				Deepholm = "Le Tréfonds ", -- Needs review
				DireMaul = "Hache-Tripes",
				Icecrown = "La Couronne de glace",
				Ironforge = "Forgefer",
				KrasusLanding = "Aire de Krasus",
				ShimmeringExpanse = "Étendues Chatoyantes",
				SholazarBasin = "Bassin de Sholazar",
				SilverTideHollow = "Creux des Flots argentés",
				TempleOfEarth = "Temple de la Terre", -- Needs review
				TheFrozenSea = "La mer Gelée",
				TheOculus = "L'Oculus",
				TheStormPeaks = "Les pics Foudroyés",
				TheTempleOfAtalHakkar = "Le temple d'Atal'Hakkar",
				TheUnderbelly = "Les Entrailles",
				TheVioletCitadel = "Citadelle Pourpre",
				TolBarad = "Tol Barad", -- Needs review
				TolBaradPeninsula = "Péninsule de Tol Barad", -- Needs review
				TwistingNether = "Le Néant distordu",
				Vashjir = "Vashj'ir", -- Needs review
				Wintergrasp = "Joug-d'hiver",
			},
}
end --if