//::///////////////////////////////////////////////
//:: FileName at_give_newmap
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 11/27/2003 1:55:48 AM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

void main()
{
    // Give the speaker the items
    CreateItemOnObject("merchantsmap", GetPCSpeaker(), 1);
    //AddJournalQuestEntry("SlaversMap", 601, GetPCSpeaker(), TRUE, FALSE);
    RewardPartyXP(600, GetPCSpeaker(), TRUE);
}
