/obj/machinery/atm
	name = "automatic teller machine"
	desc = "A terminal that will allow you to access your bank account."
	icon = 'modular_skyrat/icons/obj/machines/terminals.dmi'
	icon_state = "atm"

	var/obj/item/card/id/CID = null

/obj/machinery/atm/attackby(obj/item/W, mob/user, params)
	if(istype(W, /obj/item/card/id))
		CID = W
		if(!CID.registered_account.account_password)
			var/passchoice = input(user, "Please select a password:", "Password Selection") as null|text
			if(!passchoice)
				invalid_number()
				return
			CID.registered_account.account_password = passchoice
			return
		var/enteredpass = input(user, "Please enter your password:", "Password Entry") as null|text
		if(!enteredpass)
			invalid_number()
			return
		if(enteredpass != CID.registered_account.account_password)
			playsound(loc, 'sound/machines/beeping_alarm.ogg', 50, 1, -1)
			visible_message("<span class='warning'>Incorrect Password.</span>", null, null, 5, null, null, null, null, TRUE)
			return
		var/nextquestion = input(user, "Please select a function:", "Function Selection") as null|anything in list("withdraw", "change password", "direct deposit")
		switch(nextquestion)
			if("withdraw")
				var/withdrawfund = input(user, "Please select the amount to withdraw:", "Withdraw Money") as null|num 
				if(!withdrawfund)
					invalid_number()
					return
				if(withdrawfund <= 0 || withdrawfund > CID.registered_account.account_balance)
					invalid_number()
					return
				CID.registered_account.account_balance -= withdrawfund
				var/obj/item/holochip/HC = new /obj/item/holochip(get_turf(src))
				user.put_in_inactive_hand(HC)
				successful_transaction()
				HC.credits = withdrawfund
			if("change password")
				var/passchoicenew = input(user, "Please select a password:", "Password Selection") as null|text
				if(!passchoicenew)
					invalid_number()
					return
				CID.registered_account.account_password = passchoicenew
				return
			if("direct deposit")
				var/selectaccount = input(user, "Please enter an account number:", "Account Selection") as null|num
				if(!selectaccount)
					playsound(loc, 'sound/machines/synth_no.ogg', 50, 1, -1)
					visible_message("<span class='warning'>You must select an account to deposit.</span>", null, null, 5, null, null, null, null, TRUE)
					return
				for(var/datum/bank_account/BA in SSeconomy.bank_accounts)
					if(selectaccount != BA.account_id)
						continue
					var/ddeposit = input(user, "Please select the amount to withdraw:", "Withdraw Money") as null|num 
					if(!ddeposit)
						invalid_number()
						return
					if(ddeposit <= 0 || ddeposit > CID.registered_account.account_balance)
						invalid_number()
						return
					CID.registered_account.account_balance -= ddeposit
					BA.account_balance += ddeposit
					successful_transaction()
					break
	if(istype(W, /obj/item/holochip))
		var/obj/item/holochip/HC = W
		if(HC.credits <= 0 || !HC.credits)
			return
		var/selectaccount = input(user, "Please enter an account number:", "Account Selection") as null|num
		if(!selectaccount)
			playsound(loc, 'sound/machines/synth_no.ogg', 50, 1, -1)
			visible_message("<span class='warning'>You must select an account to deposit.</span>", null, null, 5, null, null, null, null, TRUE)
			return
		for(var/datum/bank_account/BA in SSeconomy.bank_accounts)
			if(selectaccount != BA.account_id)
				continue
			BA.account_balance += HC.credits
			successful_transaction()
			qdel(HC)
			break
		
/obj/machinery/atm/proc/invalid_number()
	playsound(loc, 'sound/machines/synth_no.ogg', 50, 1, -1)
	visible_message("<span class='warning'>Invalid number entered.</span>", null, null, 5, null, null, null, null, TRUE)

/obj/machinery/atm/proc/successful_transaction()
	playsound(loc, 'sound/machines/synth_yes.ogg', 50, 1, -1)
	visible_message("<span class='warning'>Successful Transaction.</span>", null, null, 5, null, null, null, null, TRUE)
