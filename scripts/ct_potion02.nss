#include "x2_inc_switches"

void main()
{
   //Shadooow: fix for not trigering this in other events
   if(GetUserDefinedItemEventNumber() != X2_ITEM_EVENT_ACTIVATE) return;

object oPC = GetItemActivator();
effect eDarkness = EffectDarkness();
int iRND = Random(6);
float fTotal = iRND + 14.0;
ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDarkness, oPC, fTotal);
}
