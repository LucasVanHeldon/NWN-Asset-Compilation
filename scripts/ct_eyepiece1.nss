#include "x2_inc_switches"

void main()
{
   //Shadooow: fix for not trigering this in other events
   if(GetUserDefinedItemEventNumber() != X2_ITEM_EVENT_ACTIVATE) return;

object oPC = GetItemActivator();
location lTarget = GetItemActivatedTargetLocation();
object oTarget = GetItemActivatedTarget();
effect eLore = EffectSkillIncrease(SKILL_LORE, 5);
effect eAppraise = EffectSkillIncrease(SKILL_APPRAISE, 5);
   if(oTarget == oPC)
   {
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLore, oPC, 30.0);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eAppraise, oPC, 30.0f);
    }
}
