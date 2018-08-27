//#include "NW_I0_Plot"
#include "nw_i0_tool"

void main()
{
    object oPC = GetPCSpeaker();
    int iBarrierState = GetLocalInt(oPC, "NW_JOURNAL_ENTRYcoc_q2_barrier");

        if (CheckPartyForItem(GetPCSpeaker(), "wmephsoulstone")) {
            switch (iBarrierState) {
                // Player only knows to look for items to this point.
                // Set the Journal State to found Soulstone (13).
                case 12:
                    AddJournalQuestEntry("coc_q2_barrier", 13, oPC);
                    break;
                // If the player has already received the journal entry for the horn
                // set the JournalState to 15.
                case 14:
                    AddJournalQuestEntry("coc_q2_barrier", 15, oPC);
                    break;
                // If the player has already received the journal entry for the ash
                // set the JournalState to 17.
                case 16:
                    AddJournalQuestEntry("coc_q2_barrier", 17, oPC);
                    break;
                // If the player has already received the journal entry for both
                // set the JournalState to 19.
                case 18:
                    AddJournalQuestEntry("coc_q2_barrier", 19, oPC);
                    break;
            } // switch
        } // if soulstone

        if (CheckPartyForItem(GetPCSpeaker(), "minotaurhorn")) {
            switch (iBarrierState)
            {
                // Player only knows to look for items to this point.
                // Set the Journal State to found Horn (14).
                case 12:
                    AddJournalQuestEntry("coc_q2_barrier", 14, oPC);
                    break;
                // If the player has already received the journal entry for the soulstone
                // set the JournalState to 15.
                case 13:
                    AddJournalQuestEntry("coc_q2_barrier", 15, oPC);
                    break;
                // If the player has already received the journal entry for the ash
                // set the JournalState to 18.
                case 16:
                    AddJournalQuestEntry("coc_q2_barrier", 18, oPC);
                    break;
                // If the player has already received the journal entry for both
                // set the JournalState to 19.
                case 17:
                    AddJournalQuestEntry("coc_q2_barrier", 19, oPC);
                    break;
            } // switch
        } // horn

        if (CheckPartyForItem(GetPCSpeaker(), "ashlanternarchon")) {
            switch (iBarrierState)
            {
                // Player only knows to look for items to this point.
                // Set the Journal State to found Ash (15).
                case 12:
                    AddJournalQuestEntry("coc_q2_barrier", 16, oPC);
                    break;
                // If the player has already received the journal entry for the soulstone
                // set the JournalState to 15.
                case 13:
                    AddJournalQuestEntry("coc_q2_barrier", 17, oPC);
                    break;
                // If the player has already received the journal entry for the horn
                // set the JournalState to 18.
                case 14:
                    AddJournalQuestEntry("coc_q2_barrier", 18, oPC);
                    break;
                // If the player has already received the journal entry for both
                // set the JournalState to 19.
                case 15:
                    AddJournalQuestEntry("coc_q2_barrier", 19, oPC);
                    break;
            } // switch
        } // if ash
}
