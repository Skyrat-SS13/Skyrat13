/mob/living/simple_animal/pet/cat/Runtime/examine(mob/user)
	. = ..()
	. += "<a href='?src=\ref[src]' style='color:#1E90FF'>LOL 2CAT</a>"

/mob/living/simple_animal/pet/cat/Runtime/Topic(href, href_list)
	. = ..()
	var/githubissues = "[CONFIG_GET(string/githuburl)]/issues"
	usr << link(githubissues)
