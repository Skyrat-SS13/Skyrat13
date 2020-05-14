/obj/item/seeds/proc/spawn_product(output_loc)
	var/obj/item/reagent_containers/food/snacks/grown/t_prod = new product(output_loc, src)
	if(plantname != initial(plantname))
		t_prod.name = lowertext(plantname)
	if(productdesc)
		t_prod.desc = productdesc
	/* Why is this a thing? Who put this here.. I am confused
	t_prod.seed.name = name
	t_prod.seed.desc = desc
	t_prod.seed.plantname = plantname
	*/

	return t_prod

/obj/item/seeds/proc/harvest(mob/user)
	var/obj/machinery/hydroponics/parent = loc //for ease of access
	var/t_amount = 0
	var/list/result = list()
	var/output_loc = parent.Adjacent(user) ? user.loc : parent.loc //needed for TK
	var/product_name
	while(t_amount < getYield())
		var/obj/item/reagent_containers/food/snacks/grown/t_prod = spawn_product(output_loc)
		result.Add(t_prod) // User gets a consumable
		if(!t_prod)
			return
		t_amount++
		product_name = parent.myseed.plantname
	if(getYield() >= 1)
		SSblackbox.record_feedback("tally", "food_harvested", getYield(), product_name)
	parent.investigate_log("[user] harvested [getYield()] of [src], with seed traits [english_list(genes)] and reagents_add [english_list(reagents_add)] and potency [potency].", INVESTIGATE_BOTANY)
	parent.update_tray(user)
	return result