//Key rings should go on the wrist
/obj/item/key/Initialize()
	. = ..()
	slot_flags |= ITEM_SLOT_WRISTS
