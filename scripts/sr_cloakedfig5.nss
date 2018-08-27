//::///////////////////////////////////////////////
//:: FileName sr_cloakedfig5
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 8/20/2002 10:26:31 AM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

    // Make sure the PC speaker has these items in their inventory
    if(!CheckPartyForItem(GetPCSpeaker(), "symboloftharizdu"))
        return FALSE;

    return TRUE;
}
