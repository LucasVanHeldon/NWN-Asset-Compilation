//::///////////////////////////////////////////////
//:: FileName sr_07c_kill
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 7/9/2002 5:11:28 PM
//:://////////////////////////////////////////////
#include "nw_i0_generic"

void main()
{
    GiveGoldToCreature(OBJECT_SELF, 200);

    // Set the faction to hate the player, then attack the player
    AdjustReputation(GetPCSpeaker(), OBJECT_SELF, -100);
    DetermineCombatRound(GetPCSpeaker());
}
