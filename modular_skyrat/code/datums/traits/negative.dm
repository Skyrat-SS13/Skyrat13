/datum/quirk/family_heirloom/on_spawn()
	var/mob/living/carbon/human/H = quirk_holder
	var/obj/item/heirloom_type
	switch(quirk_holder.mind.assigned_role)
		if("Clown")
			heirloom_type = pick(/obj/item/paint/anycolor, /obj/item/bikehorn/golden)
		if("Mime")
			heirloom_type = pick(/obj/item/paint/anycolor, /obj/item/toy/dummy)
		if("Cook")
			heirloom_type = /obj/item/kitchen/knife/scimitar
		if("Botanist")
			heirloom_type = pick(/obj/item/cultivator, /obj/item/reagent_containers/glass/bucket, /obj/item/storage/bag/plants, /obj/item/toy/plush/beeplushie)
		if("Medical Doctor")
			heirloom_type = /obj/item/healthanalyzer/advanced
		if("Paramedic")
			heirloom_type = pick(/obj/item/clothing/neck/stethoscope, /obj/item/bodybag)
		if("Station Engineer")
			heirloom_type = /obj/item/wirecutters/brass
		if("Atmospheric Technician")
			heirloom_type = /obj/item/extinguisher/mini/family
		if("Lawyer")
			heirloom_type = /obj/item/storage/briefcase/lawyer/family
		if("Brig Physician")
			heirloom_type = pick(/obj/item/clothing/neck/stethoscope, /obj/item/roller, /obj/item/book/manual/wiki/security_space_law)
		if("Prisoner")
			heirloom_type = /obj/item/pen/blue
		if("Janitor")
			heirloom_type = /obj/item/mop
		if("Security Officer")
			heirloom_type = /obj/item/clothing/accessory/medal/silver/valor
		if("Scientist")
			heirloom_type = /obj/item/toy/plush/slimeplushie
		if("Assistant")
			heirloom_type = /obj/item/clothing/gloves/cut/family
		if("Chaplain")
			heirloom_type = /obj/item/camera/spooky/family
		if("Captain")
			heirloom_type = /obj/item/clothing/accessory/medal/gold/captain/family
	if(!heirloom_type)
		heirloom_type = pick(
		/obj/item/toy/cards/deck,
		/obj/item/lighter,
		/obj/item/dice/d20)
	if(is_species(H, /datum/species/insect/moth) && prob(50))
		heirloom_type = /obj/item/flashlight/lantern/heirloom_moth
	heirloom = new heirloom_type(get_turf(quirk_holder))
	GLOB.family_heirlooms += heirloom
	RegisterSignal(heirloom, COMSIG_PARENT_QDELETING, .proc/deleting_heirloom)
	var/list/slots = list(
		"in your left pocket" = SLOT_L_STORE,
		"in your right pocket" = SLOT_R_STORE,
		"in your backpack" = SLOT_IN_BACKPACK
	)
	where = H.equip_in_one_of_slots(heirloom, slots, FALSE) || "at your feet"

/datum/quirk/family_heirloom/proc/deleting_heirloom()
	GLOB.family_heirlooms -= heirloom
	UnregisterSignal(heirloom, COMSIG_PARENT_QDELETING)
	heirloom = null

//airhead
/datum/quirk/airhead
	name = "Airhead"
	desc = "You are exceptionally airheaded... but who cares?"
	value = -1
	mob_trait = TRAIT_DUMB
	medical_record_text = "Patient exhibits rather low mental capabilities."

//clumsyness
/datum/quirk/disaster_artist
	name = "Disaster Artist"
	desc = "You always manage to wreak havoc on everything you touch."
	value = -2
	mob_trait = TRAIT_CLUMSY
	medical_record_text = "Patient lacks proper spatial awareness."

//aaa i dont know my mood aaa
/datum/quirk/screwy_mood
	name = "Alexithymia"
	desc = "You cannot accurately assess your feelings."
	value = -1
	mob_trait = TRAIT_SCREWY_MOOD
	medical_record_text = "Patient is incapable of communicating their emotions."

//aaaaaa im bleeding aaaaaaaaa
/datum/quirk/hemophiliac
	name = "Hemophiliac"
	desc = "Your body is bad at coagulating blood. Bleeding will always be two times worse when compared to the average person."
	value = -3
	mob_trait = TRAIT_HEMOPHILIA
	medical_record_text = "Patient exhibits abnormal blood coagulation behavior."

//i cant run help
/datum/quirk/asthmatic
	name = "Asthmatic"
	desc = "You have been diagnosed with asthma. You can only run half of what a healthy person can, and running may cause oxygen damage."
	value = -2
	mob_trait = TRAIT_ASTHMATIC
	medical_record_text = "Patient exhibits asthmatic symptoms."

//owie everythign hurt
/datum/quirk/paper_skin
	name = "Paper skin"
	desc = "Your skin and body are fragile. Damage from most sources is increased by 10%."
	value = -3
	medical_record_text = "Patient is frail and  tends to be damaged quite easily."

/datum/quirk/paper_skin/add()
	. = ..()
	if(.)
		var/mob/living/carbon/human/H = quirk_holder
		if(H && istype(H))
			H.physiology.armor -= 10

//mom grab the epipen
/datum/quirk/allergic
	name = "Allergic"
	desc = "You have had terrible allergies for as long as you can remember. Some foods will become toxic to your palate and cause unforeseen consequences."
	value = -1
	medical_record_text = "Patient is allergic to a certain type of food."

/datum/quirk/allergic/add()
	. = ..()
	if(.)
		var/mob/living/carbon/human/H = quirk_holder
		if(H && istype(H))
			var/foodie = pick(GLOB.food)
			var/randumb = GLOB.food[foodie]
			while((H.dna.species.toxic_food | randumb) == H.dna.species.toxic_food)
				foodie = pick(GLOB.food)
				randumb = GLOB.food[foodie]
			H.dna.species.toxic_food |= randumb
			H.dna.species.liked_food -= randumb
			H.physiology.allergies |= randumb
			addtimer(CALLBACK(src, .proc/inform, foodie), 5 SECONDS)

/datum/quirk/allergic/proc/inform(var/allergy = "bad coders")
	to_chat(quirk_holder, "<span class='danger'><b><i>You are allergic to [lowertext(allergy)].</i></b></span>")

//bobmed quirks

//frail
/datum/quirk/frail
	name = "Frail"
	desc = "Your bones might as well be made of glass! You suffer wounds much more easily than most."
	value = -2
	mob_trait = TRAIT_EASYLIMBDISABLE
	gain_text = "<span class='danger'>You feel frail.</span>"
	lose_text = "<span class='notice'>You feel sturdy again.</span>"
	medical_record_text = "Patient has unusually frail bones, recommend calcium-rich diet."

//betz
/datum/quirk/betz
	name = "Betz Disorder"
	desc = "You cannot feel pain very well! You cannot assess any wounds without the assistance of a health analyzer."
	value = -1
	mob_trait = TRAIT_SCREWY_CHECKSELF
	gain_text = "<span class='danger'>You don't feel much of anything.</span>"
	lose_text = "<span class='notice'>You can feel your skin tingling again.</span>"
	medical_record_text = "Patient has little self-awareness, and cannot properly assess their health."
