//legion (the big one!)
/obj/item/crusher_trophy/legion_shard
	name = "legion bone shard"
	desc = "Part of a legion's cranium. Suitable as a trophy for a kinetic crusher."
	icon = 'icons/obj/mining.dmi'
	icon_state = "bone"
	denied_type = /obj/item/crusher_trophy/legion_shard

/obj/item/crusher_trophy/legion_shard/effect_desc()
	return "a kinetic crusher to make dead animals into friendly fauna, as well as turning corpses into legions"

/obj/item/crusher_trophy/legion_shard/on_mark_detonation(mob/living/target, mob/living/user)
	if(target.stat == DEAD)
		if(istype(target, /mob/living/simple_animal/hostile/asteroid))
			var/mob/living/simple_animal/hostile/asteroid/L = target
			L.revive(full_heal = 1, admin_revive = 1)
			if(ishostile(L))
				L.attack_same = 0
			L.loot = null
			L.crusher_loot = null
			user.visible_message("<span class='notice'>[user] revives [target] with [src], as a friendly fauna</span>")
			playsound(src,'sound/effects/supermatter.ogg',50,1)

/obj/item/crusher_trophy/legion_shard/on_melee_hit(mob/living/target, mob/living/user)
	if(ishuman(target) && (target.stat == DEAD))
		var/confirm = input("Are you sure you want to turn [target] into a friendly legion?", "Sure?") in list("Yes", "No")
		if(confirm == "Yes")
			var/mob/living/carbon/human/H = target
			var/mob/living/simple_animal/hostile/asteroid/hivelord/legion/L = new /mob/living/simple_animal/hostile/asteroid/hivelord/legion(H.loc)
			L.stored_mob = H
			H.forceMove(L)
			L.faction = list("neutral")
			L.revive(full_heal = 1, admin_revive = 1)
			if(ishostile(L))
				L.attack_same = 0
			L.loot = null
			L.crusher_loot = null
			user.visible_message("<span class='notice'>[user] revives [target] with [src], as a friendly legion.</span>")
			playsound(src,'sound/effects/supermatter.ogg',50,1)
		else
			(to_chat(user, "<span class='notice'>You cancel turning [target] into a legion.</span>"))
