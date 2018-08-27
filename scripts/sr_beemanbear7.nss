#include "nw_i0_generic"

void main()
{
    object oPC = GetEnteringObject();
    int iBearState = GetLocalInt(oPC, "NW_JOURNAL_ENTRYkeep_q6_bear");

    if (iBearState < 2 && GetIsObjectValid(GetNearestObjectByTag("BeeManBear", oPC))) {
        SetIsTemporaryEnemy(GetNearestObjectByTag("BeeManBear", oPC), oPC);
        DetermineCombatRound(oPC);
    }

}
