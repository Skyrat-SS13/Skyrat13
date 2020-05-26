/obj/structure/grille/plastic
	name = "plastic grille"
	desc = "A flimsy framework of plastic rods."
	icon = 'modular_skyrat/code/game/objects/structures/plasticusage/plasticstructures.dmi'
	icon_state = "grille"
	max_integrity = 10
	rods_type = /obj/item/stack/rods/plastic
	broken_type = /obj/structure/grille/broken/plastic

/obj/structure/grille/broken/plastic
	icon = 'modular_skyrat/code/game/objects/structures/plasticusage/plasticstructures.dmi'
	icon_state = "brokengrille"

/obj/structure/grille/attackby(obj/item/W, mob/user, params)
	user.changeNext_move(CLICK_CD_MELEE)
	add_fingerprint(user)
	if(istype(W, /obj/item/wirecutters))
		if(!shock(user, 100))
			W.play_tool_sound(src, 100)
			deconstruct()
	else if((istype(W, /obj/item/screwdriver)) && (isturf(loc) || anchored))
		if(!shock(user, 90))
			W.play_tool_sound(src, 100)
			setAnchored(!anchored)
			user.visible_message("<span class='notice'>[user] [anchored ? "fastens" : "unfastens"] [src].</span>", \
								 "<span class='notice'>You [anchored ? "fasten [src] to" : "unfasten [src] from"] the floor.</span>")
			return
	else if(istype(W, /obj/item/stack/rods) && broken)
		var/obj/item/stack/rods/R = W
		if(!shock(user, 90))
			user.visible_message("<span class='notice'>[user] rebuilds the broken grille.</span>", \
								 "<span class='notice'>You rebuild the broken grille.</span>")
			new grille_type(src.loc)
			R.use(1)
			qdel(src)
			return

//window placing begin
	else if(is_glass_sheet(W))
		if (!broken)
			var/obj/item/stack/ST = W
			if (ST.get_amount() < 2)
				to_chat(user, "<span class='warning'>You need at least two sheets of glass for that!</span>")
				return
			var/dir_to_set = SOUTHWEST
			if(!anchored)
				to_chat(user, "<span class='warning'>[src] needs to be fastened to the floor first!</span>")
				return
			for(var/obj/structure/window/WINDOW in loc)
				to_chat(user, "<span class='warning'>There is already a window there!</span>")
				return
			to_chat(user, "<span class='notice'>You start placing the window...</span>")
			if(do_after(user,20, target = src))
				if(!src.loc || !anchored) //Grille broken or unanchored while waiting
					return
				for(var/obj/structure/window/WINDOW in loc) //Another window already installed on grille
					return
				var/obj/structure/window/WD
				if(istype(W, /obj/item/stack/sheet/plasmarglass))
					WD = new/obj/structure/window/plasma/reinforced/fulltile(drop_location()) //reinforced plasma window
				else if(istype(W, /obj/item/stack/sheet/plasmaglass))
					WD = new/obj/structure/window/plasma/fulltile(drop_location()) //plasma window
				else if(istype(W, /obj/item/stack/sheet/rglass))
					WD = new/obj/structure/window/reinforced/fulltile(drop_location()) //reinforced window
				else if(istype(W, /obj/item/stack/sheet/titaniumglass))
					WD = new/obj/structure/window/shuttle(drop_location())
				else if(istype(W, /obj/item/stack/sheet/plastitaniumglass))
					WD = new/obj/structure/window/plastitanium(drop_location())
				else
					WD = new/obj/structure/window/fulltile(drop_location()) //normal window
				WD.setDir(dir_to_set)
				WD.ini_dir = dir_to_set
				WD.setAnchored(FALSE)
				WD.state = 0
				ST.use(2)
				to_chat(user, "<span class='notice'>You place [WD] on [src].</span>")
			return
//window placing end
//plastic window placing being
	else if(istype(W, /obj/item/stack/sheet/plastic))
		if (!broken)
			var/obj/item/stack/ST = W
			if (ST.get_amount() < 2)
				to_chat(user, "<span class='warning'>You need at least two sheets of glass for that!</span>")
				return
			var/dir_to_set = SOUTHWEST
			if(!anchored)
				to_chat(user, "<span class='warning'>[src] needs to be fastened to the floor first!</span>")
				return
			for(var/obj/structure/window/WINDOW in loc)
				to_chat(user, "<span class='warning'>There is already a window there!</span>")
				return
			to_chat(user, "<span class='notice'>You start placing the window...</span>")
			if(do_after(user,20, target = src))
				if(!src.loc || !anchored) //Grille broken or unanchored while waiting
					return
				for(var/obj/structure/window/WINDOW in loc) //Another window already installed on grille
					return
				var/obj/structure/window/WD
				WD = new/obj/structure/window/plastic/fulltile(drop_location())
				WD.setDir(dir_to_set)
				WD.ini_dir = dir_to_set
				WD.setAnchored(FALSE)
				WD.state = 0
				ST.use(2)
				to_chat(user, "<span class='notice'>You place [WD] on [src].</span>")
			return
//plastic window placing end
	else if(istype(W, /obj/item/shard) || !shock(user, 70))
		return ..()