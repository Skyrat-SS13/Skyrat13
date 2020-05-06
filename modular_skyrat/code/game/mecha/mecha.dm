/obj/mecha
	var/shouldberestricted = FALSE //you get the point by now
	var/securitylevelrestriction = null 
	var/savedrestriction = null

/obj/mecha/attackby(obj/item/W, mob/user, params)
	. = ..()
	if(istype(W, /obj/item/card/id))
		var/obj/item/card/id/id = W 
		if(ACCESS_ARMORY in id.access)
			to_chat(user, securitylevelrestriction ? "<span class='notice'>You lock \the [src] for security level based use.</span>" : "<span class='notice'>You unlock \the [src] from security level based use.</span>")
			if(securitylevelrestriction)
				savedrestriction = securitylevelrestriction
				securitylevelrestriction = null
			else 
				securitylevelrestriction = savedrestriction
				savedrestriction = null

/obj/mecha/examine(mob/user)
	. = ..()
	var/integrity = obj_integrity*100/max_integrity
	switch(integrity)
		if(85 to 100)
			. += "It's fully intact."
		if(65 to 85)
			. += "It's slightly damaged."
		if(45 to 65)
			. += "It's badly damaged."
		if(25 to 45)
			. += "It's heavily damaged."
		else
			. += "It's falling apart."
	if(equipment && equipment.len)
		. += "It's equipped with:"
		for(var/obj/item/mecha_parts/mecha_equipment/ME in equipment)
			. += "[icon2html(ME, user)] \A [ME]."
	if(shouldberestricted)
		. +=  "It's full usage is locked to [securitylevelrestriction ? NUM2SECLEVEL(securitylevelrestriction) : "no"] security level."
