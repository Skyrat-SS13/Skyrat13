/datum/component/swarming
	var/offset_x = 0
	var/offset_y = 0
	var/is_swarming = FALSE
	var/list/swarm_members = list()

/datum/component/swarming/Initialize(max_x = 24, max_y = 24)
	offset_x = rand(-max_x, max_x)
	offset_y = rand(-max_y, max_y)

	RegisterSignal(parent, COMSIG_MOVABLE_CROSSED, .proc/join_swarm)
	RegisterSignal(parent, COMSIG_MOVABLE_UNCROSSED, .proc/leave_swarm)

/datum/component/swarming/proc/join_swarm(datum/source, atom/movable/AM)
	var/datum/component/swarming/other_swarm = AM.GetComponent(/datum/component/swarming)
	if(!other_swarm)
		return
	swarm()
	add_to_swarm_members(other_swarm) //Skyrat change
	other_swarm.swarm()
	other_swarm.add_to_swarm_members(src) //Skyrat change

/datum/component/swarming/proc/leave_swarm(datum/source, atom/movable/AM)
	var/datum/component/swarming/other_swarm = AM.GetComponent(/datum/component/swarming)
	if(!other_swarm || !(swarm_members[other_swarm])) //Skyrat change
		return
	remove_from_swarm_members(other_swarm) //Skyrat change
	if(!swarm_members.len)
		unswarm()
	other_swarm.remove_from_swarm_members(src) //Skyrat change
	if(!other_swarm.swarm_members.len)
		other_swarm.unswarm()

/datum/component/swarming/proc/swarm()
	var/atom/movable/owner = parent
	if(!is_swarming)
		is_swarming = TRUE
		animate(owner, pixel_x = owner.pixel_x + offset_x, pixel_y = owner.pixel_y + offset_y, time = 2)

/datum/component/swarming/proc/unswarm()
	var/atom/movable/owner = parent
	if(is_swarming)
		animate(owner, pixel_x = owner.pixel_x - offset_x, pixel_y = owner.pixel_y - offset_y, time = 2)
		is_swarming = FALSE

// Skyrat changes down below
/datum/component/swarming/proc/lose_other_swarm_reference(datum/source)
	var/datum/component/swarming/other_swarm = source
	remove_from_swarm_members(other_swarm)

/datum/component/swarming/Destroy()
	swarm_members.Cut()
	. = ..()

/datum/component/swarming/proc/add_to_swarm_members(datum/component/swarming/swarm_comp)
	if(swarm_members[swarm_comp])
		return
	swarm_members[swarm_comp] = TRUE
	RegisterSignal(swarm_comp, COMSIG_PARENT_QDELETING, .proc/lose_other_swarm_reference)

/datum/component/swarming/proc/remove_from_swarm_members(datum/component/swarming/swarm_comp)
	swarm_members -= swarm_comp
	UnregisterSignal(swarm_comp, COMSIG_PARENT_QDELETING)
// End of Skyrat changes
