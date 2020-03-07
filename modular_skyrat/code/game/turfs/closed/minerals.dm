/turf/closed/mineral/random/high_chance/snow
	name = "snowy mountainside"
	icon = 'modular_skyrat/icons/turf/mining.dmi'
	smooth_icon = 'modular_skyrat/icons/turf/walls/mountain_wall.dmi'
	icon_state = "mountainrock"
	smooth = SMOOTH_MORE|SMOOTH_BORDER
	canSmoothWith = list (/turf/closed)
	defer_change = TRUE
	environment_type = "snow"
	turf_type = /turf/open/floor/plating/asteroid/snow/icemoon
	baseturfs = /turf/open/floor/plating/asteroid/snow/icemoon
	initial_gas_mix = ICEMOON_DEFAULT_ATMOS
	mineralSpawnChanceList = list(
		/turf/closed/mineral/uranium/ice/icemoon = 35, /turf/closed/mineral/diamond/ice/icemoon = 30, /turf/closed/mineral/gold/ice/icemoon = 45, /turf/closed/mineral/titanium/ice/icemoon = 45,
		/turf/closed/mineral/silver/ice/icemoon = 50, /turf/closed/mineral/plasma/ice/icemoon = 50, /turf/closed/mineral/bscrystal/ice/icemoon = 20)

/turf/closed/mineral/random/snow
	name = "snowy mountainside"
	icon = 'modular_skyrat/icons/turf/mining.dmi'
	smooth_icon = 'modular_skyrat/icons/turf/walls/mountain_wall.dmi'
	icon_state = "mountainrock"
	smooth = SMOOTH_MORE|SMOOTH_BORDER
	canSmoothWith = list (/turf/closed)
	defer_change = TRUE
	environment_type = "snow"
	turf_type = /turf/open/floor/plating/asteroid/snow/icemoon
	baseturfs = /turf/open/floor/plating/asteroid/snow/icemoon
	initial_gas_mix = ICEMOON_DEFAULT_ATMOS

	mineralChance = 10
	mineralSpawnChanceList = list(
		/turf/closed/mineral/uranium/ice/icemoon = 5, /turf/closed/mineral/diamond/ice/icemoon = 1, /turf/closed/mineral/gold/ice/icemoon = 10, /turf/closed/mineral/titanium/ice/icemoon = 11,
		/turf/closed/mineral/silver/ice/icemoon = 12, /turf/closed/mineral/plasma/ice/icemoon = 20, /turf/closed/mineral/iron/ice/icemoon = 40,
		/turf/closed/mineral/gibtonite/ice/icemoon = 4, /turf/open/floor/plating/asteroid/airless/cave/snow = 1, /turf/closed/mineral/bscrystal/ice/icemoon = 1)

/turf/closed/mineral/random/snow/no_caves
	mineralSpawnChanceList = list(
		/turf/closed/mineral/uranium/ice/icemoon = 5, /turf/closed/mineral/diamond/ice/icemoon = 1, /turf/closed/mineral/gold/ice/icemoon = 10, /turf/closed/mineral/titanium/ice/icemoon = 11,
		/turf/closed/mineral/silver/ice/icemoon = 12, /turf/closed/mineral/plasma/ice/icemoon = 20, /turf/closed/mineral/iron/ice/icemoon = 40,
		/turf/closed/mineral/gibtonite/ice/icemoon = 4, /turf/closed/mineral/bscrystal/ice/icemoon = 1)

/turf/closed/mineral/random/snow/underground
	mineralSpawnChanceList = list(
		/turf/closed/mineral/uranium/ice/icemoon = 5, /turf/closed/mineral/diamond/ice/icemoon = 1, /turf/closed/mineral/gold/ice/icemoon = 10, /turf/closed/mineral/titanium/ice/icemoon = 11,
		/turf/closed/mineral/silver/ice/icemoon = 12, /turf/closed/mineral/plasma/ice/icemoon = 20, /turf/closed/mineral/iron/ice/icemoon = 40,
		/turf/closed/mineral/gibtonite/ice/icemoon = 4, /turf/open/floor/plating/asteroid/airless/cave/snow/underground = 1, /turf/closed/mineral/bscrystal/ice/icemoon = 1)

/turf/closed/mineral/random/labormineral/ice
	name = "snowy mountainside"
	icon = 'modular_skyrat/icons/turf/mining.dmi'
	smooth_icon = 'modular_skyrat/icons/turf/walls/mountain_wall.dmi'
	icon_state = "mountainrock"
	smooth = SMOOTH_MORE|SMOOTH_BORDER
	canSmoothWith = list (/turf/closed)
	defer_change = TRUE
	environment_type = "snow"
	turf_type = /turf/open/floor/plating/asteroid/snow/icemoon
	baseturfs = /turf/open/floor/plating/asteroid/snow/icemoon
	initial_gas_mix = ICEMOON_DEFAULT_ATMOS

	defer_change = TRUE
	mineralSpawnChanceList = list(
		/turf/closed/mineral/uranium/ice/icemoon = 3, /turf/closed/mineral/diamond/ice/icemoon = 1, /turf/closed/mineral/gold/ice/icemoon = 8, /turf/closed/mineral/titanium/ice/icemoon = 8,
		/turf/closed/mineral/silver/ice/icemoon = 20, /turf/closed/mineral/plasma/ice/icemoon = 30, /turf/closed/mineral/bscrystal/ice/icemoon = 1, /turf/closed/mineral/gibtonite/ice/icemoon = 2,
		/turf/closed/mineral/iron/ice/icemoon = 95)

/turf/closed/mineral/iron/ice/icemoon
	turf_type = /turf/open/floor/plating/asteroid/snow/ice/icemoon
	baseturfs = /turf/open/floor/plating/asteroid/snow/ice/icemoon
	initial_gas_mix = ICEMOON_DEFAULT_ATMOS

/turf/closed/mineral/uranium/ice
	environment_type = "snow_cavern"
	icon_state = "icerock_Uranium"
	smooth_icon = 'modular_skyrat/icons/turf/walls/icerock_wall.dmi'
	turf_type = /turf/open/floor/plating/asteroid/snow/ice
	baseturfs = /turf/open/floor/plating/asteroid/snow/ice
	initial_gas_mix = FROZEN_ATMOS
	defer_change = TRUE

/turf/closed/mineral/uranium/ice/icemoon
	turf_type = /turf/open/floor/plating/asteroid/snow/ice/icemoon
	baseturfs = /turf/open/floor/plating/asteroid/snow/ice/icemoon
	initial_gas_mix = ICEMOON_DEFAULT_ATMOS

/turf/closed/mineral/diamond/ice/icemoon
	turf_type = /turf/open/floor/plating/asteroid/snow/ice/icemoon
	baseturfs = /turf/open/floor/plating/asteroid/snow/ice/icemoon
	initial_gas_mix = ICEMOON_DEFAULT_ATMOS

/turf/closed/mineral/gold/ice
	environment_type = "snow_cavern"
	icon_state = "icerock_gold"
	smooth_icon = 'modular_skyrat/icons/turf/walls/icerock_wall.dmi'
	turf_type = /turf/open/floor/plating/asteroid/snow/ice
	baseturfs = /turf/open/floor/plating/asteroid/snow/ice
	initial_gas_mix = FROZEN_ATMOS
	defer_change = TRUE

/turf/closed/mineral/gold/ice/icemoon
	turf_type = /turf/open/floor/plating/asteroid/snow/ice/icemoon
	baseturfs = /turf/open/floor/plating/asteroid/snow/ice/icemoon
	initial_gas_mix = ICEMOON_DEFAULT_ATMOS

/turf/closed/mineral/silver/ice
	environment_type = "snow_cavern"
	icon_state = "icerock_silver"
	smooth_icon = 'modular_skyrat/icons/turf/walls/icerock_wall.dmi'
	turf_type = /turf/open/floor/plating/asteroid/snow/ice
	baseturfs = /turf/open/floor/plating/asteroid/snow/ice
	initial_gas_mix = FROZEN_ATMOS
	defer_change = TRUE

/turf/closed/mineral/silver/ice/icemoon
	turf_type = /turf/open/floor/plating/asteroid/snow/ice/icemoon
	baseturfs = /turf/open/floor/plating/asteroid/snow/ice/icemoon
	initial_gas_mix = ICEMOON_DEFAULT_ATMOS

/turf/closed/mineral/titanium/ice
	environment_type = "snow_cavern"
	icon_state = "icerock_titanium"
	smooth_icon = 'modular_skyrat/icons/turf/walls/icerock_wall.dmi'
	turf_type = /turf/open/floor/plating/asteroid/snow/ice
	baseturfs = /turf/open/floor/plating/asteroid/snow/ice
	initial_gas_mix = FROZEN_ATMOS
	defer_change = TRUE

/turf/closed/mineral/titanium/ice/icemoon
	turf_type = /turf/open/floor/plating/asteroid/snow/ice/icemoon
	baseturfs = /turf/open/floor/plating/asteroid/snow/ice/icemoon
	initial_gas_mix = ICEMOON_DEFAULT_ATMOS

/turf/closed/mineral/plasma/ice/icemoon
	turf_type = /turf/open/floor/plating/asteroid/snow/ice/icemoon
	baseturfs = /turf/open/floor/plating/asteroid/snow/ice/icemoon
	initial_gas_mix = ICEMOON_DEFAULT_ATMOS

/turf/closed/mineral/bananium/ice
	environment_type = "snow_cavern"
	icon_state = "icerock_Bananium"
	smooth_icon = 'modular_skyrat/icons/turf/walls/icerock_wall.dmi'
	turf_type = /turf/open/floor/plating/asteroid/snow/ice
	baseturfs = /turf/open/floor/plating/asteroid/snow/ice
	initial_gas_mix = FROZEN_ATMOS
	defer_change = TRUE

/turf/closed/mineral/bananium/ice/icemoon
	turf_type = /turf/open/floor/plating/asteroid/snow/ice/icemoon
	baseturfs = /turf/open/floor/plating/asteroid/snow/ice/icemoon
	initial_gas_mix = ICEMOON_DEFAULT_ATMOS

/turf/closed/mineral/bscrystal/ice
	environment_type = "snow_cavern"
	icon_state = "icerock_BScrystal"
	smooth_icon = 'modular_skyrat/icons/turf/walls/icerock_wall.dmi'
	turf_type = /turf/open/floor/plating/asteroid/snow/ice
	baseturfs = /turf/open/floor/plating/asteroid/snow/ice
	initial_gas_mix = FROZEN_ATMOS
	defer_change = TRUE

/turf/closed/mineral/bscrystal/ice/icemoon
	turf_type = /turf/open/floor/plating/asteroid/snow/ice/icemoon
	baseturfs = /turf/open/floor/plating/asteroid/snow/ice/icemoon
	initial_gas_mix = ICEMOON_DEFAULT_ATMOS

/turf/closed/mineral/snowmountain/icemoon
	turf_type = /turf/open/floor/plating/asteroid/snow/icemoon
	baseturfs = /turf/open/floor/plating/asteroid/snow/icemoon
	initial_gas_mix = ICEMOON_DEFAULT_ATMOS

/turf/closed/mineral/snowmountain/cavern/icemoon
	baseturfs = /turf/open/floor/plating/asteroid/snow/ice/icemoon
	turf_type = /turf/open/floor/plating/asteroid/snow/ice/icemoon
	initial_gas_mix = ICEMOON_DEFAULT_ATMOS

/turf/closed/mineral/gibtonite/ice
	environment_type = "snow_cavern"
	icon_state = "icerock_Gibtonite"
	smooth_icon = 'modular_skyrat/icons/turf/walls/icerock_wall.dmi'
	turf_type = /turf/open/floor/plating/asteroid/snow/ice
	baseturfs = /turf/open/floor/plating/asteroid/snow/ice
	initial_gas_mix = FROZEN_ATMOS
	defer_change = TRUE

/turf/closed/mineral/gibtonite/ice/icemoon
	turf_type = /turf/open/floor/plating/asteroid/snow/ice/icemoon
	baseturfs = /turf/open/floor/plating/asteroid/snow/ice/icemoon
	initial_gas_mix = ICEMOON_DEFAULT_ATMOS