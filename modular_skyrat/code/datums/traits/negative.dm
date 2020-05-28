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
	heirloom = new heirloom_type(get_turf(quirk_holder))
	GLOB.family_heirlooms += heirloom
	var/list/slots = list(
		"in your left pocket" = SLOT_L_STORE,
		"in your right pocket" = SLOT_R_STORE,
		"in your backpack" = SLOT_IN_BACKPACK
	)
	where = H.equip_in_one_of_slots(heirloom, slots, FALSE) || "at your feet"

//airhead
/datum/quirk/airhead
	name = "Airhead"
	desc = "You are exceptionally airheaded... but who cares?"
	value = -1
	mob_trait = TRAIT_DUMB
	medical_record_text = "Patient exhibits rather low mental capabilities."

//specism
/datum/quirk/specism
	name = "Specist"
	desc = "Other species are a mistake on the gene pool and you know it. Seeing people of differing species negatively impacts your mood, \
			and seeing people of the same species as yours will positively impact your mood."
	value = -1
	medical_record_text = "Patient exhibits an unnatural distaste for people of differing species."
	var/pcooldown = 0
	var/pcooldown_time = 15 SECONDS
	var/master_race

/datum/quirk/specism/add()
	. = ..()
	if(!ishuman(quirk_holder))
		remove() //prejudice is a human problem.
	var/mob/living/carbon/human/trianglehatman = quirk_holder
	master_race = trianglehatman.dna.species.type

/datum/quirk/specism/on_process()
	. = ..()
	if(pcooldown > world.time)
		return
	pcooldown = world.time + pcooldown_time
	if(!ishuman(quirk_holder))
		remove() //prejudice is a human problem.
	var/mob/living/carbon/human/trianglehatman = quirk_holder
	if(!master_race)
		master_race = trianglehatman.dna.species.type
	var/pridecount = 0
	var/hatecount = 0
	for(var/mob/living/carbon/human/H in (view(5, trianglehatman) - trianglehatman))
		if(H.dna.species.type != master_race)
			hatecount++
		else
			pridecount++
	if(hatecount > pridecount)
		SEND_SIGNAL(trianglehatman, COMSIG_ADD_MOOD_EVENT, "specism_hate", /datum/mood_event/specism_hate)
	else if(pridecount > hatecount)
		SEND_SIGNAL(trianglehatman, COMSIG_ADD_MOOD_EVENT, "specism_pride", /datum/mood_event/specism_pride)

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

//man of solitude, also non-speech impending alternative/addon to a social anxiety
/datum/quirk/lone_wolf
	name = "Loner"
	desc = "You enjoy the solitude, and being part of the crowd makes you unhappy."
	value = -1
	medical_record_text = "Patient experiences a strong dislike toward crowds, prefering company of just themselves."
	var/wcooldown = 0
	var/wcooldown_time = 15 SECONDS

/datum/quirk/lone_wolf/on_process()
	. = ..()
	if(wcooldown > world.time)
		return
	wcooldown = world.time + wcooldown_time
	var/mob/living/carbon/human/quietkid = quirk_holder // Some of you guys are alright, don't come to #main-dev tomorrow.
	var/people = 0
	for(var/mob/living/carbon/human/H in (view(5, quietkid) - quietkid))
		people++
	if(people >= 3)
		SEND_SIGNAL(quietkid, COMSIG_ADD_MOOD_EVENT, "lone_wolf_hate", /datum/mood_event/lone_wolf_hate)
	else if(people <= 0) //Not sure if it ever will go below the zero, but still putting it that way just in case.
		SEND_SIGNAL(quietkid, COMSIG_ADD_MOOD_EVENT, "lone_wolf_happy", /datum/mood_event/lone_wolf_happy)
