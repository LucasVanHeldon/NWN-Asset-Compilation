#include "NW_I0_Plot"
void main()
{
    object oItem = GetModuleItemAcquired();
    string sItemTag = GetTag(oItem);
    object oPC = GetItemPossessor(oItem);

    if (GetIsPC(oPC)) {
        // SR's KotB plots:
        int iUnionState = GetLocalInt(oPC, "NW_JOURNAL_ENTRYcoc_q1_union");
        int iBarrierState = GetLocalInt(oPC, "NW_JOURNAL_ENTRYcoc_q2_barrier");
        int iDubricusState = GetLocalInt(oPC, "NW_JOURNAL_ENTRYkeep_q4_dubricus");
        int iSilksState = GetLocalInt(oPC, "NW_JOURNAL_ENTRYkeep_q5_silks");
        int iBoarState = GetLocalInt(oPC, "NW_JOURNAL_ENTRYoutside_q1_boar");
        int iSabineState = GetLocalInt(oPC, "NW_JOURNAL_ENTRYSabinesLoss");

// 1. Update the player's journal entry when they acquire the goblin note
        if (sItemTag == "coc_q1_plot1") {
            switch (iUnionState) {
                // If the player has already received the journal entry for the Orc Sign
                // set the JournalState to 3.
                case 2:
                    AddJournalQuestEntry("coc_q1_union", 3, oPC);
                    break;
                // If the player has already received the journal entry for the tableau
                // set the JournalState to 5.
                case 4:
                    AddJournalQuestEntry("coc_q1_union", 5, oPC);
                    break;
                // If the player has already received the journal entry for both
                // set the JournalState to 7.
                case 6:
                    AddJournalQuestEntry("coc_q1_union", 7, oPC);
                    break;
                // Otherwise, set the JournalState to 1.
                case 0:
                    AddJournalQuestEntry("coc_q1_union", 1, oPC);
                    break;
            }
        }

// 2. Update the player's journal entry when they acquire the archaic tableau
        if (sItemTag == "coc_q1_plot4")
        {
            switch (iUnionState)
            {
                // If the player has already received the journal entry for the Orc Sign
                // set the JournalState to 6.
                case 2:
                    AddJournalQuestEntry("coc_q1_union", 6, oPC);
                    break;
                // If the player has already received the journal entry for the goblin note
                // set the JournalState to 5.
                case 1:
                    AddJournalQuestEntry("coc_q1_union", 5, oPC);
                    break;
                // If the player has already received the journal entry for both
                // set the JournalState to 7.
                case 3:
                    AddJournalQuestEntry("coc_q1_union", 7, oPC);
                    break;
                // Otherwise, set the JournalState to 4.
                case 0:
                    AddJournalQuestEntry("coc_q1_union", 4, oPC);
                    break;
            }
        }

// 3. Update the player's journal entry when they acquire the hobgob chief head
        if (sItemTag == "HobGobChiefHead")
        {
            if (iDubricusState == 1)
                AddJournalQuestEntry("keep_q4_dubricus", 2, oPC);
        }

// 4. Update the player's journal entry when they acquire the Arfluvan Silks
        if (sItemTag == "ArfluvanSilk")
        {
            if (iSilksState == 1)
                AddJournalQuestEntry("keep_q5_silks", 2, oPC);
        }

// 5. Update the player's journal entry when they acquire the Soulstone
        if (sItemTag == "wmephsoulstone")
        {
            switch (iBarrierState)
            {
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
            }
        }

    // 6. Update the player's journal entry when they acquire the Minotaur Horn
        if (sItemTag == "minotaurhorn")
        {
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
            }
        }

    // 7. Update the player's journal entry when they acquire the Minotaur Horn
        if (sItemTag == "ashlanternarchon")
        {
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
            }
        }

    // 8. Special Event Handler for Acquiring Swirling Glass Bottle in Shy Tower
        if (sItemTag == "SwirlingGlassBottle") {
            object oSGB = GetObjectByTag("WP_SwirlingGlassBottle");
            location lWP = GetLocation(oSGB);
            ApplyEffectAtLocation(DURATION_TYPE_INSTANT,
                EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_2), lWP);
            CreateObject(OBJECT_TYPE_CREATURE, "jenn001", lWP, TRUE);
            DestroyObject(oItem);

            int x;
            for (x=1; x<=4; x++) {
                object oSGWP = GetObjectByTag("WP_SwirlingGlass" + IntToString(x));
                location lWPx = GetLocation(oSGWP);
                CreateObject(OBJECT_TYPE_CREATURE, "spectralcat", lWPx, TRUE);
            }
        }

    // 9. Update the player's journal entry when they acquire the Boar Pelt
        if (sItemTag == "hwildboarpelt")
        {
            switch (iBoarState)
            {
                // If Quest is at 1, set it to 2
                case 1:
                    AddJournalQuestEntry("outside_q1_boar", 2, oPC);
                    break;
            }
        }

    //10. Update the player's journal entry when they acquire the Sabine's Ring
        if (sItemTag == "simplegoldsilver")
        {
            switch (iSabineState)
            {
                // If Quest is at 1, set it to 2
                case 1:
                    AddJournalQuestEntry("SabinesLoss", 2, oPC);
                    break;
                case 100:
                    AddJournalQuestEntry("SabinesLoss", 101, oPC);
                    break;
            }
        }


    } //isPC
} // void
