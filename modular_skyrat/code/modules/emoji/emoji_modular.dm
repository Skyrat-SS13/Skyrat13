/// Modular overwrite of emoji stuff for Skyrat's emoji additions. As you can see, it is a terrible one.
// code\modules\client\asset_cache.dm
/datum/asset/spritesheet/goonchat/register()
	InsertAll("emoji", 'modular_skyrat/icons/emoji.dmi')
	InsertAll("emoji", 'modular_skyrat/icons/emoji_32.dmi')
	..()

// Basically copypasted code\modules\emoji\emoji_parse.dm with edits to make code get emojis from modular files.
/proc/emoji_parse(text) //turns :ai: into an emoji in text.
	. = text
	if(!CONFIG_GET(flag/emojis))
		return
	var/list/emojis = icon_states(icon('modular_skyrat/icons/emoji.dmi'))
	emojis |= icon_states(icon('modular_skyrat/icons/emoji_32.dmi'))
	var/parsed = ""
	var/pos = 1
	var/search = 0
	var/emoji = ""
	while(1)
		search = findtext(text, ":", pos)
		parsed += copytext(text, pos, search)
		if(search)
			pos = search
			search = findtext(text, ":", pos + length(text[pos]))
			if(search)
				emoji = lowertext(copytext(text, pos + length(text[pos]), search))
				var/datum/asset/spritesheet/sheet = get_asset_datum(/datum/asset/spritesheet/goonchat)
				var/tag = sheet.icon_tag("emoji-[emoji]")
				if(tag)
					parsed += "<i style='width:16px !important;height:16px !important;'>[tag]</i>" //evil way of enforcing 16x16
					pos = search + length(text[pos])
				else
					parsed += copytext(text, pos, search)
					pos = search
				emoji = ""
				continue
			else
				parsed += copytext(text, pos, search)
		break
	return parsed

/proc/emoji_sanitize(text) //cuts any text that would not be parsed as an emoji
	. = text
	if(!CONFIG_GET(flag/emojis))
		return
	var/list/emojis = icon_states(icon('modular_skyrat/icons/emoji.dmi'))
	emojis |= icon_states(icon('modular_skyrat/icons/emoji_32.dmi'))
	var/final = "" //only tags are added to this
	var/pos = 1
	var/search = 0
	while(1)
		search = findtext(text, ":", pos)
		if(search)
			pos = search
			search = findtext(text, ":", pos + length(text[pos]))
			if(search)
				var/word = lowertext(copytext(text, pos + length(text[pos]), search))
				if(word in emojis)
					final += lowertext(copytext(text, pos, search + length(text[search])))
				pos = search + length(text[search])
				continue
		break
	return final
