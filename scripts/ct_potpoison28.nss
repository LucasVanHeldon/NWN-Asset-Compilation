#include "x2_inc_switches"

void main()
{
   //Shadooow: fix for not trigering this in other events
   if(GetUserDefinedItemEventNumber() != X2_ITEM_EVENT_ACTIVATE) return;

object oPC = GetItemActivator();
// effect ePoison = EffectPoison(POISON_ARANEA_VENOM);
// effect ePoison = EffectPoison(POISON_ARSENIC);
// effect ePoison = EffectPoison(POISON_BEBILITH_VENOM);
// effect ePoison = EffectPoison(POISON_BLACK_ADDER_VENOM);
// effect ePoison = EffectPoison(POISON_BLACK_LOTUS_EXTRACT);
// effect ePoison = EffectPoison(POISON_BLADE_BANE);
// effect ePoison = EffectPoison(POISON_BLOODROOT);
// effect ePoison = EffectPoison(POISON_BLUE_WHINNIS);
// effect ePoison = EffectPoison(POISON_BURNT_OTHUR_FUMES);
// effect ePoison = EffectPoison(POISON_CARRION_CRAWLER_BRAIN_JUICE);
// effect ePoison = EffectPoison(POISON_CHAOS_MIST);
// effect ePoison = EffectPoison(POISON_COLOSSAL_SPIDER_VENOM);
// effect ePoison = EffectPoison(POISON_DARK_REAVER_POWDER);
// effect ePoison = EffectPoison(POISON_DEATHBLADE);
// effect ePoison = EffectPoison(POISON_DRAGON_BILE);
// effect ePoison = EffectPoison(POISON_ETTERCAP_VENOM);
// effect ePoison = EffectPoison(POISON_GARGANTUAN_SPIDER_VENOM);
// effect ePoison = EffectPoison(POISON_GIANT_WASP_POISON);
// effect ePoison = EffectPoison(POISON_GREENBLOOD_OIL);
// effect ePoison = EffectPoison(POISON_HUGE_SPIDER_VENOM);
// effect ePoison = EffectPoison(POISON_ID_MOSS);
// effect ePoison = EffectPoison(POISON_IRON_GOLEM);
// effect ePoison = EffectPoison(POISON_LARGE_SCORPION_VENOM);
// effect ePoison = EffectPoison(POISON_LARGE_SPIDER_VENOM);
// effect ePoison = EffectPoison(POISON_LICH_DUST);
// effect ePoison = EffectPoison(POISON_MALYSS_ROOT_PASTE);
// effect ePoison = EffectPoison(POISON_MEDIUM_SPIDER_VENOM);
 effect ePoison = EffectPoison(POISON_NIGHTSHADE);
// effect ePoison = EffectPoison(POISON_NITHARIT);
// effect ePoison = EffectPoison(POISON_OIL_OF_TAGGIT);
// effect ePoison = EffectPoison(POISON_PHASE_SPIDER_VENOM);
// effect ePoison = EffectPoison(POISON_PIT_FIEND_ICHOR);
// effect ePoison = EffectPoison(POISON_PURPLE_WORM_POISON);
// effect ePoison = EffectPoison(POISON_QUASIT_VENOM);
// effect ePoison = EffectPoison(POISON_SASSONE_LEAF_RESIDUE);
// effect ePoison = EffectPoison(POISON_SHADOW_ESSENCE);
// effect ePoison = EffectPoison(POISON_SMALL_CENTIPEDE_POISON);
// effect ePoison = EffectPoison(POISON_SMALL_SPIDER_VENOM);
// effect ePoison = EffectPoison(POISON_STRIPED_TOADSTOOL);
// effect ePoison = EffectPoison(POISON_TERINAV_ROOT);
// effect ePoison = EffectPoison(POISON_TINY_SPIDER_VENOM);
// effect ePoison = EffectPoison(POISON_UNGOL_DUST);
// effect ePoison = EffectPoison(POISON_WRAITH_SPIDER_VENOM);
// effect ePoison = EffectPoison(POISON_WYVERN_POISON);


ApplyEffectToObject(DURATION_TYPE_TEMPORARY, ePoison, oPC, 180.0);
}
