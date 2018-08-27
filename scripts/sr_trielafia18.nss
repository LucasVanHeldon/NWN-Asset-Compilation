//::///////////////////////////////////////////////
//:: FileName sr_trielafia18
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 7/24/2002 6:43:06 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

    // Make sure the PC speaker has these items in their inventory
    if(!CheckPartyForItem(GetPCSpeaker(), "ashlanternarchon"))
        return FALSE;
    if(!CheckPartyForItem(GetPCSpeaker(), "minotaurhorn"))
        return FALSE;
    if(!CheckPartyForItem(GetPCSpeaker(), "wmephsoulstone"))
        return FALSE;
    if(!CheckPartyForItem(GetPCSpeaker(), "historyofthebarr"))
        return FALSE;

//    if(!(GetLocalInt(GetPCSpeaker(), "NW_JOURNAL_ENTRYcoc_q2_barrier") > 11))
//        return FALSE;

    return TRUE;
}
