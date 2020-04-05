#define ATTRIBUTE_STRENGTH 1
#define ATTRIBUTE_DEXTERITY 2
#define ATTRIBUTE_AGILITY 3
#define ATTRIBUTE_CONSTITUTION 4
#define ATTRIBUTE_INTELLIGENCE 5

/datum/attribute
	var/name = "Character stat"
	var/desc = "Basic characteristic, you are not supposed to see this. Report to admins."
	var/id = 0
	var/base_value = 20

/datum/attribute/strength
	name = "Strength"
	desc = "Character's physical strength. Increases proficiency in unarmed combat, makes your grabs harder to break out of and makes athletic tasks easier."
	id = ATTRIBUTE_STRENGTH

/datum/attribute/dexterity
	name = "Dexterity"
	desc = "Character's skill in performing tasks, especially with the hands. Increases accuracy with weapons, helps you catch thrown items and allows you to disarm people with more ease."
	id = ATTRIBUTE_DEXTERITY

/datum/attribute/agility
	name = "Agility"
	desc = "Character's finesse in movement and action. Helps you move quicker, keep steady foot on slippery surfaces and avoid caltrops when moving and makes it easier to wriggle out of grabs."
	id = ATTRIBUTE_AGILITY

/datum/attribute/constitution
	name = "Constitution"
	desc = "Character's ability to endure rough conditions. Increases maximum life and stamina and makes your alcohol tolerance higher."
	id = ATTRIBUTE_CONSTITUTION

/datum/attribute/intelligence
	name = "Intelligence"
	desc = "Character's wits. Helps you perform mental tasks aswell as those you're not trained in."
	id = ATTRIBUTE_INTELLIGENCE