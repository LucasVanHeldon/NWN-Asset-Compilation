//::///////////////////////////////////////////////
//:: FileName sr_lorack9
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 7/9/2002 1:40:07 PM
//:://////////////////////////////////////////////
void main()
{

    // Remove items from the player's inventory
    object oItemToTake;
    oItemToTake = GetItemPossessedBy(GetPCSpeaker(), "coc_q1_plot1");
    if(GetIsObjectValid(oItemToTake) != 0)
        DestroyObject(oItemToTake);
    oItemToTake = GetItemPossessedBy(GetPCSpeaker(), "coc_q1_plot4");
    if(GetIsObjectValid(oItemToTake) != 0)
        DestroyObject(oItemToTake);
    oItemToTake = GetItemPossessedBy(GetPCSpeaker(), "coc_q1_plot8");
    if(GetIsObjectValid(oItemToTake) != 0)
        DestroyObject(oItemToTake);

    // Check to see if the PC already knows about the Barrier.
    int iBarrierState = GetLocalInt(GetPCSpeaker(), "NW_JOURNAL_ENTRYcoc_q2_barrier");

    if (iBarrierState == 1)
        AddJournalQuestEntry("coc_q2_barrier", 10, GetPCSpeaker());

}
