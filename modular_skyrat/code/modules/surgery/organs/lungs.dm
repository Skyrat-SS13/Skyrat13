/obj/item/organ/lungs/robot_ipc
	name = "heat sink"
	desc = "A device that transfers generated heat to a fluid medium to cool it down. Required to keep your synthetics cool-headed. It's shape resembles lungs." //Purposefully left the 'fluid medium' ambigious for interpretation of the character, whether it be air or fluid cooling
	icon_state = "lungs-c"
	safe_oxygen_min = 0	//What are you doing man, dont breathe with those!
	safe_oxygen_max = 0
	status = ORGAN_ROBOTIC
	organ_flags = ORGAN_SYNTHETIC

/obj/item/organ/lungs/robot_ipc/emp_act(severity) //Should probably put it somewhere else later
	. = ..()
	if(. & EMP_PROTECT_SELF)
		return
	switch(severity)
		if(1)
			to_chat(owner, "<span class='warning'>Alert: Critical cooling system failure!</span>")
			owner.adjust_bodytemperature(100*TEMPERATURE_DAMAGE_COEFFICIENT)
		if(2)
			owner.adjust_bodytemperature(30*TEMPERATURE_DAMAGE_COEFFICIENT)

/obj/item/organ/lungs/fakedemon
	name = "lesser demonic lungs"
	desc = "Breathe and air, until it is done."
	icon = 'modular_Skyrat/icons/obj/surgery.dmi'
	icon_state = "lungs-demon"
	safe_oxygen_min = 0
	safe_oxygen_max = 2.5
	safe_co2_min = 16
	safe_co2_max = 100
	cold_level_1_threshold = 273.15
	cold_level_2_threshold = 240
	cold_level_3_threshold = 200
	heat_level_1_threshold = 600
	heat_level_2_threshold = 1000
	heat_level_3_threshold = 1500
	oxy_damage_type = TOX
	cold_damage_type = BURN
	heat_damage_type = BURN
	crit_stabilizing_reagent = /datum/reagent/fuel
	food_reagents = list(/datum/reagent/blood = 10, /datum/reagent/consumable/nutriment = 5, /datum/reagent/fuel/unholywater = 5)

/obj/item/organ/lungs/fakedemon/check_breath(datum/gas_mixture/breath, mob/living/carbon/human/H)
	. = ..()
	var/list/breath_gases = breath.gases
	var/O2_pp = breath.get_breath_partial_pressure(breath_gases[/datum/gas/oxygen])+(8*breath.get_breath_partial_pressure(breath_gases[/datum/gas/pluoxium]))
	var/CO2_pp = breath.get_breath_partial_pressure(breath_gases[/datum/gas/carbon_dioxide])
	if(O2_pp >= safe_oxygen_max)
		owner?.reagents?.add_reagent(/datum/reagent/fuel, O2_pp * 0.01)
		owner?.IgniteMob()
	if(CO2_pp >= safe_co2_max * 0.35)
		owner?.reagents?.add_reagent(/datum/reagent/medicine/omnizine, CO2_pp * 0.05)
