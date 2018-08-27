#include "NW_I0_Plot"
void main()
{
    object oPC = GetPCSpeaker();

    if (GetIsPC(oPC))
    {
        // SR's KotB plots:
        int iUnionState = GetLocalInt(oPC, "NW_JOURNAL_ENTRYcoc_q1_union");

// Update the player's journal entry when they examine the Orc sign
        switch (iUnionState)
        {
            // If the player has already received the journal entry for the goblin note
            // set the JournalState to 3.
            case 1:
                AddJournalQuestEntry("coc_q1_union", 3, oPC);
                break;
            // If the player has already received the journal entry for the tableau
            // set the JournalState to 6.
            case 4:
                AddJournalQuestEntry("coc_q1_union", 6, oPC);
                break;
            // If the player has already received the journal entry for both
            // set the JournalState to 7.
            case 5:
                AddJournalQuestEntry("coc_q1_union", 7, oPC);
                break;
            // Otherwise, set the JournalState to 2.
            default:
                AddJournalQuestEntry("coc_q1_union", 2, oPC);
                break;
        }
    }
}
