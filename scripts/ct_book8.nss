#include "x2_inc_switches"

void main()
{
   //Shadooow: fix for not trigering this in other events
   if(GetUserDefinedItemEventNumber() != X2_ITEM_EVENT_ACTIVATE) return;

object oPC = GetItemActivator();
location lTarget = GetItemActivatedTargetLocation();
object oTarget = GetItemActivatedTarget();
effect eTumble = EffectSkillIncrease(SKILL_TUMBLE, 1);
effect eDiscipline = EffectSkillIncrease(SKILL_DISCIPLINE, 1);
   if(oTarget == oPC)
   {
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eTumble, oPC);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eDiscipline, oPC);
    SendMessageToPC(oPC, "You just learned more about the art of acrobatics.");
    }
}
