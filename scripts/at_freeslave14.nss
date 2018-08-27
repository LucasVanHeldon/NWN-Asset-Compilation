//::///////////////////////////////////////////////
//:: FileName at_freeslave010
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 1/18/03 10:51:14 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

void main()
{
    {
        // Remove items from the player's inventory
    object oItemToTake;
    oItemToTake = GetItemPossessedBy(GetPCSpeaker(), "SlaveKey");
    if(GetIsObjectValid(oItemToTake) != 0)
        DestroyObject(oItemToTake);
    }

    ActionForceMoveToObject(GetNearestObjectByTag("SlaveExit"),TRUE,2.0);
    ActionMoveAwayFromObject(GetPCSpeaker());
    DestroyObject(OBJECT_SELF,5.0);

    {
        // Give the speaker some XP
        RewardPartyXP(100,GetPCSpeaker());
        AdjustAlignment(GetPCSpeaker(),ALIGNMENT_GOOD,1);
        AdjustAlignment(GetPCSpeaker(),ALIGNMENT_CHAOTIC,1);
        AdjustReputation(GetPCSpeaker(),OBJECT_SELF,5);
    }
}
