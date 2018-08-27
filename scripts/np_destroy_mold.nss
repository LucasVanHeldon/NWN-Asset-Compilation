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
    // Destroy mold
    object oMold = GetObjectByTag("yellow_mold");
    object oMoldConvA = GetObjectByTag("mold_conv_a");
    object oMoldConvB = GetObjectByTag("mold_conv_b");
    DestroyObject(oMoldConvA);
    DestroyObject(oMoldConvB);
    SetTrapDisabled(oMold);
    object oWP3 = GetObjectByTag("WP_yellow_mold");
    CreateObject(OBJECT_TYPE_PLACEABLE, "flamesmall001", GetLocation(oWP3), TRUE);

}
