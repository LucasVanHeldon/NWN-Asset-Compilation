#include "x2_inc_switches"

void main()
{
   //Shadooow: fix for not trigering this in other events
   if(GetUserDefinedItemEventNumber() != X2_ITEM_EVENT_ACTIVATE) return;

object oPC = GetItemActivator();
effect eDamage = EffectAbilityDecrease(ABILITY_WISDOM, 1);
ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDamage, oPC, 180.0);
AssignCommand(oPC, ActionSpeakString("AH!"));
effect eDamage1 = EffectAbilityIncrease(ABILITY_STRENGTH, 2);
DelayCommand(2.5, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDamage1, oPC, 180.0));
}
