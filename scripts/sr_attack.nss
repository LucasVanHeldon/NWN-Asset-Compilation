#include "nw_i0_generic"

void main()
{
    object oPC = GetFirstPC();
    // Set the faction to hate the player, then attack the player
    while (GetIsObjectValid(oPC)) {
        AdjustReputation(oPC, OBJECT_SELF, -100);
        AdjustReputation(OBJECT_SELF, oPC, -100);
        oPC = GetNextPC();
    }
    DetermineCombatRound(oPC);
}
