if GetLocale() == "koKR" then
	BINDING_HEADER_GOGOHEADER = "GoGoMount" -- Needs review
	BINDING_NAME_GOGOBINDING = "타기/내리기" -- Needs review
	BINDING_NAME_GOGOBINDING2 = "타기/내리기 (나는 탈것 제외)" -- Needs review
	BINDING_NAME_GOGOBINDING3 = "2인승 탈것 타기/내리기" -- Needs review
	GoGo_Variables.Localize = {
			Skill = {
				Engineering = "기계공학", -- Needs review
				Riding = "탈것 타기", -- Needs review
				Tailoring = "재봉술", -- Needs review
			},
			String = {
				AutomaticallyRemoveBuffs = "자동으로 탈것 버프를 삭제합니다.",
				Clear = "제거",
				ClearGlobalFavoriteMounts = "즐겨찾기 탈것을 제거합니다.",
				CurrentZoneFavorites = "현재 지역 즐겨찾기", -- Needs review
				DisableFlyingFromWater = "Disable flying from water", -- Requires localization
				DisableUnknownMountNotices = "알 수 없는 탈것 안내 사용 중지", -- Needs review
				DisableUpdateNotices = "업데이트 안내 사용 중지", -- Needs review
				DruidFlightPreference = "항상 움직일때 비행 형태의 변신 사용", -- Needs review
				DruidOptions = "드루이드 옵션",
				DruidSingleClick = "변신 상태에서 다른 변신 형태로 한번의 클릭으로 변경", -- Needs review
				EnableAutoDismount = "자동 탈것 내리기 사용", -- Needs review
				Favorites = "즐겨찾기", -- Needs review
				GlobalFavorites = "일반적인 즐겨찾기", -- Needs review
				GlobalPreferences = "일반 설정", -- Needs review
				HunterOptions = "사냥꾼 옵션",
				NewVersionFound = "GoGoMount 업데이트가 가능하고 사용됩니다. ", -- Needs review
				NoShapeInRandom = "Do not randomize shape forms with mounts", -- Requires localization
				UnknownMountFound = "알 수 없는 탈것이 당신의 목록에서 발견되었습니다. 이것을 GoGoMount의 다음 버전에 추가될 수 있도록 알리십시오.", -- Needs review
				UseAspectOfThePackInstead = "치타의 상 대신 치타 무리의 상을 사용합니다.",
			},
			Talent = {
				AncestralSwiftness = "고대의 신속함",
				FeralSwiftness = "야생의 기민함", -- Needs review
			},
			Zone = {
				AQ40 = "안퀴라즈 사원", -- Needs review
				AbyssalDepths = "Abyssal Depths", -- Requires localization
				CrumblingDepths = "무너지는 심연",
				Dalaran = "달라란", -- Needs review
				DarkbreakCove = "Darkbreak Cove", -- Requires localization
				Deepholm = "심연의 영지",
				DireMaul = "혈투의 전장",
				Icecrown = "얼음왕관", -- Needs review
				Ironforge = "아이언포지",
				KrasusLanding = "크라서스 착륙장", -- Needs review
				LegionsRest = "Legion's Rest", -- Requires localization
				Lghorek = "L'ghorek", -- Requires localization
				Nespirah = "네스피라",
				ShimmeringExpanse = "흐린빛 벌판",
				SholazarBasin = "숄라자르 분지", -- Needs review
				SilverTideHollow = "은빛 너울 동굴",
				TempleOfEarth = "대지의 신전",
				TenebrousCavern = "Tenebrous Cavern", -- Requires localization
				TheFrozenSea = "얼어붙은 바다", -- Needs review
				TheOculus = "마력의 눈", -- Needs review
				TheStormPeaks = "폭풍우 봉우리", -- Needs review
				TheTempleOfAtalHakkar = "아탈학카르 신전",
				TheUnderbelly = "마법의 뒤안길", -- Needs review
				TheVioletCitadel = "보랏빛 성채", -- Needs review
				TheVortexPinnacle = "The Vortex Pinnacle", -- Requires localization
				TolBarad = "톨 바라드",
				TolBaradPeninsula = "톨 바라드 반도",
				TwistingNether = "뒤틀린 황천", -- Needs review
				Vashjir = "바쉬르",
				Wintergrasp = "겨울손아귀 호수", -- Needs review
			},
}
end --if