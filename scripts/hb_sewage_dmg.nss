//:://////////////////////////////////////////////
//:: Created By: Joseph
//:: Created On: Apr 11, 2003
//:://////////////////////////////////////////////
/* Notes:
 Description: Allows an area to damage any players in it.  A timer using a
              local variable (int_dmgTimer) is used to count to a specific
              time (intTimerUp); at this time the player will be damaged.
 This script: dam_arxx_onheart
 Additional Script(s): dam_area_onenter
 Place This Script: OnHeartBeat Event for Area
 Customizing:
    intDmgType - Use this to set the type of damage that will damage the
                 player.  Some of the useful Damage type for this purpose
                 may be DAMAGE_TYPE_ACID, DAMAGE_TYPE_COLD, DAMAGE_TYPE_FIRE
                 DAMAGE_TYPE_ELECTRICAL, DAMAGE_TYPE_SONIC, DAMAGE_TYPE_NEGATIVE
                 ** There are a few others
    intTimerUp - This is the number of seconds (approx. real time)
 Comments: The script was written so the dam_area_onEnter would not have to
           change, while this script could be modified for several different
           areas.  Hense the Name of this script dam_arxx_onHeart, the xx can
           be used as a numeric value for different areas.
*/
void main() {
 int intDmgType = DAMAGE_TYPE_ACID;
 int intTimerUp = 20;
 object oPC = GetFirstPC();
 object oArea = OBJECT_SELF;
 effect eEffect = EffectDamage(d2(1),intDmgType,DAMAGE_POWER_NORMAL);
 while (GetIsObjectValid(oPC)) {
  if (GetName(GetArea(oPC)) == GetName(GetArea(oArea))) {
   if (GetLocalInt(oPC,"int_dmgTimer") >= FloatToInt(intTimerUp/6.0)) {
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eEffect, oPC, 0.0);
    SetLocalInt(oPC,"int_dmgTimer", -1);
   } // End if (Timer up)
   SetLocalInt(oPC,"int_dmgTimer",GetLocalInt(oPC,"int_dmgTimer") + 1);
  } // End if (in Area)
  oPC = GetNextPC();
 } // End of While Loop
} // End of Main

