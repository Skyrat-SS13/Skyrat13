/obj/machinery/biogenerator/prisoner
	name = "prisoner biogenerator"
	circuit = /obj/item/circuitboard/machine/biogenerator/prisoner

/obj/machinery/biogenerator/prisoner/Initialize()
	. = ..()
	stored_research = new /datum/techweb/specialized/autounlocking/biogenerator/prisoner
	create_reagents(1000)
