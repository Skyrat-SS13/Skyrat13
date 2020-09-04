//Interacting with to avoid do_after spam
#define INTERACTING_WITH(X, Y) (Y in X.do_afters)

//Default examine more return
#define DEFAULT_EXAMINE_MORE list("<span class='notice'><i>You examine [src] closer, but find nothing of interest...</i></span>")

//Time in ticks for an embed message to wait before displaying
//used in a similar vein to the pellet cloud component, to prevent
//spam of embed messages
#define EMBED_WAIT_TIME 0.5 SECONDS

//Defines for showing/not showing armor stats on an obj
#define ARMOR_SHOW_DONT 0 //We just don't armor stats to the player, period
#define ARMOR_SHOW_WEARABLE 1 //We only show if we can be worn in a clothing slot
#define ARMOR_SHOW_ALWAYS 2 //We always show armor stats, no checks
