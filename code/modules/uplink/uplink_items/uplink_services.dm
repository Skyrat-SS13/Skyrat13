/*
	Uplink Items:
	Unlike categories, uplink item entries are automatically sorted alphabetically on server init in a global list,
	When adding new entries to the file, please keep them sorted by category.
*/

/datum/uplink_item/services/fake_ion
	name = "Fake Ion Storm"
	desc = "Fakes an ion storm announcment. A good distraction, especially if the AI is weird anyway."
	item = /obj/item/announcer/ion
	cost = 4

/datum/uplink_item/services/fake_meteor
	name = "Fake Meteor Announcement"
	desc = "Fakes an meteor announcment. A good way to get any C4 on the station exterior, or really any small explosion, brushed off as a meteor hit."
	item = /obj/item/announcer/meteor
	cost = 8

/datum/uplink_item/services/fake_rod
	name = "Fake Immovable Rod"
	desc = "Fakes an immovable rod announcement. Good for a short-lasting distraction."
	item = /obj/item/announcer/rodgod
	cost = 4 //less likely to be believed 

/datum/uplink_item/services/virus
	name = "Fake Virus Announcement"
	desc = "Fakes an immovable rod announcement. Good for a short-lasting distraction."
	item = /obj/item/announcer/virus
	cost = 5 

/datum/uplink_item/services/blob
	name = "Fake Blob Announcement"
	desc = "Fakes an Level 5 biohazard announcement. Good for a short chaotic distraction."
	item = /obj/item/announcer/blob
	cost = 8 // OH SHIT, A BLOB! 