//::///////////////////////////////////////////////
//:: FileName np_destroy_slime
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 23/08/2002 4:43:50 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

void main()
{
    // Give the speaker some XP
    RewardPartyXP(100, GetPCSpeaker());


    // Remove items from the player's inventory
    object oItemToTake;
    oItemToTake = GetItemPossessedBy(GetPCSpeaker(), "NW_IT_TORCH001");
    if(GetIsObjectValid(oItemToTake) != 0)
        DestroyObject(oItemToTake);
    AssignCommand(GetPCSpeaker(),ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0, 2.0));
    // Destroy slime noise
    object oSlime = GetObjectByTag("GreenSlime");
    DestroyObject(oSlime);
    object oWP2 = GetObjectByTag("WP_SlimeFire");
    CreateObject(OBJECT_TYPE_PLACEABLE, "flamesmall001", GetLocation(oWP2), TRUE);

}
