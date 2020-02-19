/obj/item/organ/lungs/vox
	name = "vox lungs"
	desc = "They're filled with dust... wow."
	icon_state = "lungs-c"
	safe_oxygen_min = 0	//Dont need oxygen
	safe_oxygen_max = 2 //But it is quite toxic to them
	safe_nitro_min = 16 // Atleast 16 nitrogen, no upper cap
	oxy_damage_type = TOX 
	oxy_breath_dam_min = 6
	oxy_breath_dam_max = 20

	cold_level_1_threshold = 0 // Vox should be able to breathe in cold gas without issues?
	cold_level_2_threshold = 0
	cold_level_3_threshold = 0