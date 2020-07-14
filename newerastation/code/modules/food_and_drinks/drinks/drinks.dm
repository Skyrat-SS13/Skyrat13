/obj/item/reagent_containers/food/drinks/soda_cans/guarana
	name = "Guaraná Antarctica"
	desc = "Guaraná Antarctica, the best."
	custom_price = 10
	icon = 'newerastation/icons/obj/drinks.dmi'
	icon_state = "guarana_can"
	list_reagents = list(/datum/reagent/consumable/guarana = 40)
	foodtype = SUGAR
	var/list/slogans = list("A senha contra o Boko Moko!", "Viva mais com Guaraná Antarctica!", "Seja você mesmo, beba Guaraná Antarctica!", "Todo mundo tem sede de natureza!", "Guaraná Antarctica. Meu Brasil brasileiro!", "Guaraná Antarctica, o brasileirinho!",
	"Guaraná Antarctica, eu gosto de você!", "Guaraná Antarctica, o pique total!", "Todo mundo um dia vira um guaraná!", "Este é o sabor!", "Uh! Uh! Uh! Guaraná! Antarctica!", "Tudo pede Guaraná Antarctica!", "Seja o que for, seja original!", "A pedida natural!",
	"Guaraná Antarctica e você. Ninguém Faz Igual!", "É o que é!", "Energia que contagia!", "Todo Mundo Quer! So a gente tem!", "Boralá!", "De Maués para Suas Mãos!", "É coisa nossa!")

/obj/item/reagent_containers/food/drinks/soda_cans/guarana/attack(mob/living/M, mob/user, def_zone)
	..()
	if(M == user && reagents.total_volume > 0 && is_drainable())
		to_chat(user, "<span class='notice'>[pick(slogans)]</span>")