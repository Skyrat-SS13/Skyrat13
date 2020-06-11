///Lavaproof, fireproof, fast mech with low armor and higher energy consumption. Has an internal ore box.
/obj/mecha/working/ripley/clarke
	name = "\proper Clarke"
	desc = "Combining man and machine for a better, stronger miner... Or engineer. Can even resist lava!"
	icon = 'modular_skyrat/icons/mecha/mecha.dmi'
	icon_state = "clarke"
	max_temperature = 65000
	max_integrity = 200
	step_in = 1
	fast_pressure_step_in = 1
	slow_pressure_step_in = 1
	resistance_flags = LAVA_PROOF | FIRE_PROOF | ACID_PROOF
	lights_power = 7
	deflect_chance = 10
	step_energy_drain = 15 //slightly higher energy drain since you movin those wheels FAST
	armor = list("melee" = 20, "bullet" = 10, "laser" = 20, "energy" = 10, "bomb" = 60, "bio" = 0, "rad" = 70, "fire" = 100, "acid" = 100) //low armor to compensate for fire protection and speed
	max_equip = 7
	wreckage = /obj/structure/mecha_wreckage/clarke

/obj/mecha/working/ripley/clarke/Initialize()
	. = ..()
	cargo.Add(new /obj/structure/ore_box/clarke(src))
	var/datum/component/armor_plate/C = src.GetComponent(/datum/component/armor_plate) //funny ripley inheritance gave us the ability to get goliath armoring. we don't want that.
	C.Destroy()

/obj/mecha/working/ripley/clarke/collect_ore()
	var/obj/structure/ore_box/ore_box = locate(/obj/structure/ore_box) in cargo
	if(ore_box)
		for(var/obj/item/stack/ore/ore in range(1, src))
			if(ore.Adjacent(src) && ((get_dir(src, ore) & dir) || ore.loc == loc)) //we can reach it and it's in front of us? grab it!
				ore.forceMove(ore_box)

/obj/mecha/working/ripley/clarke/moved_inside(mob/living/carbon/human/H)
	. = ..()
	if(.)
		var/datum/atom_hud/hud = GLOB.huds[DATA_HUD_DIAGNOSTIC_ADVANCED]
		hud.add_hud_to(H)

/obj/mecha/working/ripley/clarke/go_out()
	if(isliving(occupant))
		var/mob/living/L = occupant
		var/datum/atom_hud/hud = GLOB.huds[DATA_HUD_DIAGNOSTIC_ADVANCED]
		hud.remove_hud_from(L)
	return ..()

/obj/mecha/working/ripley/clarke/mmi_moved_inside(obj/item/mmi/M, mob/user)
	. = ..()
	if(.)
		var/datum/atom_hud/hud = GLOB.huds[DATA_HUD_DIAGNOSTIC_ADVANCED]
		var/mob/living/brain/B = M.brainmob
		hud.add_hud_to(B)

/obj/structure/ore_box/clarke
	name = "clarke ore box"
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF

/obj/structure/ore_box/clarke/Bumped(atom/movable/AM)
	. = ..()
	if(istype(AM, /obj/mecha/working/ripley/clarke))
		var/obj/mecha/working/ripley/clarke/C = AM
		forceMove(C)
		C.cargo.Add(src)
		if(C.occupant)
			to_chat(C.occupant, "<span class = 'notice'>\The [C] picks up \the [src].")
