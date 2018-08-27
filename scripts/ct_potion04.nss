#include "x2_inc_switches"

void main()
{
   //Shadooow: fix for not trigering this in other events
   if(GetUserDefinedItemEventNumber() != X2_ITEM_EVENT_ACTIVATE) return;

object oPC = GetItemActivator();
effect eUltravision = EffectUltravision();
int iRND = Random(300);
float fRND = IntToFloat(iRND);
float fTotal = 900 + fRND;
ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eUltravision, oPC, fTotal);
}
