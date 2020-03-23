/datum/component/construction/unordered/mecha_chassis/spawn_result()
	. = ..()
	var/atom/parent_atom = parent
	parent_atom.icon = 'modular_skyrat/icons/mecha/mech_construction.dmi'
