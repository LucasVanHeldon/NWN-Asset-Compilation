#include "x2_inc_switches"

void main()
{
   //Shadooow: fix for not trigering this in other events
   if(GetUserDefinedItemEventNumber() != X2_ITEM_EVENT_ACTIVATE) return;

object oPC = GetItemActivator();
location lTarget = GetItemActivatedTargetLocation();
object oTarget = GetItemActivatedTarget();
effect eHide = EffectSkillIncrease(SKILL_HIDE, 5);
effect eMove_Silently = EffectSkillIncrease(SKILL_MOVE_SILENTLY, 5);
   if(oTarget == oPC)
   {
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eMove_Silently, oPC, 18.0);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eHide, oPC, 18.0f);
    }
else
{
AssignCommand(oPC, JumpToLocation(lTarget));
}
}
