/* i don't know what this fucking did but it's fucked and prevents travis from going green
/datum/techweb_node/techfab
	id = "adv_fabrication"
	display_name = "Advanced Fabrication"
	description = "Advanced fabrication methods.."
	prereq_ids = list("high_efficiency")
	design_ids = list("techfab_sec", "techfab_med", "techfab_serv", "techfab_sup", "techfab_sci",)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 3000)
*/
/datum/techweb_node/wireless
	id = "wireless_charging"
	display_name = "Wireless charging"
	description = "Learn about the ability to send power through the air."
	prereq_ids = list("adv_power", "adv_engi")
	design_ids = list("wireless_guns", "wireless_cells")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 2500)
