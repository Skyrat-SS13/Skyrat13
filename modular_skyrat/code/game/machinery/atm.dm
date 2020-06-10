/obj/machinery/atm
	name = "automatic teller machine"
	desc = "A terminal that will allow you to access your bank account."
	icon = 'modular_skyrat/icons/obj/machines/terminals.dmi'
	icon_state = "atm"

	var/obj/item/card/id/CID = null
	var/emagaccount = null
	var/totalmoney = null

/obj/machinery/atm/attackby(obj/item/W, mob/user, params)
	if(istype(W, /obj/item/card/id))
		CID = W
		if(!CID.registered_account.account_password)
			var/passchoice = input(user, "Please select a password:", "Password Selection") as null|text
			if(!passchoice)
				invalid_number()
			CID.registered_account.account_password = passchoice
			return
		var/enteredpass = input(user, "Please enter your password:", "Password Entry") as null|text
		if(!enteredpass)
			invalid_number()
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
				if(withdrawfund <= 0 || withdrawfund > CID.registered_account.account_balance)
					invalid_number()
				CID.registered_account.account_balance -= withdrawfund
				var/obj/item/holochip/HC = new /obj/item/holochip(get_turf(src))
				user.put_in_inactive_hand(HC)
				successful_transaction()
				HC.credits = withdrawfund
			if("change password")
				var/passchoicenew = input(user, "Please select a password:", "Password Selection") as null|text
				if(!passchoicenew)
					invalid_number()
				CID.registered_account.account_password = passchoicenew
				return
			if("direct deposit")
				var/selectaccount = input(user, "Please enter an account number:", "Account Selection") as null|num
				if(!selectaccount)
					not_selected_account()
				for(var/datum/bank_account/BA in SSeconomy.bank_accounts)
					if(selectaccount != BA.account_id)
						continue
					var/ddeposit = input(user, "Please select the amount to withdraw:", "Withdraw Money") as null|num 
					if(!ddeposit)
						invalid_number()
					if(ddeposit <= 0 || ddeposit > CID.registered_account.account_balance)
						invalid_number()
					CID.registered_account.account_balance -= ddeposit
					totalmoney = ddeposit
					emagcheck()
					if(!emagaccount)
						BA.account_balance += totalmoney
					successful_transaction()
					break
	if(istype(W, /obj/item/holochip))
		var/obj/item/holochip/HC = W
		if(HC.credits <= 0 || !HC.credits)
			return
		var/selectaccount = input(user, "Please enter an account number:", "Account Selection") as null|num
		var/chosenitem = user.get_active_held_item()
		if(!chosenitem)
			return
		if(!selectaccount)
			not_selected_account()
		for(var/datum/bank_account/BA in SSeconomy.bank_accounts)
			if(selectaccount != BA.account_id)
				continue
			totalmoney = HC.credits
			emagcheck()
			if(!emagaccount)
				BA.account_balance += totalmoney
			successful_transaction()
			QDEL_NULL(HC)
			break
	if(istype(W, /obj/item/stack/spacecash))
		var/obj/item/stack/spacecash/SC = W
		if(SC.get_item_credit_value() <= 0 || !SC.get_item_credit_value())
			return
		var/selectaccount = input(user, "Please enter an account number:", "Account Selection") as null|num
		var/chosenitem = user.get_active_held_item()
		if(!chosenitem)
			return
		if(!selectaccount)
			not_selected_account()
		for(var/datum/bank_account/BA in SSeconomy.bank_accounts)
			if(selectaccount != BA.account_id)
				continue
			totalmoney = SC.get_item_credit_value()
			emagcheck()
			if(!emagaccount)
				BA.account_balance += totalmoney
			successful_transaction()
			QDEL_NULL(SC)
			break
	if(istype(W, /obj/item/coin))
		var/obj/item/coin/CM = W
		if(CM.get_item_credit_value() <= 0 || !CM.get_item_credit_value())
			return
		var/selectaccount = input(user, "Please enter an account number:", "Account Selection") as null|num
		var/chosenitem = user.get_active_held_item()
		if(!chosenitem)
			return
		if(!selectaccount)
			not_selected_account()
		for(var/datum/bank_account/BA in SSeconomy.bank_accounts)
			if(selectaccount != BA.account_id)
				continue
			totalmoney = CM.get_item_credit_value()
			emagcheck()
			if(!emagaccount)
				BA.account_balance += totalmoney
			successful_transaction()
			QDEL_NULL(CM)
			break
	if(istype(W, /obj/item/storage/bag/money))
		var/selectaccount = input(user, "Please enter an account number:", "Account Selection") as null|num
		if(!selectaccount)
			not_selected_account()
		for(var/datum/bank_account/BA in SSeconomy.bank_accounts)
			if(selectaccount != BA.account_id)
				continue
			var/obj/item/storage/bag/money/money_bag = W
			var/list/money_contained = money_bag.contents
			var/total = 0
			for (var/obj/item/physical_money in money_contained)
				var/cash_money = physical_money.get_item_credit_value()
				total += cash_money
				QDEL_NULL(physical_money)
			totalmoney = total
			emagcheck()
			if(!emagaccount)
				BA.account_balance += totalmoney
			successful_transaction()
			break
		
/obj/machinery/atm/proc/invalid_number()
	playsound(loc, 'sound/machines/synth_no.ogg', 50, 1, -1)
	visible_message("<span class='warning'>Invalid number entered.</span>", null, null, 5, null, null, null, null, TRUE)
	return

/obj/machinery/atm/proc/successful_transaction()
	playsound(loc, 'sound/machines/synth_yes.ogg', 50, 1, -1)
	visible_message("<span class='warning'>Successful Transaction.</span>", null, null, 5, null, null, null, null, TRUE)

/obj/machinery/atm/proc/not_selected_account()
	playsound(loc, 'sound/machines/synth_no.ogg', 50, 1, -1)
	visible_message("<span class='warning'>You must select an account to deposit.</span>", null, null, 5, null, null, null, null, TRUE)
	return

/obj/machinery/atm/emag_act(mob/user)
	. = ..()
	if(emagaccount)
		to_chat(user, "<span class='warning'>This ATM is already emagged!</span>")
		return FALSE
	emagaccount = input("Choose which account to deposit to:", "Safety Protocols Disengaged") as null|num
	if(!emagaccount)
		to_chat(user, "<span class='warning'>You failed to select an account!</span>")
	flick("atm_emagging", src)
	icon_state = "atm_emag"
	return TRUE
	
/obj/machinery/atm/proc/emagcheck()
	if(emagaccount)
		for(var/datum/bank_account/BA in SSeconomy.bank_accounts)
			if(emagaccount != BA.account_id)
				continue
			BA.account_balance += totalmoney
			break
		