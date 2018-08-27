 void main()
{
    // Set the variables
    object oPC = GetLastUsedBy();
    // check previous journal entrys
                int iState = GetLocalInt(oPC, "quest_2b");
                if (iState == 100) // Entry 1
                {
                 // If entry 1 existed, update to entry 2
                 SetLocalInt(oPC, "quest_2b", 200);
                 AddJournalQuestEntry("np_Q_3", 200, oPC, TRUE, FALSE, FALSE);
                }
                int iState2 = GetLocalInt(oPC, "quest_2a");
                if (iState2 == 100) // Entry 1
                {
                 // If entry 1 existed, update to entry 2
                 SetLocalInt(oPC, "quest_2a", 200);
                 AddJournalQuestEntry("np_Q_2", 200, oPC, TRUE, FALSE, FALSE);
                }
}
