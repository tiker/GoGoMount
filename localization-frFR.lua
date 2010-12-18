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
				DisableFlyingFromWater = "Disable flying from water", -- Requires localization
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
				RemoveBuffs = "Remove buffs that can prevent mounting", -- Requires localization
				UnknownMountFound = "Une monture inconnue a été trouvée. Communiquez-le pour l'ajouter à une future version de GoGoMount.",
				UseAspectOfThePackInstead = "Utiliser Aspect de la meute au lieu d'Aspect du guépard",
			},
			Talent = {
				AncestralSwiftness = "Rapidité ancestrale",
				FeralSwiftness = "Célérité farouche",
			},
			Zone = {
				AQ40 = "Temple d'Ahn'Qiraj",
				AbyssalDepths = "Profondeurs Abyssales",
				CrumblingDepths = "Les profondeurs Désagrégées",
				Dalaran = "Dalaran",
				DarkbreakCove = "Crique du Sombre brisant",
				Deepholm = "Le Tréfonds ",
				DireMaul = "Hache-Tripes",
				Icecrown = "La Couronne de glace",
				Ironforge = "Forgefer",
				KrasusLanding = "Aire de Krasus",
				LegionsRest = "Le Repos de la Légion",
				Lghorek = "L'ghorek",
				Nespirah = "Nespirah",
				ShimmeringExpanse = "Étendues Chatoyantes",
				SholazarBasin = "Bassin de Sholazar",
				SilverTideHollow = "Creux des Flots argentés",
				TempleOfEarth = "Temple de la Terre",
				TenebrousCavern = "Caverne Ténébreuse",
				TheCerebrillum = "The Cerebrillum", -- Requires localization
				TheFrozenSea = "La mer Gelée",
				TheOculus = "L'Oculus",
				TheStormPeaks = "Les pics Foudroyés",
				TheTempleOfAtalHakkar = "Le temple d'Atal'Hakkar",
				TheUnderbelly = "Les Entrailles",
				TheVioletCitadel = "Citadelle Pourpre",
				TheVortexPinnacle = "La cime du Vortex",
				TolBarad = "Tol Barad",
				TolBaradPeninsula = "Péninsule de Tol Barad",
				TwistingNether = "Le Néant distordu",
				Vashjir = "Vashj'ir",
				Wintergrasp = "Joug-d'hiver",
			},
}
end --if