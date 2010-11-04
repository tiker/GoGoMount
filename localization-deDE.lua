if GetLocale() == "deDE" then
	BINDING_HEADER_GOGOHEADER = "GoGoMount"
	BINDING_NAME_GOGOBINDING = "Aufsitzen/Absitzen"
	BINDING_NAME_GOGOBINDING2 = "Aufsitzen/Absitzen (nicht fliegend)"
	BINDING_NAME_GOGOBINDING3 = "Aufsitzen/Absitzen bei Fahrgast-Mounts"
	GoGo_Variables.Localize = {
			Skill = {
				Engineering = "Ingenieurskunst",
				Riding = "Reiten",
				Tailoring = "Schneiderei",
			},
			String = {
				AutomaticallyRemoveBuffs = "Zauber, die das Aufsitzen verhindern, automatisch entfernen",
				CurrentZoneFavorites = "Favoriten der aktuellen Zone",
				DisableUnknownMountNotices = "Mitteilungen über unbekannte Reittiere ausschalten",
				DisableUpdateNotices = "Aktualisierungsnachrichten ausschalten",
				DruidFlightPreference = "Immer Flugformen verwenden, ausser bei reiner Bewegung",
				DruidOptions = "Druiden-Optionen",
				DruidSingleClick = "Einfacher Klick für den Wechsel in Reisegestalten",
				EnableAutoDismount = "Automatisches Absitzen aktivieren",
				Favorites = "Favoriten",
				GlobalFavorites = "Globale Favoriten",
				GlobalPreferences = "Globale Präferenzen",
				HunterOptions = "Jäger-Optionen",
				NewVersionFound = "Eine aktualisierte Version von GoGoMount ist verfügbar und wird verwendet von ",
				NoShapeInRandom = "Zufallsgeneration bei Gestaltwandelformen nicht gemeinsam mit Reittieren anwenden.",
				UnknownMountFound = "Ein unbekanntes Reittier wurde in deiner Liste entdeckt. Bitte melde es, damit es in zukünftige Versionen von GoGoMount integriert werden kann.",
				UseAspectOfThePackInstead = "Aspekt des Rudels statt Aspekt des Geparden verwenden",
			},
			Talent = {
				AncestralSwiftness = "Schnelligkeit der Ahnen",
				FeralSwiftness = "Schnelligkeit der Wildnis",
			},
			Zone = {
				AQ40 = "Tempel von Ahn'Qiraj",
				CrumblingDepths = "Bröselnde Tiefen",
				Dalaran = "Dalaran",
				Deepholm = "Tiefenheim",
				DireMaul = "Düsterbruch",
				Icecrown = "Eiskrone",
				Ironforge = "Eisenschmiede",
				KrasusLanding = "Krasus' Landeplatz",
				SholazarBasin = "Sholazarbecken",
				TempleOfEarth = "Tempel der Erde",
				TheFrozenSea = "Die gefrorene See",
				TheOculus = "Das Oculus",
				TheStormPeaks = "Die Sturmgipfel",
				TheUnderbelly = "Die Schattenseite",
				TheVioletCitadel = "Die Violette Zitadelle",
				TolBaradPeninsula = "Tol Barad Halbinsel",
				TwistingNether = "Wirbelnder Nether",
				Vashjir = "Vashj'ir",
				Wintergrasp = "Tausendwintersee",
			},
}
end --if