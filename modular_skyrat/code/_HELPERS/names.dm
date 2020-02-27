/proc/vox_name()
	var/sounds = rand(2, 8)
	var/i = 0
	var/newname = ""

	while(i <= sounds)
		i++
		newname += pick(GLOB.vox_name_syllables)
	return newname