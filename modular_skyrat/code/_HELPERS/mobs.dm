//proc used to create perfect copies of dna and species.
/proc/copify_dna(datum/tocopy)
	if(!tocopy)
		return FALSE
	var/datum/D = new tocopy.type()
	for(var/V in (tocopy.vars - GLOB.duplicate_forbidden_vars - GLOB.duplicate_forbidden_vars_by_type[tocopy.type]))
		if(islist(tocopy.vars[V]))
			var/list/L = tocopy.vars[V]
			D.vars[V] = L.Copy()
		else if(istype(tocopy.vars[V], /datum/species) || istype(tocopy.vars[V], /datum/dna))
			D.vars[V] = copify_dna(tocopy.vars[V])
		else
			if(!istype(tocopy.vars[V], /datum))
				D.vars[V] = tocopy.vars[V]
			else if(istype(tocopy.vars[V], /atom))
				D.vars[V] = tocopy.vars[V]
	return D

//proc to copy a human's general appearance etc
/proc/copify_features(mob/living/carbon/human/H, copy_hairs = FALSE, copy_wings = FALSE)
	if(!istype(H))
		return FALSE
	var/list/features = list()
	features["gender"] = H.gender
	features["real_name"] = H.real_name
	features["name"] = H.name
	features["underwear"] = H.underwear
	features["undie_color"] = H.undie_color 
	features["undershirt"] = H.undershirt
	features["shirt_color"] = H.shirt_color
	features["skin_tone_override"] = H.dna.skin_tone_override
	features["skin_tone"] = H.skin_tone
	if(copy_hairs)
		features["hair_style"] = H.hair_style
		features["facial_hair_style"] = H.facial_hair_style
		features["hair_color"] = H.hair_color
		features["facial_hair_color"] = H.facial_hair_color
	else
		features["hair_style"] = "Bald"
		features["facial_hair_style"] = "Shaved"
		features["hair_color"] = "000"
		features["facial_hair_color"] = "000"
	features["eye_color"] = H.eye_color
	features["blood_type"] = H.dna.blood_type
	features["saved_underwear"] = H.underwear
	features["saved_undershirt"] = H.undershirt
	features["saved_socks"] = H.socks
	if(copy_wings)
		features["insect_wings"] = H.dna.features["insect_wings"]
		features["deco_wings"] = H.dna.features["deco_wings"]
	else
		features["insect_wings"] = "None"
		features["deco_wings"] = "None"
	return features

//proc to change a human's features based on a list made by the copify_features() proc
/proc/featurize_human(mob/living/carbon/human/H, list/features, paste_hairs = FALSE, paste_wings = FALSE)
	if(!istype(H) || !length(features))
		return FALSE
	H.gender = features["gender"]
	H.real_name = features["real_name"]
	H.name = features["name"]
	H.underwear = features["underwear"]
	H.undie_color = features["undie_color"]
	H.undershirt = features["undershirt"]
	H.shirt_color = features["shirt_color"]
	H.dna.skin_tone_override = features["skin_tone_override"]
	if(paste_hairs)
		H.hair_style = features["hair_style"]
		H.facial_hair_style = features["facial_hair_style"]
		H.hair_color = features["hair_color"]
		H.facial_hair_color = features["facial_hair_color"]
	if(paste_wings)
		H.dna.features["insect_wings"] = features["insect_wings"]
		H.dna.features["deco_wings"] = features["deco_wings"]
	H.skin_tone = features["skin_tone"]
	H.eye_color = features["eye_color"]
	H.dna.blood_type = features["blood_type"]
	H.underwear = features["saved_underwear"]
	H.undershirt = features["saved_undershirt"]
	H.socks = features["saved_socks"]
	return features

/proc/random_unique_vox_name(attempts_to_find_unique_name=10)
	for(var/i in 1 to attempts_to_find_unique_name)
		. = capitalize(vox_name())

		if(!findname(.))
			break

/mob/proc/isRobotic()
	return FALSE

/mob/living/carbon/human/isRobotic()
	if(dna && dna.species.inherent_biotypes & MOB_ROBOTIC)
		return TRUE
	else
		return FALSE
