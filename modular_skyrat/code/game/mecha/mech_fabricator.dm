/obj/machinery/mecha_part_fabricator
	var/link_on_init = TRUE
	var/datum/component/remote_materials/rmat
	part_sets = list(
						"Cyborg",
						"Ripley",
						"Firefighter",
						"Killdozer",
						"Odysseus",
						"Gygax",
						"Durand",
						"H.O.N.K",
						"Phazon",
						"Exosuit Equipment",
						"Exosuit Ammunition",
						"Cyborg Upgrade Modules",
						"Misc"
						)

/obj/machinery/mecha_part_fabricator/Initialize(mapload)
	stored_research = new
	rmat = AddComponent(/datum/component/remote_materials, "mechfab", mapload && link_on_init)
	RefreshParts() //Recalculating local material sizes if the fab isn't linked
	return ..()

/obj/machinery/mecha_part_fabricator/examine(mob/user)
	. = ..()
	if(in_range(user, src) || isobserver(user))
		. += "<span class='notice'>The status display reads: Storing up to <b>[rmat.local_size]</b> material units.<br>Material consumption at <b>[component_coeff*100]%</b>.<br>Build time reduced by <b>[100-time_coeff*100]%</b>.</span>"

/obj/machinery/mecha_part_fabricator/RefreshParts()
	var/T = 0

	//maximum stocking amount (default 300000, 600000 at T4)
	for(var/obj/item/stock_parts/matter_bin/M in component_parts)
		T += M.rating
	rmat.set_local_size((200000 + (T*50000)))

	//resources adjustment coefficient (1 -> 0.85 -> 0.7 -> 0.55)
	T = 1.15
	for(var/obj/item/stock_parts/micro_laser/Ma in component_parts)
		T -= Ma.rating*0.15
	component_coeff = T

	//building time adjustment coefficient (1 -> 0.8 -> 0.6)
	T = -1
	for(var/obj/item/stock_parts/manipulator/Ml in component_parts)
		T += Ml.rating
	time_coeff = round(initial(time_coeff) - (initial(time_coeff)*(T))/5,0.01)

/obj/machinery/mecha_part_fabricator/proc/output_available_resources()
	var/output
	var/datum/component/material_container/materials = rmat.mat_container

	if(materials)
		for(var/mat_id in materials.materials)
			var/datum/material/M = mat_id
			var/amount = materials.materials[mat_id]
			var/ref = REF(M)
			output += "<span class=\"res_name\">[M.name]: </span>[amount] cm&sup3;"
			if(amount >= MINERAL_MATERIAL_AMOUNT)
				output += "<span style='font-size:80%;'>- Remove \[<a href='?src=[REF(src)];remove_mat=1;material=[ref]'>1</a>\]"
				if(amount >= (MINERAL_MATERIAL_AMOUNT * 10))
					output += " | \[<a href='?src=[REF(src)];remove_mat=10;material=[ref]'>10</a>\]"
				output += " | \[<a href='?src=[REF(src)];remove_mat=50;material=[ref]'>50</a>\]</span>"
			output += "<br>"
	else
		output += "<font color='red'>No material storage connected, please contact the quartermaster.</font><br>"
	return output

/obj/machinery/mecha_part_fabricator/proc/check_resources(datum/design/D)
	if(D.reagents_list.len) // No reagents storage - no reagent designs.
		return FALSE
	var/datum/component/material_container/materials = rmat.mat_container
	if(materials.has_materials(get_resources_w_coeff(D)))
		return TRUE
	return FALSE

/obj/machinery/mecha_part_fabricator/proc/build_part(datum/design/D)
	var/list/res_coef = get_resources_w_coeff(D)

	var/datum/component/material_container/materials = rmat.mat_container
	if (!materials)
		say("No access to material storage, please contact the quartermaster.")
		return FALSE
	if (rmat.on_hold())
		say("Mineral access is on hold, please contact the quartermaster.")
		return FALSE
	if(!check_resources(D))
		say("Not enough resources. Queue processing stopped.")
		return FALSE
	being_built = D
	desc = "It's building \a [initial(D.name)]."
	materials.use_materials(res_coef)
	rmat.silo_log(src, "built", -1, "[D.name]", res_coef)

	add_overlay("fab-active")
	use_power = ACTIVE_POWER_USE
	updateUsrDialog()
	sleep(get_construction_time_w_coeff(D))
	use_power = IDLE_POWER_USE
	cut_overlay("fab-active")
	desc = initial(desc)

	var/location = get_step(src,(dir))
	var/obj/item/I = new D.build_path(location)
	I.material_flags |= MATERIAL_NO_EFFECTS
	I.set_custom_materials(res_coef)
	say("\The [I] is complete.")
	being_built = null

	updateUsrDialog()
	return TRUE

/obj/machinery/mecha_part_fabricator/Topic(href, href_list)  // Skyrat edit -- BEGIN -- Moved to modular_skyrat/code/game/mecha/mech_fabricator.dm
	if(..())
		return
	if(href_list["part_set"])
		var/tpart_set = href_list["part_set"]
		if(tpart_set)
			if(tpart_set=="clear")
				part_set = null
			else
				part_set = tpart_set
				screen = "parts"
	if(href_list["part"])
		var/T = href_list["part"]
		for(var/v in stored_research.researched_designs)
			var/datum/design/D = SSresearch.techweb_design_by_id(v)
			if(D.build_type & MECHFAB)
				if(D.id == T)
					if(!processing_queue)
						build_part(D)
					else
						add_to_queue(D)
					break
	if(href_list["add_to_queue"])
		var/T = href_list["add_to_queue"]
		for(var/v in stored_research.researched_designs)
			var/datum/design/D = SSresearch.techweb_design_by_id(v)
			if(D.build_type & MECHFAB)
				if(D.id == T)
					add_to_queue(D)
					break
		return update_queue_on_page()
	if(href_list["remove_from_queue"])
		remove_from_queue(text2num(href_list["remove_from_queue"]))
		return update_queue_on_page()
	if(href_list["partset_to_queue"])
		add_part_set_to_queue(href_list["partset_to_queue"])
		return update_queue_on_page()
	if(href_list["process_queue"])
		spawn(0)
			if(processing_queue || being_built)
				return FALSE
			processing_queue = 1
			process_queue()
			processing_queue = 0
	if(href_list["clear_temp"])
		temp = null
	if(href_list["screen"])
		screen = href_list["screen"]
	if(href_list["queue_move"] && href_list["index"])
		var/index = text2num(href_list["index"])
		var/new_index = index + text2num(href_list["queue_move"])
		if(isnum(index) && isnum(new_index) && ISINTEGER(index) && ISINTEGER(new_index))
			if(ISINRANGE(new_index,1,queue.len))
				queue.Swap(index,new_index)
		return update_queue_on_page()
	if(href_list["clear_queue"])
		queue = list()
		return update_queue_on_page()
	if(href_list["sync"])
		sync()
	if(href_list["part_desc"])
		var/T = href_list["part_desc"]
		for(var/v in stored_research.researched_designs)
			var/datum/design/D = SSresearch.techweb_design_by_id(v)
			if(D.build_type & MECHFAB)
				if(D.id == T)
					var/obj/part = D.build_path
					temp = {"<h1>[initial(part.name)] description:</h1>
								[initial(part.desc)]<br>
								<a href='?src=[REF(src)];clear_temp=1'>Return</a>
								"}
					break

	if(href_list["remove_mat"] && href_list["material"])
		var/datum/material/Mat = locate(href_list["material"])
		eject_sheets(Mat, text2num(href_list["remove_mat"]))

	updateUsrDialog()
	return

/obj/machinery/mecha_part_fabricator/proc/process_queue()
	var/datum/design/D = queue[1]
	if(!D)
		remove_from_queue(1)
		if(queue.len)
			return process_queue()
		else
			return
	temp = null
	while(D)
		if(stat&(NOPOWER|BROKEN))
			return FALSE
		if(build_part(D))
			remove_from_queue(1)
		else
			return FALSE
		D = listgetindex(queue, 1)
	say("Queue processing finished successfully.")

/obj/machinery/mecha_part_fabricator/proc/do_process_queue()		
	if(processing_queue || being_built)		
		return FALSE		
	processing_queue = 1
	process_queue()		
	processing_queue = 0

/obj/machinery/mecha_part_fabricator/proc/eject_sheets(eject_sheet, eject_amt)
	var/datum/component/material_container/mat_container = rmat.mat_container
	if (!mat_container)
		say("No access to material storage, please contact the quartermaster.")
		return 0
	if (rmat.on_hold())
		say("Mineral access is on hold, please contact the quartermaster.")
		return 0
	var/count = mat_container.retrieve_sheets(text2num(eject_amt), eject_sheet, drop_location())
	var/list/matlist = list()
	matlist[eject_sheet] = text2num(eject_amt)
	rmat.silo_log(src, "ejected", -count, "sheets", matlist)
	return count

/obj/machinery/mecha_part_fabricator/maint
	link_on_init = FALSE

