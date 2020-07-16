/datum/outfit/chrono_agent
	name = "Timeline Eradication Agent"
	uniform = /obj/item/clothing/under/rank/rnd/scientist
	suit = /obj/item/clothing/suit/space/chronos
	back = /obj/item/chrono_eraser
	head = /obj/item/clothing/head/helmet/space/chronos
	mask = /obj/item/clothing/mask/breath
	belt = /obj/item/storage/belt/military/abductor/full
	gloves = /obj/item/clothing/gloves/tackler/combat/insulated
	glasses = /obj/item/clothing/glasses/night
	shoes = /obj/item/clothing/shoes/combat
	id = /obj/item/card/id
	suit_store = /obj/item/tank/internals/oxygen
	ears = /obj/item/radio/headset/headset_cent/alt

/datum/outfit/chrono_agent/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE, client/preference_source)
	var/obj/item/card/id/W = H.wear_id
	W.icon_state = "centcom"
	W.access = get_all_accesses()//They get full station access.
	W.access += get_centcom_access("TED Agent")//Let's add their alloted CentCom access.
	W.assignment = "Timeline Eradication Agent"
	W.registered_name = H.real_name
	W.update_label(W.registered_name, W.assignment)