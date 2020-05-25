//maint energy and subtypes
/datum/reagent/consumable/maint_energy
	name = "Maintenance Energy"
	description = "Assistant's favorite energy drink."
	nutriment_factor = 0.5 * REAGENTS_METABOLISM //the original flavor, now with 0% less sugar.
	color = "#00014d60"
	taste_description = "raw energy"
	glass_icon_state = null
	pH = 5 //slightly acidic
	glass_name = "glass of Maintenance Energy"
	glass_desc = "Unleash the tide."
	var/list/healed_roles = list("Assistant")
	var/heal_amount = 0.20

/datum/reagent/consumable/maint_energy/on_mob_add(mob/living/L, amount)
	. = ..()
	shake_camera(L, amount, max(amount/10, 1))

/datum/reagent/consumable/maint_energy/on_mob_life(mob/living/carbon/M)
	. = ..()
	M.Jitter(20)
	M.drowsyness = max(M.drowsyness - 0.5, 0)
	if(M.mind)
		if((M.mind.assigned_role in healed_roles) || (M.mind.special_role in healed_roles))
			M.adjustBruteLoss(-heal_amount, 0)
			M.adjustFireLoss(-heal_amount, 0)
			M.adjustToxLoss(-heal_amount, 0)
			M.adjustOxyLoss(-heal_amount, 0)

/datum/reagent/consumable/maint_energy/zero_fusion
	name = "Maintenance Energy Zero Fusion"
	description = "All the energy you need, without any calories."
	nutriment_factor = 0.05 * REAGENTS_METABOLISM //Hey, isn't this thing supposed to be calorie-free?
	color = "#ffffff3b"
	taste_description = "sugar-free energy"
	glass_name = "glass of Maintenance Energy Zero Fusion"
	glass_desc = "Unleash the singulo."

/datum/reagent/consumable/maint_energy/zero_fusion/on_mob_life(mob/living/carbon/M)
	. = ..()
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		if(H.age >= 30)
			M.adjustBruteLoss(-(2 * heal_amount), 0)
			M.adjustFireLoss(-(2 * heal_amount), 0)
			M.adjustToxLoss(-(2 * heal_amount), 0)
			M.adjustOxyLoss(-(2 * heal_amount), 0)

/datum/reagent/consumable/maint_energy/tritium_flood
	name = "Maintenance Energy Tritium Flood"
	description = "The flavor of atmosia, inside your mouth."
	nutriment_factor = 0.65 * REAGENTS_METABOLISM //Has a lot of flavor.
	pH = 4 //Acidic lemon flavor.
	color = "#00ff3360"
	taste_description = "radioactive lemon"
	glass_name = "glass of Maintenance Energy Tritium Flood"
	glass_desc = "Unleash the tesla."
	healed_roles = list("Station Engineer", "Atmospheric Technician")

/datum/reagent/consumable/maint_energy/plasma_fire
	name = "Maintenance Energy Plasma Fire"
	description = "The flavor of a hellburn, inside your mouth."
	nutriment_factor = -0.1 * REAGENTS_METABOLISM //Burns your calories away.
	color = "#ffd00073"
	taste_description = "burning mango"
	glass_name = "glass of Maintenance Energy Plasma Fire"
	glass_desc = "Unleash the supermatter."
	healed_roles = list("Station Engineer", "Atmospheric Technician")

/datum/reagent/consumable/maint_energy/raid
	name = "Maintenance Energy Raid"
	description = "Energy drink seller, i am going into battle, and i require your strongest energy drinks."
	nutriment_factor = 0.4 * REAGENTS_METABOLISM
	color = "#ff002b96"
	taste_description = "cherries"
	glass_name = "glass of Maintenance Energy Raid"
	glass_desc = "Unleash the Death Squad."
	healed_roles = list("Captain", "Head of Security", "Head of Personnel", "Blueshield",\
						"Security Officer", "Detective", "Brig Physician", "Warden")
	var/extraresist = 0
	var/stunmod = 0
	var/storedstunmod = 0
	var/storedresistance = 0

/datum/reagent/consumable/maint_energy/raid/on_mob_add(mob/living/L, amount)
	. = ..()
	var/mob/living/carbon/human/C = L
	if(istype(C))
		storedresistance = C.physiology.damage_resistance
		C.physiology.damage_resistance += extraresist
		storedstunmod = C.physiology.stun_mod
		C.physiology.stun_mod += stunmod

/datum/reagent/consumable/maint_energy/raid/on_mob_delete(mob/living/L)
	. = ..()
	var/mob/living/carbon/human/C = L
	if(istype(C))
		C.physiology.damage_resistance = storedresistance
		storedresistance = 0
		C.physiology.stun_mod = storedstunmod
		storedstunmod = 0

/datum/reagent/consumable/maint_energy/megaflavor
	name = "Maintenance Energy Megaflavor"
	description = "Those who drink it tend to become Dr. Gibb instead."
	nutriment_factor = 1 * REAGENTS_METABOLISM //Has a lot of flavor. A lot.
	color = "#ff00d4a1"
	taste_description = "bubblegum"
	glass_name = "glass of Maintenance Energy Megaflavor"
	glass_desc = "Only drink capable of turning you into a Blood-Drunk Miner."
	healed_roles = list("Quartermaster", "Cargo Technician", "Shaft Miner")

/datum/reagent/consumable/maint_energy/raid/blood_red
	name = "Maintenance Energy Blood Red"
	description = "Favored by operatives all around the frontier."
	nutriment_factor = 0.357 * REAGENTS_METABOLISM
	pH = 4.5 //more acidic
	color = "#ff0000d8"
	taste_description = "delta alert"
	glass_name = "glass of Maintenance Energy Blood Red"
	glass_desc = "<span class='danger'><b>Destruction of the station is imminent. \
				All crew are instructed to obey all instructions given by heads of staff. \
				Any violations of these orders can be punished by death. \
				This is not a drill.</b></span>"
	extraresist = 0
	stunmod = -0.5
	healed_roles = list(ROLE_SYNDICATE, ROLE_TRAITOR)
	heal_amount = 0.5
	var/stamina_heal_amount = 1
	var/stamina_buffer_heal_amount = 0.5

/datum/reagent/consumable/maint_energy/raid/blood_red/on_mob_add(mob/living/L, amount)
	. = ..()
	if(prob(33))
		var/code = (num2text(rand(0,9)) + num2text(rand(0,9)) + num2text(rand(0,9)))
		var/designation = pick("Alfa","Bravo","Charlie","Delta","Echo","Foxtrot","Zero", "Niner")
		L.say("[code] [designation]")
		playsound(L, 'sound/ambience/antag/tatoralert.ogg', 100)
	to_chat(L, "<span class='userdanger'>The [src] makes you invincible.</span>")

/datum/reagent/consumable/maint_energy/raid/blood_red/on_mob_life(mob/living/carbon/M)
	. = ..()
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		H.adjustStaminaLoss(-stamina_heal_amount)
		H.adjustStaminaLossBuffered(-stamina_buffer_heal_amount)
		H.sprint_buffer = min(H.sprint_buffer_max, H.sprint_buffer + (H.sprint_buffer_regen_ds*4))
		H.AdjustSleeping(-50)

/datum/reagent/consumable/maint_energy/raid/blood_red/on_mob_delete(mob/living/L)
	. = ..()
	to_chat(L, "<span class='danger'>You feel weak again.../span>")
