////////////////////////////////////////////////////////////////////////////////
// Unequip HP Script                                                          //
// Removes Hit Point bonus, when unequipped.                                  //
// By: Arikel Tolifen                                                         //
////////////////////////////////////////////////////////////////////////////////
void main()
{

object oPC = GetPCItemLastUnequippedBy();

object oItem = GetPCItemLastUnequipped();

    if (!GetIsPC(oPC)) return;

    effect eEffect = GetFirstEffect(oPC);
    while (GetIsEffectValid(eEffect))
   {
   if (GetEffectType(eEffect)==EFFECT_TYPE_TEMPORARY_HITPOINTS) RemoveEffect(oPC, eEffect);
   eEffect = GetNextEffect(oPC);
   }

}
