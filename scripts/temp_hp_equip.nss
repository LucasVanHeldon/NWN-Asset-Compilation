////////////////////////////////////////////////////////////////////////////////
// Temp HP Equip Script                                                       //
// Adds hit points on equip.                                                  //
// By: Arikel Tolifen                                                         //
////////////////////////////////////////////////////////////////////////////////
void main()
{

object oPC = GetPCItemLastEquippedBy();
object oItem = GetPCItemLastEquipped();
int SET_TEMP_HP = GetLocalInt(oItem,"TEMP_HP");

    if (!GetIsPC(oPC)) return;

    effect eEffect = EffectTemporaryHitpoints(SET_TEMP_HP);

    eEffect = SupernaturalEffect(eEffect);

    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect, oPC);

}

