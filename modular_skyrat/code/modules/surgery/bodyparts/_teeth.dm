//Teeth object, used by the head limb to do teeth stuff
/obj/item/stack/teeth
	name = "teeth"
	singular_name = "tooth"
	desc = "Something that british people don't have."
	icon = 'modular_skyrat/icons/obj/surgery.dmi'
	icon_state = "tooth_4"
	max_amount = 32
	throwforce = 0
	force = 0

/obj/item/stack/teeth/Initialize(mapload, new_amount, merge)
	. = ..()
	icon_state = "tooth_[rand(1,4)]"

/obj/item/stack/teeth/proc/do_knock_out_animation(shrink_time = 5)
	transform = transform.Scale(2, 2)
	animate(src, transform = transform.Scale(0.5, 0.5), time = shrink_time)
