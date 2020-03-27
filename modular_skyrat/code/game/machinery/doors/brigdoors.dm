/obj/machinery/door_timer/Initialize()
  if(id != null)
    for(var/obj/machinery/door/poddoor/BD in urange(20, src))
      if (BD.id == id)
        targets += BD
  . = ..()

/obj/machinery/door_timer/timer_start()
  . = ..()
  for(var/obj/machinery/door/poddoor/BD in targets)
    if(BD.density)
      continue
    INVOKE_ASYNC(BD, /obj/machinery/door/poddoor.proc/close)

/obj/machinery/door_timer/timer_end(forced = FALSE)
  . = ..()
  for(var/obj/machinery/door/poddoor/BD in targets)
    if(!BD.density)
      continue
    INVOKE_ASYNC(BD, /obj/machinery/door/poddoor.proc/open)