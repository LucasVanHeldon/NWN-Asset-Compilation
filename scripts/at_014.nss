//::///////////////////////////////////////////////
//:: FileName at_007
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 6/26/2004 9:57:55 PM
//:://////////////////////////////////////////////
#include "nw_i0_generic"

void main()
{

    // Adjust alignement
    AdjustAlignment(GetPCSpeaker(), ALIGNMENT_EVIL, 5);
    // Set the faction to hate the player, then attack the player
    AdjustReputation(GetPCSpeaker(), OBJECT_SELF, -100);
    DetermineCombatRound(GetPCSpeaker());
}
