//skyrat fleshlights
// see: [/datum/wound/burn/proc/uv()]
/obj/item/flashlight/pen/paramedic
	name = "paramedic penlight"
	desc = "A high-powered UV penlight intended to help stave off infection in the field on serious burned patients. Probably really bad to look into."
	icon = 'modular_skyrat/icons/obj/lighting.dmi'
	icon_state = "penlight_surgical"
	/// Our current UV cooldown
	var/uv_cooldown = 0
	/// How long between UV fryings
	var/uv_cooldown_length = 1 MINUTES
	/// How much sanitization to apply to the burn wound
	var/uv_power = 1
