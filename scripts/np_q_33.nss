  void main()
{
    // Set the variables
    object oPC = GetLastUsedBy();
    // check previous journal entrys
                int iState = GetLocalInt(oPC, "quest_3");
                if (iState >= 100) // Entry 1+
                {
                 // If entry 1 existed, update to entry 3
                 SetLocalInt(oPC, "quest_3", 300);
                 AddJournalQuestEntry("np_Q_4", 300, oPC, TRUE, FALSE, FALSE);
                }

}
