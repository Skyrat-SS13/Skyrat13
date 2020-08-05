//Revenants: based off of wraiths from Goon
//"Ghosts" that are invisible and move like ghosts, cannot take damage while invisible
//Don't hear deadchat and are NOT normal ghosts
//Admin-spawn or random event

/mob/living/simple_animal/revenant
	icon = 'modular_skyrat/icons/mob/mob.dmi'
	speech_span = "revennotice"
	var/visible = FALSE
	var/icon_visible = "revenant_idle"
	var/last_revenant_action = 0

/mob/living/simple_animal/revenant/Initialize(mapload)
	. = ..()
	AddSpell(new /obj/effect/proc_holder/spell/targeted/togglevisibility(null))
	AddSpell(new /obj/effect/proc_holder/spell/aoe_turf/flicker_lights/revenant(null))

/mob/living/simple_animal/revenant/Login()
	..()
	to_chat(src, "<span class='deadsay'><span class='big bold'>You are a revenant.</span></span>")
	to_chat(src, "<b>Your formerly mundane spirit has been infused with alien energies and empowered into a revenant.</b>")
	to_chat(src, "<b>You are not dead, not alive, but somewhere in between. You are capable of limited interaction with both worlds.</b>")
	to_chat(src, "<b>You are invincible and invisible to everyone but other ghosts. Harmful abilities will reveal you, rendering you vulnerable.</b>")
	to_chat(src, "<b>To function, you are to drain the life essence from humans. This essence is a resource, as well as your health, and will power to your harmful abilities.</b>")
	to_chat(src, "<b>Though you are not required to use them at all, you can whisper to people or reveal yourself to speak out loud.</b>")
	to_chat(src, "<b>You can click on lights, light switches and windows to interact with them, be a mischevious spirit and play with the crew's heads! Try not to intentionally kill things, alive subjects are more fun.</b>")
	to_chat(src, "<b><i>You do not remember anything of your past lives, nor will you remember anything about this one after your death.</i></b>")
	to_chat(src, "<b>Be sure to read <a href=\"https://tgstation13.org/wiki/Revenant\">the wiki page</a> to learn more.</b>")
	if(!generated_objectives_and_spells)
		generated_objectives_and_spells = TRUE
		mind.assigned_role = ROLE_REVENANT
		mind.special_role = ROLE_REVENANT
		SEND_SOUND(src, sound('sound/effects/ghost.ogg'))
		mind.add_antag_datum(/datum/antagonist/revenant)

//Life, Stat, Hud Updates, and Say
/mob/living/simple_animal/revenant/Life()
	if(stasis)
		return
	if(revealed && essence <= 0)
		death()
	if(unreveal_time && world.time >= unreveal_time)
		unreveal_time = 0
		revealed = FALSE
		incorporeal_move = INCORPOREAL_MOVE_JAUNT
		invisibility = INVISIBILITY_REVENANT
		to_chat(src, "<span class='revenboldnotice'>You are once more concealed.</span>")
	if(unstun_time && world.time >= unstun_time)
		unstun_time = 0
		mob_transforming = FALSE
		to_chat(src, "<span class='revenboldnotice'>You can move again!</span>")
	if(essence_regenerating && !inhibited && essence < essence_regen_cap) //While inhibited, essence will not regenerate
		essence = min(essence_regen_cap, essence+essence_regen_amount)
		update_action_buttons_icon() //because we update something required by our spells in life, we need to update our buttons
	update_spooky_icon()
	update_health_hud()
	..()

/mob/living/simple_animal/revenant/Stat()
	..()
	if(statpanel("Status"))
		stat(null, "Current essence: [essence]/[essence_regen_cap]E")
		stat(null, "Stolen essence: [essence_accumulated]E")
		stat(null, "Stolen perfect souls: [perfectsouls]")

/mob/living/simple_animal/revenant/update_health_hud()
	if(hud_used)
		var/essencecolor = "#8F48C6"
		if(essence > essence_regen_cap)
			essencecolor = "#9A5ACB" //oh boy you've got a lot of essence
		else if(!essence)
			essencecolor = "#1D2953" //oh jeez you're dying
		hud_used.healths.maptext = "<div align='center' valign='middle' style='position:relative; top:0px; left:6px'><font color='[essencecolor]'>[essence]E</font></div>"

/mob/living/simple_animal/revenant/med_hud_set_health()
	return //we use no hud

/mob/living/simple_animal/revenant/med_hud_set_status()
	return //we use no hud

/mob/living/simple_animal/revenant/say(message, bubble_type, var/list/spans = list(), sanitize = TRUE, datum/language/language = null, ignore_spam = FALSE, forced = null)
	if(!message)
		return
	if(revealed || visible)
		if(message == "" || !message)
			return
		spans |= speech_span
		if(!language)
			language = get_selected_language()
		send_speech(message, 7, src, , spans, message_language=language)
	else
		src.log_talk(message, LOG_SAY)
		var/rendered = "<span class='revennotice'><b>[src]</b> wails, \"[message]\"</span>"
		for(var/mob/M in GLOB.mob_list)
			if(isrevenant(M))
				to_chat(M, rendered)
			else if(isobserver(M))
				var/link = FOLLOW_LINK(M, src)
				to_chat(M, "[link] [rendered]")
	return


//Immunities

/mob/living/simple_animal/revenant/ex_act(severity, target)
	return 1 //Immune to the effects of explosions.

/mob/living/simple_animal/revenant/blob_act(obj/structure/blob/B)
	return //blah blah blobs aren't in tune with the spirit world, or something.

/mob/living/simple_animal/revenant/singularity_act()
	return //don't walk into the singularity expecting to find corpses, okay?

/mob/living/simple_animal/revenant/narsie_act()
	return //most humans will now be either bones or harvesters, but we're still un-alive.

/mob/living/simple_animal/revenant/ratvar_act()
	return //clocks get out reee

//damage, gibbing, and dying
/mob/living/simple_animal/revenant/attackby(obj/item/W, mob/living/user, params)
	if(visible)//Visible is basically invulnerable, revealed dictates their corporeality
		return
	. = ..()
	if(istype(W, /obj/item/nullrod))
		visible_message("<span class='warning'>[src] violently flinches!</span>", \
						"<span class='revendanger'>As \the [W] passes through you, you feel your essence draining away!</span>")
		adjustBruteLoss(25) //hella effective
		inhibited = TRUE
		update_action_buttons_icon()
		addtimer(CALLBACK(src, .proc/reset_inhibit), 30)

/mob/living/simple_animal/revenant/adjustHealth(amount, updating_health = TRUE, forced = FALSE)
	if(!forced && !revealed)
		return FALSE
	. = amount
	essence = max(0, essence-amount)
	if(updating_health)
		update_health_hud()
	if(!essence)
		death()

/mob/living/simple_animal/revenant/dust(just_ash, drop_items, force)
	death()

/mob/living/simple_animal/revenant/gib()
	death()

/mob/living/simple_animal/revenant/death()
	if(visible || !revealed || stasis) //Revenants cannot die if they aren't revealed //or are already dead
		return 0
	stasis = TRUE
	to_chat(src, "<span class='revendanger'>NO! No... it's too late, you can feel your essence [pick("breaking apart", "drifting away")]...</span>")
	mob_transforming = TRUE
	revealed = TRUE
	invisibility = 0
	playsound(src, 'sound/effects/screech.ogg', 100, 1)
	visible_message("<span class='warning'>[src] lets out a waning screech as violet mist swirls around its dissolving body!</span>")
	icon_state = "revenant_draining"
	for(var/i = alpha, i > 0, i -= 10)
		stoplag()
		alpha = i
	visible_message("<span class='danger'>[src]'s body breaks apart into a fine pile of blue dust.</span>")
	var/reforming_essence = essence_regen_cap //retain the gained essence capacity
	var/obj/item/ectoplasm/revenant/R = new(get_turf(src))
	R.essence = max(reforming_essence - 15 * perfectsouls, 75) //minus any perfect souls
	R.old_key = client.key //If the essence reforms, the old revenant is put back in the body
	R.revenant = src
	invisibility = INVISIBILITY_ABSTRACT
	revealed = FALSE
	ghostize(0)//Don't re-enter invisible corpse

/mob/living/simple_animal/revenant/proc/set_visibility(state)
	visible = state
	if(visible)
		invisibility = 0
		incorporeal_move = FALSE
	else
		invisibility = INVISIBILITY_REVENANT
		incorporeal_move = INCORPOREAL_MOVE_JAUNT
	update_spooky_icon()


//reveal, stun, icon updates, cast checks, and essence changing
/mob/living/simple_animal/revenant/reveal(time)
	if(!src)
		return
	if(time <= 0)
		return
	set_visibility(FALSE)
	revealed = TRUE
	invisibility = 0
	incorporeal_move = FALSE
	if(!unreveal_time)
		to_chat(src, "<span class='revendanger'>You have been revealed!</span>")
		unreveal_time = world.time + time
	else
		to_chat(src, "<span class='revenwarning'>You have been revealed!</span>")
		unreveal_time = unreveal_time + time
	update_spooky_icon()

/mob/living/simple_animal/revenant/update_spooky_icon()
	if(visible)
		icon_state = icon_visible
	else
		if(revealed)
			if(mob_transforming)
				if(draining)
					icon_state = icon_drain
				else
					icon_state = icon_stun
			else
				icon_state = icon_reveal
		else
			icon_state = icon_idle

//objectives
/datum/objective/revenant
	targetAmount = 100

/datum/objective/revenant/New()
	targetAmount = rand(350,600)
	explanation_text = "Absorb [targetAmount] points of essence from humans."
	..()

/datum/objective/revenant/check_completion()
	if(!isrevenant(owner.current))
		return FALSE
	var/mob/living/simple_animal/revenant/R = owner.current
	if(!R || R.stat == DEAD)
		return FALSE
	var/essence_stolen = R.essence_accumulated
	if(essence_stolen < targetAmount)
		return FALSE
	return TRUE

/datum/objective/revenantFluff

/datum/objective/revenantFluff/New()
	var/list/explanationTexts = list("Assist other mischevious beings, tempt them to do crimes.", \
									 "Spook the crew to the bone.", \
									 "Entertain yourself.", \
									 "Vandalise the station, or encourage crew to do so.", \
									 "Annoy the silicons as much as possible.", \
									 "Ensure that any holy weapons are rendered unusable.", \
									 "Hinder the crew while attempting to avoid being noticed.", \
									 "Make the clown as miserable as possible.")
	explanation_text = pick(explanationTexts)
	..()

/datum/objective/revenantFluff/check_completion()
	return TRUE

/mob/living/simple_animal/revenant/ClickOn( atom/A, params )
	var/list/modifiers = params2list(params)
	if(!modifiers["shift"] && !modifiers["ctrl"] && !modifiers["middle"] && !modifiers["right"])
		//Revenant action
		if(last_revenant_action + 200 < world.time)
			var/acted = FALSE
			if(istype(A,/obj/machinery/light/))
				var/obj/machinery/light/lt = A
				lt.flicker(10)
				acted = TRUE
			else if (istype(A,/obj/machinery/light_switch))
				var/obj/machinery/light_switch/lt = A
				lt.interact(src)
				acted = TRUE
			else if (istype(A,/obj/item/flashlight/lamp))
				var/obj/item/flashlight/lamp/lt = A
				lt.on = !lt.on
				lt.update_brightness()
				playsound(lt, lt.on ? 'sound/weapons/magin.ogg' : 'sound/weapons/magout.ogg', 40, 1)
				acted = TRUE
			else if (istype(A,/obj/structure/window))
				var/obj/structure/window/lt = A
				lt.visible_message("<span class='notice'>Something knocks on [lt].</span>")
				playsound(lt, 'sound/effects/Glassknock.ogg', 50, 1)
				acted = TRUE

			if (acted)
				last_revenant_action = world.time
				return
	
	. = ..()
