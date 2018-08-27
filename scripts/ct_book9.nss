#include "x2_inc_switches"

void main()
{
   //Shadooow: fix for not trigering this in other events
   if(GetUserDefinedItemEventNumber() != X2_ITEM_EVENT_ACTIVATE) return;

object oPC = GetItemActivator();
location lTarget = GetItemActivatedTargetLocation();
object oTarget = GetItemActivatedTarget();
effect eHide = EffectSkillIncrease(SKILL_HIDE, 5);
effect eMove_Silently = EffectSkillIncrease(SKILL_MOVE_SILENTLY, 1);
effect eOpenLocks = EffectSkillIncrease(SKILL_OPEN_LOCK, 1);
effect ePickPocket = EffectSkillIncrease(SKILL_PICK_POCKET, 1);
   if(oTarget == oPC)
   {
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eMove_Silently, oPC);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, ePickPocket, oPC);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eOpenLocks, oPC);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eHide, oPC, 120.0f);
    }
}
