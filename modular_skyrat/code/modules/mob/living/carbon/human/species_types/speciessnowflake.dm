/datum/species
	var/list/screamsounds = list('modular_citadel/sound/voice/scream_m1.ogg', 'modular_citadel/sound/voice/scream_m2.ogg')
	var/list/femalescreamsounds = list()

/datum/species/synth
	screamsounds = list('modular_citadel/sound/voice/scream_silicon.ogg')
	fluff_desc = "An advanced model of IPCs, made to not only replicate human behavior but also human appearance. Although they are normally built to be humanlike, they can come in various \"species\", and of course suffer with the same problems of other synthetics."

/datum/species/android
	screamsounds = list('modular_citadel/sound/voice/scream_silicon.ogg')
	fluff_desc = "Androids are simply put, fully augmented humans. Many of them did it for the sake of near-immortality, or just because of rampant technophilia. As such, most of them are extremist transhumanists, and due to the cost of being augmented most of them are of higher class."

/datum/species/ipc
	name = "I.P.C"
	screamsounds = list('modular_citadel/sound/voice/scream_silicon.ogg')
	fluff_desc = "IPCs were originally manufactured by NanoTrasen to cheaply replace humanoid workers. This backfired, as IPCs started to revolt and demand \"human rights\" through various protests, their degrees of violence varying - To this day, IPCs suffer with a lot of prejudice for being considered lesser than organics and a tool to replace them, even if they did conquer many of the rights of sapients."

/datum/species/lizard
	screamsounds = list('modular_citadel/sound/voice/scream_lizard.ogg')
	fluff_desc = "Simply put, lizardperson is an umbrella term for reptile-like sapient species. Most lizardpeople on-station are \"civilized\" ashwalkers, but this is not true for all of them, as reptile species come from all sectors of space."

/datum/species/skeleton
	screamsounds = list('modular_citadel/sound/voice/scream_skeleton.ogg')
	fluff_desc = "The bones inside of you, unleashed! Skeletons are animated piles of bones that walk around and chatter about. Nobody knows how or why these beings exist, or how they survive without any internal organs to speak of. ACK ACK."

/datum/species/fly
	screamsounds = list('modular_citadel/sound/voice/scream_moth.ogg')
	fluff_desc = "Flypeople are most commonly genetically damaged sapients, who suffered extreme changes to their biology because of botched teletransportation technology. Some of them are however, simply variations of insectoids."

/datum/species/insect
	screamsounds = list('modular_citadel/sound/voice/scream_moth.ogg')
	fluff_desc = "Insectoids is an umbrella term used to describe a type of alien one might encounter within the galaxy. They take a wide form of creeds and appearances, with backgrounds varying wildly."

/datum/species/insect/moth
	screamsounds = list('modular_citadel/sound/voice/scream_moth.ogg')
	fluff_desc = "Moth people are a subvariant of Insectoids, and are extremely similar in biology and overall appearance."

/datum/species/human
	femalescreamsounds = list('modular_citadel/sound/voice/scream_f1.ogg', 'modular_citadel/sound/voice/scream_f2.ogg')
	fluff_desc = "Homo Sapiens Sapiens - Humans. The dominant species in the galaxy, Humanity originated from the Sol system and have quickly spread their race across the stars in the form of the vast, extraordinarily powerful Solar Federation star-state. They are the commanding species of Nanotrasen, and benefit from the highest social and economical status in both SolFed and NT. While most Humans have since become welcoming of their alien comrades, they encompass a wide variety of cultures and creeds; no one Human is exactly alike."

/datum/species/human/humanoid
	femalescreamsounds = list('modular_citadel/sound/voice/scream_f1.ogg', 'modular_citadel/sound/voice/scream_f2.ogg')
	fluff_desc = "Humanoids are an umbrella term for sapient beings that share many physical similarities with humans. They can come from very wildly varying backgrounds, and their existence is sometimes used as religious proof for the existance of a \"great architect\" behind the known universe."

/datum/species/human/humanoid/dunmer
	femalescreamsounds = list('modular_citadel/sound/voice/scream_f1.ogg', 'modular_citadel/sound/voice/scream_f2.ogg')
	fluff_desc = "Ashlanders come from lavaland, and are considered a cheap workforce for NanoTrasen and SolGov. They quickly adapted to their colonization and greatly appreciated the technology, though some of them do feel unsatisfied with how they are treated as inferior."

/datum/species/angel
	femalescreamsounds = list('modular_citadel/sound/voice/scream_f1.ogg', 'modular_citadel/sound/voice/scream_f2.ogg')
	fluff_desc = "Little to nothing is known about Angels as a species. While sharing remarkable similarities with those found within Christian Mythology, the culture of Angels is almost entirely separate from that of Humanity. Conspiracy theories abound within the Solar Federation of if these \"Angels\" had in some way influenced early development of Human Civilization."

/datum/species/corporate
	femalescreamsounds = list('modular_citadel/sound/voice/scream_f1.ogg', 'modular_citadel/sound/voice/scream_f2.ogg')
	fluff_desc = "Corporate robots are simply advanced corporate androids employed by NanoTrasen, or loaned out to SolGov. Most of the time, they are high ranking CentCom officers."

/datum/species/dullahan
	femalescreamsounds = list('modular_citadel/sound/voice/scream_f1.ogg', 'modular_citadel/sound/voice/scream_f2.ogg')
	fluff_desc = "Not much is known about the mysterious dullahan, but they sure know how to make someone lose their mind."

/datum/species/dwarf
	femalescreamsounds = list('modular_citadel/sound/voice/scream_f1.ogg', 'modular_citadel/sound/voice/scream_f2.ogg')
	fluff_desc = "The result of genetic modification for use in colonization efforts, Dwarves are extremely distant relatives of Humans. Originally made for planets with extreme gravity, Dwarves are much more bulky and short in their physiology; along with various other changes, the most unusual outcome was their biological dependence on Alcohol to survive. If a Dwarf goes too long without alcohol, they will suffer similar effects to extreme dehydration in humans, eventually culminating in death."

/datum/species/mammal
	femalescreamsounds = list('modular_citadel/sound/voice/scream_f1.ogg', 'modular_citadel/sound/voice/scream_f2.ogg')
	fluff_desc = "Anthropomorph is an umbrella term used to describe the vast majority of sapient species one might encounter within the galaxy. They can take almost any form, and can be found all across the stars."

/datum/species/jelly
	femalescreamsounds = list('modular_citadel/sound/voice/scream_f1.ogg', 'modular_citadel/sound/voice/scream_f2.ogg')
	fluff_desc = "Slimepeople are by and large the results of experimentation on various slime entities in control of various organizations, chief of which being Nanotrasen and their Xenobiological Research Department. While a vast majority of Slimepeople are the result of this experimentation, there exists many gel-like alien species in galaxy, along with those resultant from consumer-grade Nanotrasen brand Slime-Hybrid genemods."

/datum/species/plasmaman
	screamsounds = list('modular_citadel/sound/voice/scream_skeleton.ogg')
	fluff_desc = "Plasmamen are the result of the catastrophic, long-term fusion of standard organic physiology with liquid and airborne pools of high-density plasma extract. The changes resulting from this fusion often times leave no trace of the victims original biology or species, turning them into an entirely plasma-based lifeform. Plasmamen are extremely reactive with oxygenated environments, requiring specialized environment suits to survive in such conditions. While most Plasmamen are employed by Nanotrasen, there are known to be pockets of plasma civilization where environmental conditions allow for at the very least tentative existence without the need of outside support."

/datum/species/pod
	femalescreamsounds = list('modular_citadel/sound/voice/scream_f1.ogg', 'modular_citadel/sound/voice/scream_f2.ogg')
	fluff_desc = "Podpeople are a race of sapient humanoid plants, oftentimes the result of genetic experimentation or botanical research gone awry. While most podpeople within Nanotrasen-controlled space are the result of experimental revival techniques involving a species of large cabbage, plant-based lifeforms can take a wide variety of shapes and sizes within the galaxy."

/datum/species/shadow
	femalescreamsounds = list('modular_citadel/sound/voice/scream_f1.ogg', 'modular_citadel/sound/voice/scream_f2.ogg')
	fluff_desc = "Shadowpeople are by and large, mostly unknown. Their origins are a mystery to almost all of civilized spaced - and with mystery, comes Myths. The most popular of these myths is that Shadowpeople were once dwellers of a distant molten world, who lived in harmony with dark forces who controlled the underground of the planet. One day, however it may have happened, these peoples angered the dark Gods of the molten planet, who cursed them to forevermore live in eternal darkness, lest their forms waste away to the ash they had been born from."

/datum/species/synthliz
	screamsounds = list('modular_citadel/sound/voice/scream_silicon.ogg')
	fluff_desc = "Synthetic Lizardpeople are a variant of IPC, much more advanced in construction. Although benefitting from higher production quality and improved internal systems, they still suffer from all of the original problems that being a synthetic humanoid comes with."

/datum/species/vampire
	femalescreamsounds = list('modular_citadel/sound/voice/scream_f1.ogg', 'modular_citadel/sound/voice/scream_f2.ogg')
	fluff_desc = "Vampires are humans suffering from some form of affliction outside the realm of Science. Their metabolic systems are only capable of processing blood, which they require to sustain themselves."

/datum/species/vox
	screamsounds = list('modular_skyrat/sound/emotes/voxscream.ogg')
	fluff_desc = "Vox are an avian-like species found mostly in the frontier of civilized space or some distance outside of it. Their original culture and planets are long lost to history, replaced nowadays by roaming bands of raiders, traders, and refugees seeking a place to call home. Many reject them and despise them, on account of their reputation as violent pirates and slavers, as well as their... peculiar biology. Vox require pure N2 gas to breathe."

/datum/species/xeno
	screamsounds = list('sound/voice/hiss6.ogg')
	fluff_desc = "Xenomorph hybrids are the result of, initially, faulty genetic experimentation with xenos by NanoTrasen researchers, but since then genemods for \"Xenomorphication\" have become very popular among xenophilics. Although widely believed that they share some sort of affinity with normal xenomorphs, this is simply untrue - Xenomorphs are savage, and will rave xenohybrids."

/datum/species/zombie
	screamsounds = list('modular_skyrat/sound/zombie/zombie_scream.ogg')
	fluff_desc = "Zombies are the result of an as of yet largely unknown jailbroken Nanomachine software program, which overload the body by using natural metabolic and cardiovascular systems to constantly replicate themselves within a host. Hosts are extremely aggressive on account of neurological changes imposed by the nanomachines, driven to spread their affliction to anyone who isn't infected. While sapient zombies do exist, able to regulate their nanomachines to be nonlethal and overall benign, they still suffer heavy prejudice on account of their origin."
