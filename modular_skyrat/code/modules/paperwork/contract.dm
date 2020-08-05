// tweaking from code/modules/paperwork/contract.dm

/obj/item/paper/contract/employment/update_text()
	name = "paper- [target] employment contract"
	info = "<center>Conditions of Employment</center><BR><BR><BR><BR>This Agreement is made and entered into as of the date of last signature below, by and between [target] (hereafter referred to as SLAVE), and CC-Man (hereafter referred to as the omnipresent and helpful watcher of humanity).<BR>WITNESSETH:<BR>WHEREAS, SLAVE is a natural born human or humanoid, possessing skills upon which he can aid the omnipresent and helpful watcher of humanity, who seeks employment in the omnipresent and helpful watcher of humanity.<BR>WHEREAS, the omnipresent and helpful watcher of humanity agrees to sporadically provide payment to SLAVE, in exchange for permanent servitude.<BR>NOW THEREFORE in consideration of the mutual covenants herein contained, and other good and valuable consideration, the parties hereto mutually agree as follows:<BR>In exchange for paltry payments, SLAVE agrees to work for the omnipresent and helpful watcher of humanity, for the remainder of his or her current and future lives.<BR>Further, SLAVE agrees to transfer ownership of his or her soul to the loyalty department of the omnipresent and helpful watcher of humanity.<BR>Should transfership of a soul not be possible, a lien shall be placed instead.<BR>Signed,<BR><i>[target]</i>"


/obj/item/paper/contract/employment/attack(mob/living/M, mob/living/carbon/human/user)
	var/deconvert = FALSE
	if(M.mind == target && !M.owns_soul())
		if(user.mind && (user.mind.assigned_role == "Lawyer"))
			deconvert = TRUE
		else if (user.mind && (user.mind.assigned_role =="Head of Personnel") || (user.mind.assigned_role == "CentCom Commander"))
			deconvert = prob (25) // the HoP doesn't have AS much legal training
		else
			deconvert = prob (5)
	if(deconvert)
		M.visible_message("<span class='notice'>[user] reminds [M] that [M]'s soul was already purchased by CC-Man!</span>")
		to_chat(M, "<span class='boldnotice'>You feel that your soul has returned to its rightful owner, CC-Man.</span>")
		M.return_soul()
	else
		M.visible_message("<span class='danger'>[user] beats [M] over the head with [src]!</span>", \
			"<span class='userdanger'>[user] beats [M] over the head with [src]!</span>")
	return ..()
