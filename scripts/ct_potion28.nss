#include "x2_inc_switches"

void main()
{
   //Shadooow: fix for not trigering this in other events
   if(GetUserDefinedItemEventNumber() != X2_ITEM_EVENT_ACTIVATE) return;

object oPC = GetItemActivator();
int iHD = GetHitDice(oPC);
int iHP = GetCurrentHitPoints(oPC);
int iDAMAGE = iHD*10/5;
effect eDamage = EffectDamage(iDAMAGE, DAMAGE_TYPE_MAGICAL, DAMAGE_POWER_PLUS_TWO);
ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oPC);
AssignCommand(oPC, ActionSpeakString("OUCH!"));
DelayCommand(2.5, AssignCommand(oPC, ActionSpeakString("My skin is boiling off AHHHH!")));
effect eDamage1 = EffectAbilityDecrease(ABILITY_CHARISMA, 1);
DelayCommand(3.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage1, oPC));
}
