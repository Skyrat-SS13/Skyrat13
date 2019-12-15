/datum/tetris_piece
	var/datum/tetris_field/owner
	var/on_field = FALSE
	var/list/board_coordinates

/datum/tetris_piece/Destroy()
	owner = null
	board_coordinates.Cut()
	return ..()

/datum/tetris_piece/proc/place_on_board(list/coordinates)
	on_field = TRUE
	board_coordinates = coordinates
