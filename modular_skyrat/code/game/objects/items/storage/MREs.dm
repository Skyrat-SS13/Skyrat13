/obj/item/storage/mre
	name = "standard MRE"
	desc = "A vacuum-sealed bag containing a day's worth of nutrients for a crewmember in strenuous situations. There is no visible expiration date on the package."
	icon = 'modular_skyrat/icons/obj/MRE.dmi'
	icon_state = "mre"

/obj/item/storage/mre/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	var/static/list/can_hold = typecacheof(list(
		/obj/item/reagent_containers/food,
		/obj/item/reagent_containers/glass/beaker/waterbottle,
		/obj/item/kitchen/fork,
		/obj/item/reagent_containers/food/condiment/pack/))
	STR.can_hold = can_hold

/obj/item/storage/mre/PopulateContents()
	new /obj/item/reagent_containers/food/snacks/soup/mre(src)
	switch (rand(1,2))
		if(1)
			new /obj/item/reagent_containers/food/snacks/sosjerky/healthy/mre(src)
		if(2)
			new /obj/item/reagent_containers/food/snacks/no_raisin/healthy/mre(src)
	new /obj/item/reagent_containers/food/snacks/honeybar(src)
	new /obj/item/reagent_containers/glass/beaker/waterbottle(src)
	new /obj/item/kitchen/fork(src)

/obj/item/storage/mre/protein
	name = "protein MRE"
	icon_state = "meatmre"

/obj/item/storage/mre/protein/PopulateContents()
	switch (rand(1,5))
		if(1)
			new /obj/item/reagent_containers/food/snacks/meatcube(src)
		if(2)
			new /obj/item/reagent_containers/food/snacks/bbqribs(src)
		if(3)
			new /obj/item/reagent_containers/food/snacks/cubancarp(src)
		if(4)
			new /obj/item/reagent_containers/food/snacks/taco/plain(src)
		if(5)
			new /obj/item/reagent_containers/food/snacks/burger/plain(src)
	new /obj/item/reagent_containers/food/snacks/sosjerky/healthy/mre(src)
	new /obj/item/reagent_containers/food/snacks/honeybar(src)
	new /obj/item/reagent_containers/glass/beaker/waterbottle(src)
	new /obj/item/reagent_containers/food/condiment/pack/ketchup(src)
	new /obj/item/reagent_containers/food/condiment/pack/bbqsauce(src)
	new /obj/item/kitchen/fork(src)

/obj/item/storage/mre/vegie
	name = "vegetarian MRE"
	icon_state = "vegmre"

/obj/item/storage/mre/vegie/PopulateContents()
	switch (rand(1,5))
		if(1)
			new /obj/item/reagent_containers/food/snacks/salad/herbsalad(src)
		if(2)
			new /obj/item/reagent_containers/food/snacks/salad/citrusdelight(src)
		if(3)
			new /obj/item/reagent_containers/food/snacks/loadedbakedpotato(src)
		if(4)
			new /obj/item/reagent_containers/food/snacks/carrotfries(src)
		if(5)
			new /obj/item/reagent_containers/food/snacks/salad/boiledrice(src)
	new /obj/item/reagent_containers/food/snacks/no_raisin/healthy/mre(src)
	new /obj/item/reagent_containers/food/snacks/honeybar(src)
	new /obj/item/reagent_containers/glass/beaker/waterbottle(src)
	new /obj/item/reagent_containers/food/condiment/pack/mustard(src)
	new /obj/item/reagent_containers/food/condiment/pack/astrotame(src)
	new /obj/item/kitchen/fork(src)

/obj/item/storage/mre/unusual
	name = "special MRE"
	desc = "A special vacuum-sealed bag containing a day's worth of nutrients... usually."
	icon_state = "crayonmre"
	
/obj/item/storage/mre/unusual/PopulateContents()
	switch (rand(1,6))
		if(1)
			new /obj/item/reagent_containers/food/snacks/spidereggs(src)
		if(2)
			new /obj/item/reagent_containers/food/snacks/stuffedlegion(src)
		if(3)
			new /obj/item/toy/crayon/rainbow/big(src)
		if(4)
			new /obj/item/reagent_containers/food/snacks/burger/corgi(src)
		if(5)
			new /obj/item/reagent_containers/food/snacks/burger/roburger(src)
		if(6)
			new /obj/item/reagent_containers/food/snacks/snowcones/rainbow(src)
	new /obj/item/reagent_containers/food/snacks/donut(src)
	new /obj/item/reagent_containers/food/snacks/chocolateegg(src)
	new /obj/item/reagent_containers/food/drinks/soda_cans/thirteenloko(src)
	new /obj/item/reagent_containers/food/condiment/pack/soysauce(src)
	new /obj/item/reagent_containers/food/condiment/pack/frostoil(src)
	new /obj/item/kitchen/fork(src)