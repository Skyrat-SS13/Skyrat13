
/obj/item/organ/lungs/ashwalker
	name = "ash lungs"
	desc = "blackened lungs identical from specimens recovered from lavaland, unsuited to higher air pressures."
	icon_state = "lungs-ll"
	safe_oxygen_min = 3	//able to handle much thinner oxygen, something something ash storm adaptation
	safe_oxygen_max = 18 // Air standard is 22kpA of O2, LL is 14kpA
	safe_nitro_max = 28 // Air standard is 82kpA of N2, LL is 23kpA

	cold_level_1_threshold = 280 // Ash Lizards can't take the cold very well, station air is only just warm enough
	cold_level_2_threshold = 240
	cold_level_3_threshold = 200

	heat_level_1_threshold = 400 // better adapted for heat, obv. Lavaland standard is 300
	heat_level_2_threshold = 600 // up 200 from level 1, 1000 is silly but w/e for level 3
