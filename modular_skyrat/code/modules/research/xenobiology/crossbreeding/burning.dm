/obj/item/camera/rewind
	cooldown = 1200
	// Rewind cam buffed slightly - can now be reused after a 2 minute cooldown (1 minute for people with Photographer trait), but requires a film cartridge reload...

/obj/item/camera/rewind/afterattack(atom/target, mob/user, flag)
	if(!on || !pictures_left || !isturf(target.loc))
		return
	if(user == target)
		to_chat(user, "<span class=notice>You take a selfie!</span>")
	else
		to_chat(user, "<span class=notice>You take a photo with [target]!</span>")
		to_chat(target, "<span class=notice>[user] takes a photo with you!</span>")
	to_chat(target, "<span class=notice>You'll remember this moment forever!</span>")
	target.AddComponent(/datum/component/dejavu, 1) // ...and also removes second rewind.

	.=..()
