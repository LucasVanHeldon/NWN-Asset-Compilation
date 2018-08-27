#include "x2_inc_switches"

void main()
{
   //Shadooow: fix for not trigering this in other events
   if(GetUserDefinedItemEventNumber() != X2_ITEM_EVENT_ACTIVATE) return;

object oPC = GetItemActivator();
effect eArmor = EffectACIncrease(2, AC_NATURAL_BONUS);
int iRND = Random(300);
float fRND = IntToFloat(iRND);
float fTotal = 300 + fRND;
ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eArmor, oPC, fTotal);
}
