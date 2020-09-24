//Hiding underwear
/obj/item
	hide_underwear_examine = TRUE

//Item pickup text
/obj/item
	var/grabtext
	var/grabsound
	hide_underwear_examine = TRUE

/obj/item/pickup(mob/living/user)
	. = ..()
	if(grabtext)
		var/t = replacetext(grabtext,"user","[user]")
		t = replacetext(t,"src","[src.name]")
		user.visible_message("<span class='danger'>[t]</span>")
	if(grabsound)
		playsound(src,grabsound,50,1)

//Item info element
/obj/item/ComponentInitialize()
	. = ..()
	AddElement(/datum/element/item_info)
