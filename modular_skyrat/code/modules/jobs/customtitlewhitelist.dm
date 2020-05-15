//Custom job titles
//Loads the ckeys from the file below
//I was too lazy to code in shit so i could do comments on the file itself lol
#define TITLEWHITELIST "[global.config.directory]/titlewhitelist.txt"

GLOBAL_LIST_INIT(titlewhitelist, world.file2list(TITLEWHITELIST))

#undef TITLEWHITELIST
