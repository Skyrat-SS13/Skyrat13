/obj/item/clothing/mask/gas/hecu2
	name = "HECU mask"
	desc = "MY. ASS. IS. HEAVY."
	icon = 'modular_skyrat/icons/obj/clothing/masks.dmi'
	icon_state = "hecu_mask"
	mob_overlay_icon = 'modular_skyrat/icons/mob/clothing/mask.dmi'
	anthro_mob_worn_overlay  = 'modular_skyrat/icons/mob/clothing/mask_muzzled.dmi'
	flags_inv = HIDEFACIALHAIR|HIDEFACE|HIDEEYES
	modifies_speech = TRUE
	var/togglestate = 1
	var/max_charge = 100
	var/mask_charge = 100
	var/word_cost = 7
	var/word_delay = 7
	var/list/words_to_say = list()
	var/can_say = 0
	var/list/punct_list = list("," , "." , "?" , "!")

	//Big list of words pulled from half life's soldiers, used for both matching with spoken text and part of the sound file's path
	var/list/hecuwords = list(
		"a", "affirmative", "alert", "alien", "all" , "am" , "anything" , "are" , "area" , "ass" , "at" , "away" ,
		"backup" , "bag" , "bastard" , "blow" , "bogies" , "bravo" , "call" , "casualties" , "charlie" , "check" , "checking" , "clear" , "comma" ,
		"command" , "continue" , "control" , "cover" , "creeps" , "damn" , "delta" , "down" , "east" , "echo" , "eliminate" , "everything" , "fall" ,
		"fight" , "fire" , "five" , "force" , "formation" , "four" , "foxtrot" , "freeman" , "get" , "go" , "god" , "going" , "got" , "grenade" , "guard" ,
		"haha" , "have" , "he" , "heavy" , "hell" , "here" , "hold" , "hole" , "hostiles" , "hot" , "i" , "in" , "is" , "kick" , "killcivvies" ,
		"killscientists" , "lay" , "left" , "lets" , "level" , "lookout" , "maintain" , "mission" , "mister" , "mother" , "move" , "movement" , "moves" ,
		"my" , "need" , "negative" , "neutralize" , "neutralized" , "nine" , "no" , "north" , "nothing" , "objective" , "of" , "oh" , "okay" , "one" ,
		"orders" , "our" , "out" , "over" , "patrol" , "people" , "period" , "position" , "post" , "private" , "quiet" , "radio" , "recon" , "request" ,
		"right" , "roger" , "sector" , "secure" , "shit" , "shot" , "sign" , "signs" , "silence" , "sir" , "six" , "some" , "something" , "south" , "squad" ,
		"stay" , "suppressing" , "sweep" , "take" , "tango" , "target" , "team" , "that" , "thatbastard" , "the" , "there" , "these" , "this" , "those" ,
		"three" , "tight" , "two" , "uh" , "under" , "up" , "we" , "weapons" , "weird" , "west" , "we've" , "whatbody" , "whoisfreeman" , "will" , "yeah" ,
		"yes" , "yessir" , "you" , "your" , "zero" , "zone" , "zulu" , "meters" , "seven" , "eight" , "hundred" , "to" , "too"
		)

/obj/item/clothing/mask/gas/hecu2/examine(var/mob/user)
	. = ..()
	. += "<span class='notice'>Alt-click the mask to see the list of available words.</span>"
	. += "<span class='notice'>Charge: [mask_charge]/[max_charge] </span>"

/obj/item/clothing/mask/gas/hecu2/AltClick(var/mob/user)
	var/message = "Known words: "
	if((user.incapacitated() || !Adjacent(user)))
		return
	for(var/i=1,i<=hecuwords.len,i++)
		message = addtext(message, uppertext(hecuwords[i]), ", ")
	to_chat(user, "[message]")

//Recharging the mask over time
/obj/item/clothing/mask/gas/hecu2/Initialize()
	. = ..()
	START_PROCESSING(SSobj, src)

/obj/item/clothing/mask/gas/hecu2/Destroy()
	STOP_PROCESSING(SSobj, src)
	return ..()

/obj/item/clothing/mask/gas/hecu2/process()
	if(can_say)
		can_say = !can_say
		say_words()
	if(mask_charge >= max_charge)
		return
	mask_charge++

/obj/item/clothing/mask/gas/hecu2/handle_speech(datum/source, list/speech_args)
	var/message = speech_args[SPEECH_MESSAGE]
	var/list/word_list = splittext(message," ")

	for(var/i=1,i<=word_list.len,i++)
		if((uppertext(word_list[i]) == "I") || (uppertext(word_list[i]) == "A")) //Stops capitilized 'I' and 'A' from triggering in normal speech
			if(i != word_list.len)
				if(word_list[i + 1] != uppertext(word_list[i + 1]))
					continue
		for(var/x=1,x<=punct_list.len,x++)
			word_list[i] = replacetext(word_list[i] , punct_list[x] , "") //Ignores punctuation.
		for(var/j=1,j<=hecuwords.len,j++)
			if(uppertext(hecuwords[j]) == word_list[i]) //SHOUT a known word to activate
				words_to_say += hecuwords[j]
				can_say = 1
	..()

/obj/item/clothing/mask/gas/hecu2/proc/say_words()
	if(words_to_say.len > 0)
		for(var/i=1,i<=words_to_say.len,i++)
			if(mask_charge >= word_cost)
				mask_charge -= word_cost
				playsound(src.loc, "modular_skyrat/sound/voice/vox_hecu/[words_to_say[i]]!.wav", 100, 0, 4)
				sleep(7)
		words_to_say.Cut()
