/datum/surgery/robot_restore_looks
	name = "Full chassis overhaul (Full heal/'cloning')"
	steps = list(
	/datum/surgery_step/mechanic_unwrench,
	/datum/surgery_step/pry_off_plating/fullbody,
	/datum/surgery_step/cut_wires/fullbody,
	/datum/surgery_step/replace_wires/fullbody,
	/datum/surgery_step/prepare_electronics,
	/datum/surgery_step/add_plating/fullbody,
	/datum/surgery_step/weld_plating/fullbody,
	/datum/surgery_step/finalize_chassis_overhaul)

	target_mobtypes = list(/mob/living/carbon/human, /mob/living/carbon/monkey)
	possible_locs = list(BODY_ZONE_CHEST)
	requires_bodypart_type = BODYPART_ROBOTIC
	desc = "A surgical procedure that rebuilds a synthetic unit from their skeleton to full integrity, recommended if they are damaged far beyond repair."