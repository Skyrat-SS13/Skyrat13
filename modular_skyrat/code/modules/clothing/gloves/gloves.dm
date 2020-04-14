/obj/item/clothing/gloves/combat/blueshield
    name = "combat gloves"
    desc = "These tactical gloves appear to be unique, made out of double woven durathread fibers which make it fireproof as well as acid resistant"
    icon_state = "combat"
    item_state = "blackgloves"
    siemens_coefficient = 0
    permeability_coefficient = 0.05
    strip_delay = 80
    cold_protection = HANDS
    min_cold_protection_temperature = GLOVES_MIN_TEMP_PROTECT
    heat_protection = HANDS
    max_heat_protection_temperature = GLOVES_MAX_TEMP_PROTECT
    resistance_flags = FIRE_PROOF |  ACID_PROOF
    armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 100, "acid" = 100)
    strip_mod = 1.5