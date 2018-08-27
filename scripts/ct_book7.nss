#include "x2_inc_switches"

void main()
{
   //Shadooow: fix for not trigering this in other events
   if(GetUserDefinedItemEventNumber() != X2_ITEM_EVENT_ACTIVATE) return;

object oPC = GetItemActivator();
location lTarget = GetItemActivatedTargetLocation();
object oTarget = GetItemActivatedTarget();
effect eSpell = EffectSkillIncrease(SKILL_SPELLCRAFT, 1);
   if(oTarget == oPC)
   {
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eSpell, oPC);
    SendMessageToPC(oPC, "You just learned more about the art of spellcraft.");
    }
}
