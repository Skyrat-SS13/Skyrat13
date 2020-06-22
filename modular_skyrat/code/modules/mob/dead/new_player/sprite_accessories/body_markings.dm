/datum/sprite_accessory/mam_body_markings/floof
	name = "BellyFloof"
	icon_state = "floof"
	icon = 'modular_skyrat/icons/mob/skyrat_markings.dmi'

/datum/sprite_accessory/mam_body_markings/floofer
	name = "BellyFloofTertiary"
	icon_state = "floofer"
	icon = 'modular_skyrat/icons/mob/skyrat_markings.dmi'

/datum/sprite_accessory/mam_body_markings/handsfeet_rat
	name = "Rat"
	icon_state = "rat"
	icon = 'modular_skyrat/icons/mob/skyrat_markings.dmi'

/datum/sprite_accessory/mam_body_markings/handsfeet_sloth
	name = "Sloth"
	icon_state = "sloth"
	icon = 'modular_skyrat/icons/mob/skyrat_markings.dmi'

/datum/sprite_accessory/body_markings/colorbelly
	name = "Coloured Belly"
	color_src = MATRIXED
	icon_state = "colorbelly"
	icon = 'modular_skyrat/icons/mob/skyrat_markings.dmi'

//VORE markings
/* i need to unfuck all of these later for our marking system, for now only spriteless markings
/datum/sprite_accessory/adv_marking
	icon = 'modular_skyrat/icons/mob/adv_markings/markings.dmi'
	//Empty list is unrestricted. Should only restrict the ones that make NO SENSE on other species.
	var/list/species_allowed = list()
	//Body zones that this accessory can go on.
	var/list/body_parts = list()

/datum/sprite_accessory/adv_marking/tat_heart
	name = "Tattoo (Heart)"
	icon_state = "tat_heart"
	body_parts = list(BODY_ZONE_CHEST)

/datum/sprite_accessory/adv_marking/tat_hive
	name = "Tattoo (Hive)"
	icon_state = "tat_hive"
	body_parts = list(BODY_ZONE_CHEST)

/datum/sprite_accessory/adv_marking/tat_nightling
	name = "Tattoo (Nightling)"
	icon_state = "tat_nightling"
	body_parts = list(BODY_ZONE_CHEST)

/datum/sprite_accessory/adv_marking/tat_campbell
	name = "Tattoo (Campbell)"
	icon_state = "tat_campbell"
	body_parts = list(BODY_ZONE_R_ARM, BODY_ZONE_L_ARM, BODY_ZONE_R_LEG, BODY_ZONE_L_LEG)

/datum/sprite_accessory/adv_marking/tat_silverburgh
	name = "Tattoo (Silverburgh)"
	icon_state = "tat_silverburgh"
	body_parts = list (BODY_ZONE_R_LEG, BODY_ZONE_L_LEG)

/datum/sprite_accessory/adv_marking/tat_tiger
	name = "Tattoo (Tiger Stripes)"
	icon_state = "tat_tiger"
	body_parts = list(BODY_ZONE_HEAD, BODY_ZONE_CHEST, BODY_ZONE_PRECISE_GROIN,
					BODY_ZONE_L_ARM, BODY_ZONE_PRECISE_L_HAND,
					BODY_ZONE_R_ARM, BODY_ZONE_PRECISE_R_HAND,
					BODY_ZONE_L_LEG, BODY_ZONE_PRECISE_L_FOOT,
					BODY_ZONE_R_LEG, BODY_ZONE_PRECISE_R_FOOT)

/datum/sprite_accessory/adv_marking/taj_paw_socks
	name = "Socks Coloration (Cat)"
	icon_state = "taj_pawsocks"
	body_parts = list(BODY_ZONE_L_ARM, BODY_ZONE_PRECISE_L_HAND,
					BODY_ZONE_R_ARM, BODY_ZONE_PRECISE_R_HAND,
					BODY_ZONE_L_LEG, BODY_ZONE_PRECISE_L_FOOT,
					BODY_ZONE_R_LEG, BODY_ZONE_PRECISE_R_FOOT)

/datum/sprite_accessory/adv_marking/una_paw_socks
	name = "Socks Coloration (Lizard)"
	icon_state = "una_pawsocks"
	body_parts = list(BODY_ZONE_L_ARM, BODY_ZONE_PRECISE_L_HAND,
					BODY_ZONE_R_ARM, BODY_ZONE_PRECISE_R_HAND,
					BODY_ZONE_L_LEG, BODY_ZONE_PRECISE_L_FOOT,
					BODY_ZONE_R_LEG, BODY_ZONE_PRECISE_R_FOOT)

/datum/sprite_accessory/adv_marking/paw_socks
	name = "Socks Coloration (Generic)"
	icon_state = "pawsocks"
	body_parts = list(BODY_ZONE_L_ARM, BODY_ZONE_PRECISE_L_HAND,
					BODY_ZONE_R_ARM, BODY_ZONE_PRECISE_R_HAND,
					BODY_ZONE_L_LEG, BODY_ZONE_PRECISE_L_FOOT,
					BODY_ZONE_R_LEG, BODY_ZONE_PRECISE_R_FOOT)

/datum/sprite_accessory/adv_marking/paw_socks_belly
	name = "Socks,Belly Coloration (Generic)"
	icon_state = "pawsocksbelly"
	body_parts = list(BODY_ZONE_CHEST, BODY_ZONE_PRECISE_GROIN,
					BODY_ZONE_L_ARM, BODY_ZONE_PRECISE_L_HAND,
					BODY_ZONE_R_ARM, BODY_ZONE_PRECISE_R_HAND,
					BODY_ZONE_L_LEG, BODY_ZONE_PRECISE_L_FOOT,
					BODY_ZONE_R_LEG, BODY_ZONE_PRECISE_R_FOOT)

/datum/sprite_accessory/adv_marking/belly_hands_feet
	name = "Hands,Feet,Belly Color (Minor)"
	icon_state = "bellyhandsfeetsmall"
	body_parts = list(BODY_ZONE_CHEST, BODY_ZONE_PRECISE_GROIN,
					BODY_ZONE_L_ARM, BODY_ZONE_PRECISE_L_HAND,
					BODY_ZONE_R_ARM, BODY_ZONE_PRECISE_R_HAND,
					BODY_ZONE_L_LEG, BODY_ZONE_PRECISE_L_FOOT,
					BODY_ZONE_R_LEG, BODY_ZONE_PRECISE_R_FOOT)

/datum/sprite_accessory/adv_marking/hands_feet_belly_full
	name = "Hands,Feet,Belly Color (Major)"
	icon_state = "bellyhandsfeet"
	body_parts = list(BODY_ZONE_CHEST, BODY_ZONE_PRECISE_GROIN,
					BODY_ZONE_L_ARM, BODY_ZONE_PRECISE_L_HAND,
					BODY_ZONE_R_ARM, BODY_ZONE_PRECISE_R_HAND,
					BODY_ZONE_L_LEG, BODY_ZONE_PRECISE_L_FOOT,
					BODY_ZONE_R_LEG, BODY_ZONE_PRECISE_R_FOOT)

/datum/sprite_accessory/adv_marking/hands_feet_belly_full_female
	name = "Hands,Feet,Belly Color (Major, Female)"
	icon_state = "bellyhandsfeet_female"
	body_parts = list(BODY_ZONE_CHEST, BODY_ZONE_PRECISE_GROIN,
					BODY_ZONE_L_ARM, BODY_ZONE_PRECISE_L_HAND,
					BODY_ZONE_R_ARM, BODY_ZONE_PRECISE_R_HAND,
					BODY_ZONE_L_LEG, BODY_ZONE_PRECISE_L_FOOT,
					BODY_ZONE_R_LEG, BODY_ZONE_PRECISE_R_FOOT)

/datum/sprite_accessory/adv_marking/patches
	name = "Color Patches"
	icon_state = "patches"
	body_parts = list(BODY_ZONE_CHEST, BODY_ZONE_PRECISE_GROIN,
					BODY_ZONE_L_ARM, BODY_ZONE_PRECISE_L_HAND,
					BODY_ZONE_R_ARM, BODY_ZONE_PRECISE_R_HAND,
					BODY_ZONE_L_LEG, BODY_ZONE_PRECISE_L_FOOT,
					BODY_ZONE_R_LEG, BODY_ZONE_PRECISE_R_FOOT)

/datum/sprite_accessory/adv_marking/patchesface
	name = "Color Patches (Face)"
	icon_state = "patchesface"
	body_parts = list(BODY_ZONE_HEAD)

/datum/sprite_accessory/adv_marking/bands
	name = "Color Bands"
	icon_state = "bands"
	body_parts = list(BODY_ZONE_CHEST, BODY_ZONE_PRECISE_GROIN,
					BODY_ZONE_L_ARM, BODY_ZONE_PRECISE_L_HAND,
					BODY_ZONE_R_ARM, BODY_ZONE_PRECISE_R_HAND,
					BODY_ZONE_L_LEG, BODY_ZONE_PRECISE_L_FOOT,
					BODY_ZONE_R_LEG, BODY_ZONE_PRECISE_R_FOOT)

/datum/sprite_accessory/adv_marking/bandsface
	name = "Color Bands (Face)"
	icon_state = "bandsface"
	body_parts = list(BODY_ZONE_HEAD)

/datum/sprite_accessory/adv_marking/tiger_stripes
	name = "Tiger Stripes"
	icon_state = "tiger"
	body_parts = list(BODY_ZONE_CHEST, BODY_ZONE_PRECISE_GROIN,
					BODY_ZONE_L_ARM, BODY_ZONE_PRECISE_L_HAND,
					BODY_ZONE_R_ARM, BODY_ZONE_PRECISE_R_HAND,
					BODY_ZONE_L_LEG, BODY_ZONE_PRECISE_L_FOOT,
					BODY_ZONE_R_LEG, BODY_ZONE_PRECISE_R_FOOT) //There's a tattoo for non-cats

/datum/sprite_accessory/adv_marking/tigerhead
	name = "Tiger Stripes (Head, Minor)"
	icon_state = "tigerhead"
	body_parts = list(BODY_ZONE_HEAD)

/datum/sprite_accessory/adv_marking/tigerface
	name = "Tiger Stripes (Head, Major)"
	icon_state = "tigerface"
	body_parts = list(BODY_ZONE_HEAD) //There's a tattoo for non-cats

/datum/sprite_accessory/adv_marking/backstripe
	name = "Back Stripe"
	icon_state = "backstripe"
	body_parts = list(BODY_ZONE_CHEST)

/datum/sprite_accessory/adv_marking/heterochromia
	name = "Heterochromia (right eye)"
	icon_state = "heterochromia"
	body_parts = list(BODY_ZONE_HEAD)

//Taj specific stuff
/datum/sprite_accessory/adv_marking/taj_belly
	name = "Belly Fur (Cat)"
	icon_state = "taj_belly"
	body_parts = list(BODY_ZONE_CHEST)

/datum/sprite_accessory/adv_marking/taj_bellyfull
	name = "Belly Fur Wide (Cat)"
	icon_state = "taj_bellyfull"
	body_parts = list(BODY_ZONE_CHEST)

/datum/sprite_accessory/adv_marking/taj_earsout
	name = "Outer Ear (Cat)"
	icon_state = "taj_earsout"
	body_parts = list(BODY_ZONE_HEAD)

/datum/sprite_accessory/adv_marking/taj_earsin
	name = "Inner Ear (Cat)"
	icon_state = "taj_earsin"
	body_parts = list(BODY_ZONE_HEAD)

/datum/sprite_accessory/adv_marking/taj_nose
	name = "Nose Color (Cat)"
	icon_state = "taj_nose"
	body_parts = list(BODY_ZONE_HEAD)

/datum/sprite_accessory/adv_marking/taj_crest
	name = "Chest Fur Crest (Cat)"
	icon_state = "taj_crest"
	body_parts = list(BODY_ZONE_CHEST)

/datum/sprite_accessory/adv_marking/taj_muzzle
	name = "Muzzle Color (Cat)"
	icon_state = "taj_muzzle"
	body_parts = list(BODY_ZONE_HEAD)

/datum/sprite_accessory/adv_marking/taj_face
	name = "Cheeks Color (Cat)"
	icon_state = "taj_face"
	body_parts = list(BODY_ZONE_HEAD)

/datum/sprite_accessory/adv_marking/taj_all
	name = "All Taj Head (Cat)"
	icon_state = "taj_all"
	body_parts = list(BODY_ZONE_HEAD)

//Una specific stuff
/datum/sprite_accessory/adv_marking/una_face
	name = "Face Color (Lizard)"
	icon_state = "una_face"
	body_parts = list(BODY_ZONE_HEAD)

/datum/sprite_accessory/adv_marking/una_facelow
	name = "Face Color Low (Lizard)"
	icon_state = "una_facelow"
	body_parts = list(BODY_ZONE_HEAD)

/datum/sprite_accessory/adv_marking/una_scutes
	name = "Scutes (Lizard)"
	icon_state = "una_scutes"
	body_parts = list(BODY_ZONE_CHEST)

/datum/sprite_accessory/adv_marking/vr
	icon = 'modular_skyrat/icons/mob/adv_markings/markings_vr.dmi'

/datum/sprite_accessory/adv_marking/vr/vulp_belly
	name = "belly fur (Vulp)"
	icon_state = "vulp_belly"
	body_parts = list(BODY_ZONE_CHEST)

/datum/sprite_accessory/adv_marking/vr/vulp_fullbelly
	name = "full belly fur (Vulp)"
	icon_state = "vulp_fullbelly"
	body_parts = list(BODY_ZONE_CHEST)

/datum/sprite_accessory/adv_marking/vr/vulp_crest
	name = "belly crest (Vulp)"
	icon_state = "vulp_crest"
	body_parts = list(BODY_ZONE_CHEST)

/datum/sprite_accessory/adv_marking/vr/vulp_nose
	name = "nose (Vulp)"
	icon_state = "vulp_nose"
	body_parts = list(BODY_ZONE_HEAD)

/datum/sprite_accessory/adv_marking/vr/vulp_short_nose
	name = "nose, short (Vulp)"
	icon_state = "vulp_short_nose"
	body_parts = list(BODY_ZONE_HEAD)

/datum/sprite_accessory/adv_marking/vr/snoutstripe
	name = "snout stripe (Vulp)"
	icon_state = "snoutstripe"
	body_parts = list(BODY_ZONE_HEAD)

/datum/sprite_accessory/adv_marking/vr/vulp_face
	name = "face (Vulp)"
	icon_state = "vulp_face"
	body_parts = list(BODY_ZONE_HEAD)

/datum/sprite_accessory/adv_marking/vr/vulp_facealt
	name = "face, alt. (Vulp)"
	icon_state = "vulp_facealt"
	body_parts = list(BODY_ZONE_HEAD)

/datum/sprite_accessory/adv_marking/vr/vulp_earsface
	name = "ears and face (Vulp)"
	icon_state = "vulp_earsface"
	body_parts = list(BODY_ZONE_HEAD)

/datum/sprite_accessory/adv_marking/vr/vulp_all
	name = "all head highlights (Vulp)"
	icon_state = "vulp_all"
	body_parts = list(BODY_ZONE_HEAD)
/*
sergal_full
	name = "Sergal Markings"
	icon_state = "sergal_full"
	body_parts = list(BP_L_FOOT,BP_R_FOOT,BP_L_LEG,BP_R_LEG,BP_L_ARM,BP_R_ARM,BP_L_HAND,BP_R_HAND,BODY_ZONE_PRECISE_GROIN,BODY_ZONE_CHEST,BODY_ZONE_HEAD)
	species_allowed = list("Sergal")

sergal_full_female
	name = "Sergal Markings (Female)"
	icon_state = "sergal_full_female"
	body_parts = list(BP_L_FOOT,BP_R_FOOT,BP_L_LEG,BP_R_LEG,BP_L_ARM,BP_R_ARM,BP_L_HAND,BP_R_HAND,BODY_ZONE_PRECISE_GROIN,BODY_ZONE_CHEST,BODY_ZONE_HEAD)
	species_allowed = list("Sergal")
*/
/datum/sprite_accessory/adv_marking/vr/monoeye
	name = "Monoeye"
	icon_state = "monoeye"
	body_parts = list(BODY_ZONE_HEAD)

/datum/sprite_accessory/adv_marking/vr/spidereyes
	name = "Spider Eyes"
	icon_state = "spidereyes"
	body_parts = list(BODY_ZONE_HEAD)

/datum/sprite_accessory/adv_marking/vr/sergaleyes
	name = "Sergal Eyes"
	icon_state = "eyes_sergal"
	body_parts = list(BODY_ZONE_HEAD)

/datum/sprite_accessory/adv_marking/vr/brows
	name = "Eyebrows"
	icon_state = "brows"
	body_parts = list(BODY_ZONE_HEAD)

/datum/sprite_accessory/adv_marking/vr/nevrean_female
	name = "Female Nevrean beak"
	icon_state = "nevrean_f"
	body_parts = list(BODY_ZONE_HEAD)

/datum/sprite_accessory/adv_marking/vr/nevrean_male
	name = "Male Nevrean beak"
	icon_state = "nevrean_m"
	body_parts = list(BODY_ZONE_HEAD)
/*
spots
	name = "Spots"
	icon_state = "spots"
	body_parts = list(BP_L_FOOT,BP_R_FOOT,BP_L_LEG,BP_R_LEG,BP_L_ARM,BP_R_ARM,BP_L_HAND,BP_R_HAND,BODY_ZONE_PRECISE_GROIN,BODY_ZONE_CHEST)
*/

/datum/sprite_accessory/adv_marking/vr/shaggy_mane
	name = "Shaggy mane/feathers"
	icon_state = "shaggy"
	body_parts = list(BODY_ZONE_CHEST)

/datum/sprite_accessory/adv_marking/vr/jagged_teeth
	name = "Jagged teeth"
	icon_state = "jagged"
	body_parts = list(BODY_ZONE_HEAD)

/datum/sprite_accessory/adv_marking/vr/blank_face
	name = "Blank round face (use with monster mouth)"
	icon_state = "blankface"
	body_parts = list(BODY_ZONE_HEAD)

/datum/sprite_accessory/adv_marking/vr/monster_mouth
	name = "Monster mouth"
	icon_state = "monster"
	body_parts = list(BODY_ZONE_HEAD)

/datum/sprite_accessory/adv_marking/vr/saber_teeth
	name = "Saber teeth"
	icon_state = "saber"
	body_parts = list(BODY_ZONE_HEAD)

/datum/sprite_accessory/adv_marking/vr/fangs
	name = "Fangs"
	icon_state = "fangs"
	body_parts = list(BODY_ZONE_HEAD)

/datum/sprite_accessory/adv_marking/vr/tusks
	name = "Tusks"
	icon_state = "tusks"
	body_parts = list(BODY_ZONE_HEAD)

/datum/sprite_accessory/adv_marking/vr/otie_face
	name = "Otie face"
	icon_state = "otieface"
	body_parts = list(BODY_ZONE_HEAD)

/datum/sprite_accessory/adv_marking/vr/otie_nose
	name = "Otie nose"
	icon_state = "otie_nose"
	body_parts = list(BODY_ZONE_HEAD)

/datum/sprite_accessory/adv_marking/vr/otienose_lite
	name = "Short otie nose"
	icon_state = "otienose_lite"
	body_parts = list(BODY_ZONE_HEAD)

/datum/sprite_accessory/adv_marking/vr/backstripes
	name = "Back stripes"
	icon_state = "otiestripes"
	body_parts = list(BODY_ZONE_CHEST)

/datum/sprite_accessory/adv_marking/vr/belly_butt
	name = "Belly and butt"
	icon_state = "bellyandbutt"
	body_parts = list(BODY_ZONE_CHEST)

fingers_toes
	name = "Fingers and toes"
	icon_state = "fingerstoes"
	body_parts = list(BP_L_FOOT,BP_R_FOOT,BP_L_HAND,BP_R_HAND)

otie_socks
	name = "Fingerless socks"
	icon_state = "otiesocks"
	body_parts = list(BP_L_FOOT,BP_R_FOOT,BP_L_LEG,BP_R_LEG,BP_L_ARM,BP_R_ARM,BP_L_HAND,BP_R_HAND)

corvid_beak
	name = "Corvid beak"
	icon_state = "corvidbeak"
	body_parts = list(BODY_ZONE_HEAD)

corvid_belly
	name = "Corvid belly"
	icon_state = "corvidbelly"
	body_parts = list(BODY_ZONE_PRECISE_GROIN,BODY_ZONE_CHEST,BODY_ZONE_HEAD)

cow_body
	name = "Cow markings"
	icon_state = "cowbody"
	body_parts = list(BP_L_FOOT,BP_R_FOOT,BP_L_LEG,BP_R_LEG,BP_L_ARM,BP_R_ARM,BP_L_HAND,BP_R_HAND,BODY_ZONE_PRECISE_GROIN,BODY_ZONE_CHEST,BODY_ZONE_HEAD)

cow_nose
	name = "Cow nose"
	icon_state = "cownose"
	body_parts = list(BODY_ZONE_HEAD)

zmask
	name = "Eye mask"
	icon_state = "zmask"
	body_parts = list(BODY_ZONE_HEAD)

zbody
	name = "Thick jagged stripes"
	icon_state = "zbody"
	body_parts = list(BP_L_LEG,BP_R_LEG,BODY_ZONE_PRECISE_GROIN,BODY_ZONE_CHEST)

znose
	name = "Jagged snout"
	icon_state = "znose"
	body_parts = list(BODY_ZONE_HEAD)

otter_nose
	name = "Otter nose"
	icon_state = "otternose"
	body_parts = list(BODY_ZONE_HEAD)

otter_face
	name = "Otter face"
	icon_state = "otterface"
	body_parts = list(BODY_ZONE_HEAD)

deer_face
	name = "Deer face"
	icon_state = "deerface"
	body_parts = list(BODY_ZONE_HEAD)

sharkface
	name = "Akula snout"
	icon_state = "sharkface"
	body_parts = list(BODY_ZONE_HEAD)

sheppy_face
	name = "Shepherd snout"
	icon_state = "shepface"
	body_parts = list(BODY_ZONE_HEAD)

sheppy_back
	name = "Shepherd back"
	icon_state = "shepback"
	body_parts = list(BODY_ZONE_CHEST,BODY_ZONE_PRECISE_GROIN)

zorren_belly_male
	name = "Zorren Male Torso"
	icon_state = "zorren_belly"
	body_parts = list(BODY_ZONE_CHEST,BODY_ZONE_PRECISE_GROIN)

zorren_belly_female
	name = "Zorren Female Torso"
	icon_state = "zorren_belly_female"
	body_parts = list(BODY_ZONE_CHEST,BODY_ZONE_PRECISE_GROIN)

zorren_back_patch
	name = "Zorren Back Patch"
	icon_state = "zorren_backpatch"
	body_parts = list(BODY_ZONE_CHEST)

zorren_face_male
	name = "Zorren Male Face"
	icon_state = "zorren_face"
	body_parts = list(BODY_ZONE_HEAD)

zorren_face_female
	name = "Zorren Female Face"
	icon_state = "zorren_face_female"
	body_parts = list(BODY_ZONE_HEAD)

zorren_muzzle_male
	name = "Zorren Male Muzzle"
	icon_state = "zorren_muzzle"
	body_parts = list(BODY_ZONE_HEAD)

zorren_muzzle_female
	name = "Zorren Female Muzzle"
	icon_state = "zorren_muzzle_female"
	body_parts = list(BODY_ZONE_HEAD)

zorren_socks
	name = "Zorren Socks"
	icon_state = "zorren_socks"
	body_parts = list(BP_L_FOOT,BP_R_FOOT,BP_L_LEG,BP_R_LEG,BP_L_ARM,BP_R_ARM,BP_L_HAND,BP_R_HAND)

zorren_longsocks
	name = "Zorren Longsocks"
	icon_state = "zorren_longsocks"
	body_parts = list(BP_L_FOOT,BP_R_FOOT,BP_L_LEG,BP_R_LEG,BP_L_ARM,BP_R_ARM,BP_L_HAND,BP_R_HAND)

tesh_feathers
	name = "Teshari Feathers"
	icon_state = "tesh-feathers"
	body_parts = list(BP_L_FOOT,BP_R_FOOT,BP_L_HAND,BP_R_HAND)

harpy_feathers
	name = "Rapala leg Feather"
	icon_state = "harpy-feathers"
	body_parts = list(BP_L_LEG,BP_R_LEG)

harpy_legs
	name = "Rapala leg coloring"
	icon_state = "harpy-leg"
	body_parts = list(BP_L_FOOT,BP_R_FOOT,BP_L_LEG,BP_R_LEG)

chooves
	name = "Cloven hooves"
	icon_state = "chooves"
	body_parts = list(BP_L_FOOT,BP_R_FOOT)

alurane
	name = "Alurane Body"
	icon_state = "alurane"
	body_parts = list(BP_L_FOOT,BP_R_FOOT,BP_L_LEG,BP_R_LEG,BP_L_ARM,BP_R_ARM,BP_L_HAND,BP_R_HAND,BODY_ZONE_PRECISE_GROIN,BODY_ZONE_CHEST,BODY_ZONE_HEAD)
	ckeys_allowed = list("natje")

body_tone
	name = "Body toning (for emergency contrast loss)"
	icon_state = "btone"
	body_parts = list(BP_L_FOOT,BP_R_FOOT,BP_L_LEG,BP_R_LEG,BP_L_ARM,BP_R_ARM,BP_L_HAND,BP_R_HAND,BODY_ZONE_PRECISE_GROIN,BODY_ZONE_CHEST)

gloss
	name = "Full body gloss"
	icon_state = "gloss"
	body_parts = list(BP_L_FOOT,BP_R_FOOT,BP_L_LEG,BP_R_LEG,BP_L_ARM,BP_R_ARM,BP_L_HAND,BP_R_HAND,BODY_ZONE_PRECISE_GROIN,BODY_ZONE_CHEST,BODY_ZONE_HEAD)

eboop_panels
	name = "Eggnerd FBP panels"
	icon_state = "eboop"
	body_parts = list(BP_L_FOOT,BP_R_FOOT,BP_L_LEG,BP_R_LEG,BP_L_ARM,BP_R_ARM,BP_L_HAND,BP_R_HAND,BODY_ZONE_PRECISE_GROIN,BODY_ZONE_CHEST,BODY_ZONE_HEAD)

osocks_rarm
	name = "Modular Longsock (right arm)"
	icon_state = "osocks"
	body_parts = list(BP_R_ARM,BP_R_HAND)

osocks_larm
	name = "Modular Longsock (left arm)"
	icon_state = "osocks"
	body_parts = list(BP_L_ARM,BP_L_HAND)

osocks_rleg
	name = "Modular Longsock (right leg)"
	icon_state = "osocks"
	body_parts = list(BP_R_FOOT,BP_R_LEG)

osocks_lleg
	name = "Modular Longsock (left leg)"
	icon_state = "osocks"
	body_parts = list(BP_L_FOOT,BP_L_LEG)

animeeyesinner
	name = "Anime Eyes Inner"
	icon_state = "animeeyesinner"
	body_parts = list(BODY_ZONE_HEAD)

animeeyesouter
	name = "Anime Eyes Outer"
	icon_state = "animeeyesouter"
	body_parts = list(BODY_ZONE_HEAD)

panda_eye_marks
	name = "Panda Eye Markings"
	icon_state = "eyes_panda"
	body_parts = list(BODY_ZONE_HEAD)
	species_allowed = list("Human")

catwomantorso
	name = "Catwoman chest stripes"
	icon_state = "catwomanchest"
	body_parts = list(BODY_ZONE_CHEST)

catwomangroin
	name = "Catwoman groin stripes"
	icon_state = "catwomangroin"
	body_parts = list(BODY_ZONE_PRECISE_GROIN)

catwoman_rleg
	name = "Catwoman right leg stripes"
	icon_state = "catwomanright"
	body_parts = list(BP_R_LEG)

catwoman_lleg
	name = "Catwoman left leg stripes"
	icon_state = "catwomanleft"
	body_parts = list(BP_L_LEG)

teshi_small_feathers
	name = "Teshari small wingfeathers"
	icon_state = "teshi_sf"
	body_parts = list(BP_L_FOOT,BP_R_FOOT,BP_L_HAND,BP_R_HAND,BODY_ZONE_CHEST)

spirit_lights
	name = "Ward - Spirit FBP Lights"
	icon_state = "lights"
	body_parts = list(BP_L_LEG,BP_R_LEG,BP_L_ARM,BP_R_ARM,BP_L_HAND,BP_R_HAND,BODY_ZONE_CHEST,BODY_ZONE_HEAD)

spirit_lights_body
	name = "Ward - Spirit FBP Lights (body)"
	icon_state = "lights"
	body_parts = list(BP_L_LEG,BP_R_LEG,BP_L_ARM,BP_R_ARM,BP_L_HAND,BP_R_HAND,BODY_ZONE_CHEST)

spirit_lights_head
	name = "Ward - Spirit FBP Lights (head)"
	icon_state = "lights"
	body_parts = list(BODY_ZONE_HEAD)

spirit_panels
	name = "Ward - Spirit FBP Panels"
	icon_state = "panels"
	body_parts = list(BP_L_FOOT,BP_R_FOOT,BP_L_LEG,BP_R_LEG,BP_L_ARM,BP_R_ARM,BP_L_HAND,BP_R_HAND,BODY_ZONE_PRECISE_GROIN,BODY_ZONE_CHEST,BODY_ZONE_HEAD)

spirit_panels_body
	name = "Ward - Spirit FBP Panels (body)"
	icon_state = "panels"
	body_parts = list(BP_L_FOOT,BP_R_FOOT,BP_L_LEG,BP_R_LEG,BP_L_ARM,BP_R_ARM,BP_L_HAND,BP_R_HAND,BODY_ZONE_PRECISE_GROIN,BODY_ZONE_CHEST)

spirit_panels_head
	name = "Ward - Spirit FBP Panels (head)"
	icon_state = "panels"
	body_parts = list(BODY_ZONE_HEAD)

tentacle_head
	name = "Squid Head"
	icon_state = "tentaclehead"
	body_parts = list(BODY_ZONE_HEAD)

tentacle_mouth
	name = "Tentacle Mouth"
	icon_state = "tentaclemouth"
	body_parts = list(BODY_ZONE_HEAD)

rosette
	name = "Rosettes"
	icon_state = "rosette"
	body_parts = list(BP_L_FOOT,BP_R_FOOT,BP_L_LEG,BP_R_LEG,BP_L_ARM,BP_R_ARM,BP_L_HAND,BP_R_HAND,BODY_ZONE_PRECISE_GROIN,BODY_ZONE_CHEST,BODY_ZONE_HEAD)

werewolf_nose
	name = "Werewolf nose"
	icon = 'icons/mob/species/werebeast/werebeast_markings.dmi'
	icon_state = "werewolf_nose"
	body_parts = list(BODY_ZONE_HEAD)
	species_allowed = list(SPECIES_WEREBEAST)

werewolf_face
	name = "Werewolf face"
	icon = 'icons/mob/species/werebeast/werebeast_markings.dmi'
	icon_state = "werewolf"
	body_parts = list(BODY_ZONE_HEAD)
	species_allowed = list(SPECIES_WEREBEAST)

werewolf_belly
	name = "Werewolf belly"
	icon = 'icons/mob/species/werebeast/werebeast_markings.dmi'
	icon_state = "werewolf"
	body_parts = list(BODY_ZONE_PRECISE_GROIN,BODY_ZONE_CHEST)
	species_allowed = list(SPECIES_WEREBEAST)

werewolf_socks
	name = "Werewolf socks"
	icon = 'icons/mob/species/werebeast/werebeast_markings.dmi'
	icon_state = "werewolf"
	body_parts = list(BP_L_FOOT,BP_R_FOOT,BP_L_LEG,BP_R_LEG,BP_L_ARM,BP_R_ARM,BP_L_HAND,BP_R_HAND)
	species_allowed = list(SPECIES_WEREBEAST)

shadekin_snoot
	name = "Shadekin Snoot"
	icon_state = "shadekin-snoot"
	body_parts = list(BODY_ZONE_HEAD)
	species_allowed = list(SPECIES_SHADEKIN, SPECIES_SHADEKIN_CREW)

taj_nose_alt
	name = "Nose Color, alt. (Taj)"
	icon_state = "taj_nosealt"
	body_parts = list(BODY_ZONE_HEAD)

talons
	name = "Talons"
	icon_state = "talons"
	body_parts = list(BP_L_FOOT,BP_R_FOOT,BP_L_LEG,BP_R_LEG)

claws
	name = "Claws"
	icon_state = "claws"
	body_parts = list(BP_L_HAND,BP_R_HAND)

equine_snout //Why the long face? Works best with sergal bodytype.
	name = "Equine Snout"
	icon_state = "donkey"
	body_parts = list(BODY_ZONE_HEAD)

equine_nose
	name = "Equine Nose"
	icon_state = "dnose"
	body_parts = list(BODY_ZONE_HEAD)
*/
