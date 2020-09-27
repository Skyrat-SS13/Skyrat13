//Combat intent related stuff
/mob/living/carbon
	var/combat_intent = CI_DEFAULT

/mob/living/carbon/proc/switch_combat_intent(new_intent)
	var/old_intent = combat_intent
	combat_intent = new_intent
	if(new_intent != old_intent)
		var/msg = ""
		switch(combat_intent)
			if(CI_FEINT)
				msg += "<h3><span class='info'>Feint</span></h3>"
				msg += "<span class='info'>Right click to perform a feint attack. If successful it will block them from attacking you briefly.</span>"
			if(CI_DUAL)
				msg += "<h3><span class='info'>Dual</span></h3>"
				msg += "<span class='info'>Right click to melee attack with the item in your offhand. You will be less accurate though.</span>"
			if(CI_GUARD)
				msg += "<h3><span class='info'>Guard</span></h3>"
				msg += "<span class='info'>You will now automatically riposte any attack you successfully parry, but you will do less damage.</span>"
			if(CI_DEFEND)
				msg += "<h3><span class='info'>Defend</span></h3>"
				msg += "<span class='info'>Your dodge and parry abilities are now greatly heightend, at the cost of reduced damage output.</span>"
			if(CI_STRONG)
				msg += "<h3><span class='info'>Strong</span></h3>"
				msg += "<span class='info'>Right click to perform a strong attack. You will hit for maximum damage, but the attack is slow, and costs stamina.</span>"
			if(CI_FURIOUS)
				msg += "<h3><span class='info'>Furious</span></h3>"
				msg += "<span class='info'>Right click to attack very quickly, it costs more stamina though.</span>"
			if(CI_AIMED)
				msg += "<h3><span class='info'>Aimed</span></h3>"
				msg += "<span class='info'>You won't miss any attack attempt, but it will cost you more stamina.</span>"
			if(CI_WEAK)
				msg += "<h3><span class='info'>Weak</span></h3>"
				msg += "<span class='info'>Right click to attack for the least amount of damage possible. Use it for hitting your friends.</span>"
		to_chat(src, msg)
