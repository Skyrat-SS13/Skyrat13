/proc/vox_name()
	var/sounds = rand(2, 8)
	var/i = 0
	var/newname = ""

	while(i <= sounds)
		i++
		newname += pick(GLOB.vox_name_syllables)
	return newname

/proc/imp_name(last_name)
	var/sounds = rand(2, 5)
	var/i = 0
	var/newname = ""

	while(i <= sounds)
		i++
		newname += pick(GLOB.imp_name_syllables)
	if(last_name)
		newname += " "
		i = 0
		while(i <= sounds)
			i++
			newname += pick(GLOB.imp_name_syllables)

	return newname
