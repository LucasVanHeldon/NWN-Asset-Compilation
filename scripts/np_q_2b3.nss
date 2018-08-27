 void main()
{
    // Set the variables
    object oPC = GetLastUsedBy();
    // check previous journal entrys
                int iState = GetLocalInt(oPC, "quest_2b");
                if (iState == 200) // Entry 1
                {
                 // If entry 1 existed, update to entry 2
                 SetLocalInt(oPC, "quest_2b", 300);
                 AddJournalQuestEntry("np_Q_3", 300, oPC, TRUE, FALSE, FALSE);
                }
                // Give the speaker some XP
                 if (GetLocalInt(oPC,"XPReward_2b") == 0)
                  {
                    GiveXPToCreature(oPC,500);
                    SetLocalInt(oPC,"XPReward_2b",1);
                  }
}
