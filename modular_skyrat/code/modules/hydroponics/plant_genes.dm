/datum/plant_gene/trait/glow/shadow
	//makes plant emit slightly purple shadows
	//adds -potency*(rate*0.2) light power to products
	name = "Shadow Emission"
	rate = 0.04
	glow_color = "#AAD84B"

/datum/plant_gene/trait/glow/shadow/glow_power(obj/item/seeds/S)
	return -max(S.potency*(rate*0.2), 0.2)