#define ATTRIBUTE_STRENGTH "str"
#define ATTRIBUTE_DEXTERITY "dex"
#define ATTRIBUTE_AGILITY "agi"
#define ATTRIBUTE_CONSTITUTION "con"
#define ATTRIBUTE_INTELLIGENCE "int"

/datum/attribute
	var/name = "Character stat"
	var/abb = "STAT"
	var/desc = "Basic characteristic, you are not supposed to see this. Report to admins."
	var/id = 0
	var/base_value = 30
	var/add_max = 20
	var/subtract_max = -10

/datum/attribute/strength
	name = "Strength"
	abb = "STR"
	desc = "Character's physical strength. Increases proficiency in unarmed combat, makes your grabs harder to break out of and makes athletic tasks easier."
	id = ATTRIBUTE_STRENGTH

/datum/attribute/dexterity
	name = "Dexterity"
	abb = "DEX"
	desc = "Character's skill in performing tasks, especially with the hands. Increases accuracy with weapons, helps you catch thrown items and allows you to disarm people with more ease."
	id = ATTRIBUTE_DEXTERITY

/datum/attribute/agility
	name = "Agility"
	abb = "AGI"
	desc = "Character's finesse in movement and action. Helps you move quicker, keep steady foot on slippery surfaces and avoid caltrops when moving and makes it easier to wriggle out of grabs."
	id = ATTRIBUTE_AGILITY

/datum/attribute/constitution
	name = "Constitution"
	abb = "CON"
	desc = "Character's ability to endure rough conditions. Increases maximum life and stamina and makes your alcohol tolerance higher."
	id = ATTRIBUTE_CONSTITUTION

/datum/attribute/intelligence
	name = "Intelligence"
	abb = "INT"
	desc = "Character's wits. Helps you perform mental tasks aswell as those you're not trained in."
	id = ATTRIBUTE_INTELLIGENCE