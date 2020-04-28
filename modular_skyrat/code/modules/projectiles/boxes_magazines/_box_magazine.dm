//Better than the old spaghetti solution at least.
/obj/item/ammo_box/update_icon()
	..()
	switch(multiple_sprites)
		if(1)
			icon_state = "[initial(icon_state)]-[stored_ammo.len]"
		if(2)
			icon_state = "[initial(icon_state)]-[stored_ammo.len ? "[max_ammo]" : "0"]"
	desc = "[initial(desc)] There are [stored_ammo.len] shell\s left!"
	for (var/material in bullet_cost)
		var/material_amount = bullet_cost[material]
		material_amount = (material_amount*stored_ammo.len) + base_cost[material]
		custom_materials[material] = material_amount
	set_custom_materials(custom_materials)//make sure we setup the correct properties again
