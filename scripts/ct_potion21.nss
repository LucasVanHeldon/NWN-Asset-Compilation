#include "x2_inc_switches"

void main()
{
   //Shadooow: fix for not trigering this in other events
   if(GetUserDefinedItemEventNumber() != X2_ITEM_EVENT_ACTIVATE) return;

object oPC = GetItemActivator();
AssignCommand(oPC, ActionCastSpellAtObject(SPELL_ETHEREAL_VISAGE, oPC, METAMAGIC_ANY, TRUE));
AssignCommand(oPC, ActionSpeakString("*Burp*"));
}
