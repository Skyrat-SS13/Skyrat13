/obj/item/book/manual/wiki/skyrat
	name = "Citadel infobook"
	icon_state ="book8"
	author = "Nanotrasen"
	title = "Citadel infobook"
	page_link = ""
	window_size = "1500x800" //Too squashed otherwise

/obj/item/book/manual/wiki/skyrat/initialize_wikibook()
	var/wikiurl = CONFIG_GET(string/wikiurlskyrat)
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
					myframe.style.display = "block";
				}
			</script>
			<p id='loading'>You start skimming through the manual...</p>
			<iframe width='100%' height='97%' onload="pageloaded(this)" src="[wikiurl]/[page_link]" frameborder="0" id="main_frame"></iframe>
			</body>

			</html>

			"}

// Put your books for Skyrat wiki here.

/obj/item/book/manual/wiki/skyrat/corporate_regulations
	name = "Corporate Regulations"
	desc = "A set of Nanotrasen guidelines for keeping law and order on their space stations."
	icon_state = "bookSpaceLaw"
	author = "Nanotrasen"
	title = "CorporateRegulations"
	page_link = "Corporate_Regulations"