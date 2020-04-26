/obj/structure/trash_pile
	name = "trash pile"
	desc = "A heap of garbage, but maybe there's something interesting inside?"
	icon = 'modular_skyrat/icons/obj/trash_piles.dmi'
	icon_state = "randompile"
	density = TRUE
	anchored = TRUE

	var/list/searchedby	= list()// Characters that have searched this trashpile, with values of searched time.

	var/chance_alpha	= 99 // Alpha list is the normal maint loot table.
	var/chance_beta		= 1	 // Beta list is unique items only, and will only spawn one of each.

	//These are types that can only spawn once, and then will be removed from this list.
	var/global/list/unique_beta = list(
		/obj/item/gun/ballistic/automatic/pistol,
		/obj/item/clothing/glasses/thermal,
		/obj/item/clothing/gloves/tackler/combat/insulated,
		/obj/item/disk/nuclear/fake,
		/obj/item/pen/edagger
	)

	var/global/list/allocated_beta = list()

/obj/structure/trash_pile/Initialize()
	. = ..()
	icon_state = pick(
		"pile1",
		"pile2",
		"pilechair",
		"piletable",
		"pilevending",
		"brtrashpile",
		"microwavepile",
		"rackpile",
		"boxfort",
		"trashbag",
		"brokecomp",
	)

/obj/structure/trash_pile/attack_hand(mob/user)
	//Human mob
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		H.visible_message("[user] searches through \the [src].","<span class='notice'>You search through \the [src].</span>")
		//Do the searching
		if(do_after(user,rand(4 SECONDS,6 SECONDS),target=src))
			//You already searched this one bruh
			if(user.ckey in searchedby)
				to_chat(H,"<span class='warning'>There's nothing else for you in \the [src]!</span>")
			//You found an item!
			else
				var/luck = rand(1,100)
				var/obj/item/I
				if(luck <= chance_alpha)
					I = produce_alpha_item()
				else if(luck <= chance_alpha+chance_beta)
					I = produce_beta_item()

				//We either have an item to hand over or we don't, at this point!
				if(I)
					searchedby += user.ckey
					I.forceMove(get_turf(src))
					to_chat(H,"<span class='notice'>You found \a [I]!</span>")

	else
		return ..()

//Random lists
/obj/structure/trash_pile/proc/produce_alpha_item()
	var/path = pickweight(GLOB.maintenance_loot)
	var/obj/item/I = new path
	return I

/obj/structure/trash_pile/proc/produce_beta_item()
	var/path = pick_n_take(unique_beta)
	if(!path) //Tapped out, reallocate?
		for(var/P in allocated_beta)
			var/obj/item/I = allocated_beta[P]
			if(QDELETED(I) || istype(I.loc,/obj/machinery/computer/cryopod))
				allocated_beta -= P
				path = P
				break
	if(path)
		var/obj/item/I = new path()
		allocated_beta[path] = I
		return I
	else
		return produce_alpha_item()
