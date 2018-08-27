//::///////////////////////////////////////////////
//:: FileName sc_has_mapletter
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 11/27/2003 1:16:39 AM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    // Make sure the PC speaker or Party Member has these items in their inventory
    if(!CheckPartyForItem(oPC, "Edralve01"))
        return FALSE;
    if(!CheckPartyForItem(oPC, "SlaversMap"))
        return FALSE;

    return TRUE;
}
