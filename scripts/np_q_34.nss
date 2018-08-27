 void main()
{
    // Set the variables
    object oPC = GetLastUsedBy();



    SetLocalInt(oPC, "quest_3", 400);
    AddJournalQuestEntry("np_Q_4", 400, oPC, TRUE, FALSE, FALSE);
    // Give the speaker some XP
     if (GetLocalInt(oPC,"XPReward_3") == 0)
    {
        GiveXPToCreature(oPC,1000);
        SetLocalInt(oPC,"XPReward_3",1);
    }

}
