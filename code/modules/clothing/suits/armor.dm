/obj/item/clothing/suit/armor
	allowed = null
	cold_protection = CHEST|GROIN
	min_cold_protection_temperature = ARMOR_MIN_TEMP_PROTECT
	heat_protection = CHEST|GROIN
	max_heat_protection_temperature = ARMOR_MAX_TEMP_PROTECT
	strip_delay = 60
	equip_delay_other = 40
	max_integrity = 250
	resistance_flags = NONE
	armor = list("melee" = 30, "bullet" = 30, "laser" = 30, "energy" = 10, "bomb" = 25, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 50, "wound" = 15)

/obj/item/clothing/suit/armor/Initialize()
	. = ..()
	if(!allowed)
		allowed = GLOB.security_vest_allowed

/obj/item/clothing/suit/armor/navyblue
	name = "security officer's jacket"
	desc = "This jacket is for those special occasions when a security officer isn't required to wear their armor."
	icon_state = "officerbluejacket"
	item_state = "officerbluejacket"
	body_parts_covered = CHEST|ARMS
	mutantrace_variation = STYLE_DIGITIGRADE|STYLE_NO_ANTHRO_ICON

/obj/item/clothing/suit/armor/vest
	name = "armor vest"
	desc = "A slim Type I armored vest that provides decent protection against most types of damage."
	icon_state = "armoralt"
	item_state = "armoralt"
	blood_overlay_type = "armor"
	dog_fashion = /datum/dog_fashion/back
	mutantrace_variation = STYLE_DIGITIGRADE|STYLE_NO_ANTHRO_ICON

/obj/item/clothing/suit/armor/vest/alt
	desc = "A Type I armored vest that provides decent protection against most types of damage."
	icon_state = "armor"
	item_state = "armor"

/obj/item/clothing/suit/armor/vest/old
	name = "degrading armor vest"
	desc = "Older generation Type 1 armored vest. Due to degradation over time the vest is far less maneuverable to move in."
	icon_state = "armor"
	item_state = "armor"
	slowdown = 1

/obj/item/clothing/suit/armor/vest/blueshirt
	name = "large armor vest"
	desc = "A large, yet comfortable piece of armor, protecting you from some threats."
	icon_state = "blueshift"
	item_state = "blueshift"
	custom_premium_price = PRICE_ABOVE_EXPENSIVE

/obj/item/clothing/suit/armor/hos
	name = "armored greatcoat"
	desc = "A greatcoat enhanced with a special alloy for some extra protection and style for those with a commanding presence."
	icon_state = "hos"
	item_state = "greatcoat"
	body_parts_covered = CHEST|GROIN|ARMS|LEGS
	armor = list("melee" = 30, "bullet" = 30, "laser" = 30, "energy" = 10, "bomb" = 25, "bio" = 0, "rad" = 0, "fire" = 70, "acid" = 90, "wound" = 20)
	cold_protection = CHEST|GROIN|LEGS|ARMS
	heat_protection = CHEST|GROIN|LEGS|ARMS
	strip_delay = 80
	mutantrace_variation = STYLE_DIGITIGRADE|STYLE_NO_ANTHRO_ICON

/obj/item/clothing/suit/armor/hos/navyblue
	name = "head of security's jacket"
	desc = "This piece of clothing was specifically designed for asserting superior authority."
	icon_state = "hosbluejacket"
	item_state = "hosbluejacket"
	body_parts_covered = CHEST|ARMS
	cold_protection = CHEST|ARMS
	heat_protection = CHEST|ARMS

/obj/item/clothing/suit/armor/hos/trenchcoat
	name = "armored trenchcoat"
	desc = "A trenchcoat enhanced with a special lightweight kevlar. The epitome of tactical plainclothes."
	icon_state = "hostrench"
	item_state = "hostrench"
	flags_inv = 0
	strip_delay = 80
	unique_reskin = list("Coat" = "hostrench", "Cloak" = "trenchcloak")

/obj/item/clothing/suit/armor/vest/warden
	name = "warden's jacket"
	desc = "A navy-blue armored jacket with blue shoulder designations and '/Warden/' stitched into one of the chest pockets."
	icon_state = "warden_alt"
	item_state = "armor"
	body_parts_covered = CHEST|GROIN|ARMS
	cold_protection = CHEST|GROIN|ARMS|HANDS
	heat_protection = CHEST|GROIN|ARMS|HANDS
	strip_delay = 70
	resistance_flags = FLAMMABLE
	dog_fashion = null
	mutantrace_variation = STYLE_DIGITIGRADE

/obj/item/clothing/suit/armor/vest/warden/alt
	name = "warden's armored jacket"
	desc = "A red jacket with silver rank pips and body armor strapped on top."
	icon_state = "warden_jacket"

/obj/item/clothing/suit/armor/vest/warden/navyblue
	name = "warden's jacket"
	desc = "Perfectly suited for the warden that wants to leave an impression of style on those who visit the brig."
	icon_state = "wardenbluejacket"
	item_state = "wardenbluejacket"
	body_parts_covered = CHEST|ARMS
	mutantrace_variation = STYLE_DIGITIGRADE|STYLE_NO_ANTHRO_ICON

/obj/item/clothing/suit/armor/vest/leather
	name = "security overcoat"
	desc = "Lightly armored leather overcoat meant as casual wear for high-ranking officers. Bears the crest of Nanotrasen Security."
	icon_state = "leathercoat-sec"
	item_state = "hostrench"
	body_parts_covered = CHEST|GROIN|ARMS|LEGS
	cold_protection = CHEST|GROIN|LEGS|ARMS
	heat_protection = CHEST|GROIN|LEGS|ARMS
	dog_fashion = null

/obj/item/clothing/suit/armor/vest/capcarapace
	name = "captain's carapace"
	desc = "A fireproof armored chestpiece reinforced with ceramic plates and plasteel pauldrons to provide additional protection whilst still offering maximum mobility and flexibility. Issued only to the station's finest, although it does chafe your nipples."
	icon_state = "capcarapace"
	item_state = "armor"
	body_parts_covered = CHEST|GROIN
	armor = list("melee" = 50, "bullet" = 40, "laser" = 50, "energy" = 10, "bomb" = 25, "bio" = 0, "rad" = 0, "fire" = 100, "acid" = 90, "wound" = 30)
	dog_fashion = null
	resistance_flags = FIRE_PROOF

/obj/item/clothing/suit/armor/vest/capcarapace/syndicate
	name = "syndicate captain's vest"
	desc = "A sinister looking vest of advanced armor worn over a black and red fireproof jacket. The gold collar and shoulders denote that this belongs to a high ranking syndicate officer."
	icon_state = "syndievest"
	mutantrace_variation = STYLE_DIGITIGRADE

/obj/item/clothing/suit/armor/vest/capcarapace/alt
	name = "captain's parade jacket"
	desc = "For when an armoured vest isn't fashionable enough."
	icon_state = "capformal"
	item_state = "capspacesuit"

/obj/item/clothing/suit/armor/riot
	name = "riot suit"
	desc = "A suit of semi-flexible polycarbonate body armor with heavy padding to protect against melee attacks. Helps the wearer resist shoving in close quarters."
	icon_state = "riot"
	item_state = "swat_suit"
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	cold_protection = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	heat_protection = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	armor = list("melee" = 50, "bullet" = 10, "laser" = 10, "energy" = 10, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 80, "acid" = 80, "wound" = 30)
	blocks_shove_knockdown = TRUE
	strip_delay = 80
	equip_delay_other = 60

/obj/item/clothing/suit/armor/bone
	name = "bone armor"
	desc = "A tribal armor plate, crafted from animal bone."
	icon_state = "bonearmor"
	item_state = "bonearmor"
	blood_overlay_type = "armor"
	armor = list("melee" = 35, "bullet" = 25, "laser" = 25, "energy" = 10, "bomb" = 25, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 50, "wound" = 10)
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS

/obj/item/clothing/suit/armor/bulletproof
	name = "bulletproof armor"
	desc = "A Type III heavy bulletproof vest that excels in protecting the wearer against traditional projectile weaponry and explosives to a minor extent."
	icon_state = "bulletproof"
	item_state = "armor"
	blood_overlay_type = "armor"
	armor = list("melee" = 15, "bullet" = 60, "laser" = 10, "energy" = 10, "bomb" = 40, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 50, "wound" = 20)
	strip_delay = 70
	equip_delay_other = 50
	mutantrace_variation = STYLE_DIGITIGRADE|STYLE_NO_ANTHRO_ICON

/obj/item/clothing/suit/armor/laserproof
	name = "reflector vest"
	desc = "A vest that excels in protecting the wearer against energy projectiles, as well as occasionally reflecting them."
	icon_state = "armor_reflec"
	item_state = "armor_reflec"
	blood_overlay_type = "armor"
	armor = list("melee" = 10, "bullet" = 10, "laser" = 60, "energy" = 50, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 100, "acid" = 100, "wound" = 10)
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF
	mutantrace_variation = STYLE_DIGITIGRADE|STYLE_NO_ANTHRO_ICON
	var/hit_reflect_chance = 40
	var/list/protected_zones = list(BODY_ZONE_CHEST, BODY_ZONE_PRECISE_GROIN)

/obj/item/clothing/suit/armor/laserproof/run_block(mob/living/owner, atom/object, damage, attack_text, attack_type, armour_penetration, mob/attacker, def_zone, final_block_chance, list/block_return)
	if(def_zone in protected_zones)
		if(prob(hit_reflect_chance))
			return BLOCK_SHOULD_REDIRECT | BLOCK_REDIRECTED | BLOCK_SUCCESS | BLOCK_PHYSICAL_INTERNAL
	return ..()

/obj/item/clothing/suit/armor/vest/det_suit
	name = "detective's armor vest"
	desc = "An armored vest with a detective's badge on it."
	icon_state = "detective-armor"
	resistance_flags = FLAMMABLE
	dog_fashion = null

/obj/item/clothing/suit/armor/vest/det_suit/Initialize()
	. = ..()
	allowed = GLOB.detective_vest_allowed

/obj/item/clothing/suit/armor/vest/infiltrator
	name = "insidious combat vest"
	desc = "An insidious combat vest designed using Syndicate nanofibers to absorb the supreme majority of kinetic blows. Although it doesn't look like it'll do too much for energy impacts."
	icon_state = "infiltrator"
	item_state = "infiltrator"
	armor = list("melee" = 30, "bullet" = 40, "laser" = 20, "energy" = 30, "bomb" = 70, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 50, "wound" = 20)
	resistance_flags = FIRE_PROOF | ACID_PROOF
	strip_delay = 80

//All of the armor below is mostly unused

/obj/item/clothing/suit/armor/centcom
	name = "\improper CentCom armor"
	desc = "A suit that protects against some damage."
	icon_state = "centcom"
	item_state = "centcom"
	w_class = WEIGHT_CLASS_BULKY
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	allowed = list(/obj/item/gun/energy, /obj/item/melee/baton, /obj/item/restraints/handcuffs, /obj/item/tank/internals/emergency_oxygen, /obj/item/tank/internals/plasmaman)
	clothing_flags = THICKMATERIAL
	flags_inv = HIDEGLOVES|HIDESHOES|HIDEJUMPSUIT
	cold_protection = CHEST | GROIN | LEGS | FEET | ARMS | HANDS
	min_cold_protection_temperature = SPACE_SUIT_MIN_TEMP_PROTECT
	heat_protection = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	max_heat_protection_temperature = SPACE_SUIT_MAX_TEMP_PROTECT
	armor = list("melee" = 80, "bullet" = 80, "laser" = 50, "energy" = 50, "bomb" = 100, "bio" = 100, "rad" = 100, "fire" = 90, "acid" = 90, "wound" = 35)

/obj/item/clothing/suit/armor/heavy
	name = "heavy armor"
	desc = "A heavily armored suit that protects against moderate damage."
	icon_state = "heavy"
	item_state = "swat_suit"
	w_class = WEIGHT_CLASS_BULKY
	gas_transfer_coefficient = 0.9
	clothing_flags = THICKMATERIAL
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	slowdown = 3
	flags_inv = HIDEGLOVES|HIDESHOES|HIDEJUMPSUIT
	armor = list("melee" = 80, "bullet" = 80, "laser" = 50, "energy" = 50, "bomb" = 100, "bio" = 100, "rad" = 100, "fire" = 90, "acid" = 90, "wound" = 35)

/obj/item/clothing/suit/armor/tdome
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	flags_inv = HIDEGLOVES|HIDESHOES|HIDEJUMPSUIT
	clothing_flags = THICKMATERIAL
	cold_protection = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	heat_protection = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	armor = list("melee" = 80, "bullet" = 80, "laser" = 50, "energy" = 50, "bomb" = 100, "bio" = 100, "rad" = 100, "fire" = 90, "acid" = 90, "wound" = 35)

/obj/item/clothing/suit/armor/tdome/red
	name = "thunderdome suit"
	desc = "Reddish armor."
	icon_state = "tdred"
	item_state = "tdred"

/obj/item/clothing/suit/armor/tdome/green
	name = "thunderdome suit"
	desc = "Pukish armor."	//classy.
	icon_state = "tdgreen"
	item_state = "tdgreen"


/obj/item/clothing/suit/armor/riot/knight
	name = "plate armour"
	desc = "A classic suit of plate armour, highly effective at stopping melee attacks."
	icon_state = "knight_green"
	item_state = "knight_green"

/obj/item/clothing/suit/armor/riot/knight/yellow
	icon_state = "knight_yellow"
	item_state = "knight_yellow"

/obj/item/clothing/suit/armor/riot/knight/blue
	icon_state = "knight_blue"
	item_state = "knight_blue"

/obj/item/clothing/suit/armor/riot/knight/red
	icon_state = "knight_red"
	item_state = "knight_red"

/obj/item/clothing/suit/armor/riot/knight/greyscale
	name = "knight armour"
	desc = "A classic suit of armour, able to be made from many different materials."
	icon_state = "knight_greyscale"
	item_state = "knight_greyscale"
	armor = list("melee" = 35, "bullet" = 10, "laser" = 10, "energy" = 10, "bomb" = 10, "bio" = 10, "rad" = 10, "fire" = 40, "acid" = 40, "wound" = 15)
	material_flags = MATERIAL_ADD_PREFIX | MATERIAL_COLOR | MATERIAL_AFFECT_STATISTICS //Can change color and add prefix

/obj/item/clothing/suit/armor/vest/durathread
	name = "makeshift vest"
	desc = "A vest made of durathread with strips of leather acting as trauma plates."
	icon_state = "durathread"
	item_state = "durathread"
	strip_delay = 60
	equip_delay_other = 40
	max_integrity = 200
	resistance_flags = FLAMMABLE
	armor = list("melee" = 20, "bullet" = 10, "laser" = 30, "energy" = 5, "bomb" = 15, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 50, "wound" = 10)

/obj/item/clothing/suit/armor/vest/russian
	name = "russian vest"
	desc = "A bulletproof vest with forest camo. Good thing there's plenty of forests to hide in around here, right?"
	icon_state = "rus_armor"
	item_state = "rus_armor"
	armor = list("melee" = 25, "bullet" = 30, "laser" = 0, "energy" = 15, "bomb" = 10, "bio" = 0, "rad" = 20, "fire" = 20, "acid" = 50, "wound" = 10)

/obj/item/clothing/suit/armor/vest/russian_coat
	name = "russian battle coat"
	desc = "Used in extremly cold fronts, made out of real bears."
	icon_state = "rus_coat"
	item_state = "rus_coat"
	clothing_flags = THICKMATERIAL
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	cold_protection = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	min_cold_protection_temperature = SPACE_SUIT_MIN_TEMP_PROTECT
	armor = list("melee" = 25, "bullet" = 20, "laser" = 20, "energy" = 10, "bomb" = 20, "bio" = 50, "rad" = 20, "fire" = -10, "acid" = 50, "wound" = 10)

//New and improved Tech Armor
/obj/item/clothing/head/helmet/space/hardsuit/security_armor
	name = "type I techhelmet"
	desc = "A specialized exoskeleton armor helmet built into a suit of armor; offers decent protection, and comes with a flash-resistant HUD visor and headlamp."
	icon_state = "hardsuit0-secexo"
	item_state = "hardsuit0-secexo"
	hardsuit_type = "secexo"
	armor = list("melee" = 40, "bullet" = 30, "laser" = 30,"energy" = 10, "bomb" = 25, "bio" = 50, "rad" = 0, "fire" = 55, "acid" = 70, "wound" = 15)
	clothing_flags = THICKMATERIAL | BLOCK_GAS_SMOKE_EFFECT | ALLOWINTERNALS
	flags_inv = HIDEMASK|HIDEEARS|HIDEFACE|HIDEHAIR
	mutantrace_variation = STYLE_MUZZLE
	unique_reskin_icons = list(
	"Default" = 'icons/obj/clothing/hats.dmi',
	"ERT" = 'icons/obj/clothing/hats.dmi',
	"Classic" = 'icons/obj/clothing/hats.dmi',
	)
	unique_reskin_worn = list(
	"Default" = 'icons/mob/clothing/head.dmi',
	"ERT" = 'icons/mob/clothing/head.dmi',
	"Classic" = 'icons/mob/clothing/head.dmi',
	)
	unique_reskin_worn_anthro = list(
	"Default" = 'icons/mob/clothing/head_muzzled.dmi',
	"ERT" = 'icons/mob/clothing/head_muzzled.dmi',
	"Classic" = 'icons/mob/clothing/head_muzzled.dmi',
	)
	unique_reskin = list(
	"Default" = "hardsuit0-secexo",
	"ERT" = "hardsuit0-secexoX",
	"Classic" = "hardsuit0-secexoA",
	)
	unique_hardsuit_type = list(
	"Default" = "secexo",
	"ERT" = "secexoX",
	"Classic" = "secexoA",
	)

/obj/item/clothing/suit/space/hardsuit/security_armor
	name = "type I full-body techarmor"
	desc = "A specialized exoskeleton armor suit, comprised of flexible protective shielding. Comes equipped with a retractable helmet which offers a flash-resistant HUD visor, along with a headlamp."
	icon_state = "hardsuit-secexo"
	item_state = "hardsuit-secexo"
	max_integrity = 250
	armor = list("melee" = 30, "bullet" = 30, "laser" = 30, "energy" = 10, "bomb" = 25, "bio" = 50, "rad" = 0, "fire" = 55, "acid" = 70, "wound" = 15)
	allowed = list(/obj/item/ammo_box, /obj/item/ammo_casing, /obj/item/flashlight, /obj/item/gun/ballistic, /obj/item/gun/energy, /obj/item/kitchen/knife/combat, /obj/item/melee/baton, /obj/item/melee/classic_baton/telescopic, /obj/item/reagent_containers/spray/pepper, /obj/item/restraints/handcuffs, /obj/item/tank/internals/emergency_oxygen, /obj/item/tank/internals/plasmaman, /obj/item/blunderbuss) //I had to do this all snowflake style because it just would not accept any sort of global list, fucking kill me
	helmettype = /obj/item/clothing/head/helmet/space/hardsuit/security_armor
	clothing_flags = THICKMATERIAL
	mutantrace_variation = STYLE_DIGITIGRADE
	slowdown = 0
	anthro_mob_worn_overlay = 'icons/mob/clothing/suit_digi.dmi'
	flags_inv = NONE
	unique_reskin_icons = list(
	"Default" = 'icons/obj/clothing/suits.dmi',
	"ERT" = 'icons/obj/clothing/suits.dmi',
	"Classic" = 'icons/obj/clothing/suits.dmi',
	)
	unique_reskin_worn = list(
	"Default" = 'icons/mob/clothing/suit.dmi',
	"ERT" = 'icons/mob/clothing/suit.dmi',
	"Classic" = 'icons/mob/clothing/suit.dmi',
	)
	unique_reskin_worn_anthro = list(
	"Default" = 'icons/mob/clothing/suit_digi.dmi',
	"ERT" = 'icons/mob/clothing/suit_digi.dmi',
	"Classic" = 'icons/mob/clothing/suit_digi.dmi',
	)
	unique_reskin = list(
	"Default" = "hardsuit-secexo",
	"ERT" = "hardsuit-secexoX",
	"Classic" = "hardsuit-secexoA",
	)
	unique_hardsuit_type = list(
	"Default" = "secexo",
	"ERT" = "secexoX",
	"Classic" = "secexoA",
	)

/obj/item/clothing/suit/space/hardsuit/security_armor/Initialize()
	. = ..()
	if(!allowed)
		allowed = GLOB.security_vest_allowed

/obj/item/clothing/head/helmet/space/hardsuit/security_armor/equipped(mob/living/carbon/human/user, slot)
	..()
	if (slot == SLOT_HEAD)
		var/datum/atom_hud/DHUD = GLOB.huds[DATA_HUD_SECURITY_ADVANCED]
		DHUD.add_hud_to(user)

/obj/item/clothing/head/helmet/space/hardsuit/security_armor/dropped(mob/living/carbon/human/user)
	..()
	if (user.head == src)
		var/datum/atom_hud/DHUD = GLOB.huds[DATA_HUD_SECURITY_ADVANCED]
		DHUD.remove_hud_from(user)

/obj/item/clothing/suit/space/hardsuit/security_armor/cloaker //YOU CALL THIS RESISTING ARREST?
	name = "type II full-body techarmor"
	desc = "An advanced version of the standard techarmor, sporting far better protection. It does lack the night vision of its non-tech counterpart, however."
	icon_state = "hardsuit-cloaker" 
	item_state = "hardsuit-cloaker"
	armor = list("melee" = 40, "bullet" = 35, "laser" = 35, "energy" = 50, "bomb" = 20, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 100, "wound" = 25)
	helmettype = /obj/item/clothing/head/helmet/space/hardsuit/security_armor/cloaker

/obj/item/clothing/head/helmet/space/hardsuit/security_armor/cloaker //I couldn't get the NV to work. If someone else figures out how, please feel free to implement it here.
	name = "type II techhelmet"
	desc = "An advanced version of the standard techhelmet, sporting far better protection. Unfortunately, it lacks the night vision of its non-tech counterpart."
	icon_state = "hardsuit0-cloaker"
	item_state = "hardsuit0-cloaker"
	armor = list("melee" = 40, "bullet" = 35, "laser" = 35, "energy" = 50, "bomb" = 20, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 100, "wound" = 25)
	hardsuit_type = "cloaker"
	var/activated = FALSE
	var/stored_nv = 0

/obj/item/clothing/head/helmet/space/hardsuit/security_armor/hos
	name = "head of security's techhelmet"
	desc = "A specialized exoskeleton armor helmet built into a suit of armor; offers decent protection, and comes with a flash-resistant HUD visor and headlamp."
	icon_state = "hardsuit0-hosexo"
	item_state = "hardsuit0-hosexo"
	hardsuit_type = "hosexo"
	armor = list("melee" = 40, "bullet" = 30, "laser" = 25, "energy" = 10, "bomb" = 25, "bio" = 10, "rad" = 0, "fire" = 50, "acid" = 60, "wound" = 20)
	mutantrace_variation = NONE
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDESNOUT
	unique_reskin_icons = list(
	"Default" = 'icons/obj/clothing/hats.dmi',
	"Old" = 'icons/obj/clothing/hats.dmi',
	)
	unique_reskin_worn = list(
	"Default" = 'icons/mob/clothing/head.dmi',
	"Old" = 'icons/mob/clothing/head.dmi',
	)
	unique_reskin_worn_anthro = list(
	"Default" = 'icons/mob/clothing/head.dmi',
	"Old" = 'icons/mob/clothing/head.dmi',
	)
	unique_reskin = list(
	"Default" = "hardsuit0-hosexo",
	"Old" = "hardsuit0-hosexoX",
	)
	unique_hardsuit_type = list(
	"Default" = "hosexo",
	"Old" = "hosexoX",
	)

/obj/item/clothing/suit/space/hardsuit/security_armor/hos
	name = "head of security's techarmor"
	desc = "A specialized exoskeleton armor suit comprised of flexible protective shielding. This particular suit has been designed specifically for the station security commander."
	icon_state = "hardsuit-hosexo"
	item_state = "hardsuit-hosexo"
	max_integrity = 300
	armor = list("melee" = 35, "bullet" = 30, "laser" = 30, "energy" = 10, "bomb" = 25, "bio" = 50, "rad" = 0, "fire" = 70, "acid" = 90, "wound" = 20)
	helmettype = /obj/item/clothing/head/helmet/space/hardsuit/security_armor/hos
	flags_inv = HIDEGLOVES|HIDESHOES|HIDEJUMPSUIT|HIDETAUR
	unique_reskin_icons = list(
	"Default" = 'icons/obj/clothing/suits.dmi',
	"Old" = 'icons/obj/clothing/suits.dmi',
	)
	unique_reskin_worn = list(
	"Default" = 'icons/mob/clothing/suit.dmi',
	"Old" = 'icons/mob/clothing/suit.dmi',
	)
	unique_reskin_worn_anthro = list(
	"Default" = 'icons/mob/clothing/suit_digi.dmi',
	"Old" = 'icons/mob/clothing/suit_digi.dmi',
	)
	unique_reskin = list(
	"Default" = "hardsuit-hosexo",
	"Old" = "hardsuit-hosexoX",
	)
	unique_hardsuit_type = list(
	"Default" = "hosexo",
	"Old" = "hosexoX",
	)

/obj/item/clothing/suit/space/hardsuit/security_armor/blueshield
	name = "blueshield techarmor"
	desc = "The techarmor suit of Command's first line of defense."
	icon_state = "hardsuit-blueexo"
	item_state = "hardsuit-blueexo"
	max_integrity = 300
	armor = list("melee" = 35, "bullet" = 35, "laser" = 30, "energy" = 40, "bomb" = 25, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 75, "wound" = 25)
	helmettype = /obj/item/clothing/head/helmet/space/hardsuit/security_armor/blueshield

/obj/item/clothing/head/helmet/space/hardsuit/security_armor/blueshield
	name = "blueshield techarmor"
	desc = "The techarmor helmet of Command's first line of defense."
	icon_state = "hardsuit0-blueexo"
	item_state = "hardsuit0-blueexo"
	armor = list("melee" = 30, "bullet" = 20, "laser" = 20,"energy" = 10, "bomb" = 25, "bio" = 0, "rad" = 0, "fire" = 75, "acid" = 75, "wound" = 20)
	hardsuit_type = "blueexo"
	unique_reskin_icons = list(
	"Default" = 'icons/obj/clothing/suits.dmi',
	"MKI" = 'icons/obj/clothing/suits.dmi',
	)
	unique_reskin_worn = list(
	"Default" = 'icons/mob/clothing/suit.dmi',
	"MKI" = 'icons/mob/clothing/suit.dmi',
	)
	unique_reskin_worn_anthro = list(
	"Default" = 'icons/mob/clothing/suit_digi.dmi',
	"MKI" = 'icons/mob/clothing/suit_digi.dmi',
	)
	unique_reskin = list(
	"Default" = "hardsuit-blueexo",
	"MKI" = "hardsuit-blueexoX",
	)
	unique_hardsuit_type = list(
	"Default" = "blueexo",
	"MKI" = "blueexoX",
	)
