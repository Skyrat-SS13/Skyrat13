/obj/item/projectile/plasma
	dismemberment = 5 //Every 1 out of 20 shots dismember, in an ideal world.
	pressure_decrease = 0.2
	range = 4
	mine_range = 5

/obj/item/projectile/plasma/adv
	dismemberment = 7.5
	damage = 25
	range = 5
	mine_range = 7

/obj/item/projectile/plasma/adv/mech
	dismemberment = 5
	damage = 30
	range = 5
	mine_range = 9

/obj/item/projectile/plasma/turret
	//Between normal and advanced for damage, made a beam so not the turret does not destroy glass
	name = "plasma beam"
	damage = 22.5
	range = 7
	pass_flags = PASSTABLE | PASSGLASS | PASSGRILLE

/obj/item/projectile/plasma/weak
	dismemberment = 0
	damage = 10
	range = 4
	mine_range = 0
