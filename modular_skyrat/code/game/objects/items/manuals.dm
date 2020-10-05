/obj/item/book/manual/wiki
	var/skyrat_wiki = FALSE

/obj/item/book/manual/wiki/proc/initialize_wikibook()
	var/wikiurl
	if(skyrat_wiki)
		wikiurl = CONFIG_GET(string/wikiurlskyrat)
	else
		wikiurl = CONFIG_GET(string/wikiurltg)
	if(wikiurl)
		dat = {"

			<html><head>
			<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
			<style>
				iframe {
					display: none;
				}
			</style>
			</head>
			<body>
			<script type="text/javascript">
				function pageloaded(myframe) {
					document.getElementById("loading").style.display = "none";
					myframe.style.display = "inline";
				}
			</script>
			<p id='loading'>You start skimming through the manual...</p>
			<iframe width='100%' height='97%' onload="pageloaded(this)" src="[wikiurl]/[page_link]?printable=yes&remove_links=1" frameborder="0" id="main_frame"></iframe>
			</body>

			</html>

			"}

/obj/item/book/manual/wiki/security_space_law
	name = "Corporate Regulations"
	desc = "A set of Nanotrasen guidelines for keeping law and order on their space stations."
	icon_state = "bookSpaceLaw"
	author = "Nanotrasen"
	title = "CorporateRegulations"
	page_link = "Corporate_Regulations"
	skyrat_wiki = TRUE
	window_size = "1500x800" //Too squashed otherwise
