
/obj/item/organ/lungs/yamerol
	name = "Yamerol lungs"
	desc = "A temporary pair of lungs made from self assembling yamerol molecules."
	maxHealth = 200
	color = "#68e83a"

/obj/item/organ/lungs/yamerol/on_life()
	. = ..()
	if(.)
		applyOrganDamage(2) //Yamerol lungs are temporary
