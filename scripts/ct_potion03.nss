#include "x2_inc_switches"

void main()
{
   //Shadooow: fix for not trigering this in other events
   if(GetUserDefinedItemEventNumber() != X2_ITEM_EVENT_ACTIVATE) return;

object oPC = GetItemActivator();
effect eHP = EffectTemporaryHitpoints(10);
ApplyEffectToObject(DURATION_TYPE_INSTANT, eHP, oPC);
}
