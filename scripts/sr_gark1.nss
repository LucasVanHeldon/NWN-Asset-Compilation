//::///////////////////////////////////////////////
//:: FileName sr_gark1
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 7/9/2002 3:33:43 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{
    int iAngry = GetLocalInt(GetPCSpeaker(), "Angry");

    // Make sure the PC speaker has these items in their inventory
    if(GetIsObjectValid(GetItemPossessedBy(GetPCSpeaker(), "hwildboarpelt")) && !iAngry)
        return TRUE;

    return FALSE;
}
