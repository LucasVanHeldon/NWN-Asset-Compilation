void main()
{
    object oPC = GetEnteringObject();

    if (GetIsPC(oPC)) {
        // SR's KotB plots:
        int iBarrierState = GetLocalInt(oPC, "NW_JOURNAL_ENTRYcoc_q2_barrier");

        if (iBarrierState == 20) {
            AddJournalQuestEntry("coc_q2_barrier", 21, oPC);

            CreateObject(OBJECT_TYPE_CREATURE, "cultist1",
                    GetLocation(GetObjectByTag("WP_Ambush1")));
            CreateObject(OBJECT_TYPE_CREATURE, "cultist2",
                    GetLocation(GetObjectByTag("WP_Ambush2")));
            CreateObject(OBJECT_TYPE_CREATURE, "cultist3",
                    GetLocation(GetObjectByTag("WP_Ambush3")));
            CreateObject(OBJECT_TYPE_CREATURE, "cultist4",
                    GetLocation(GetObjectByTag("WP_Ambush4")));

            FloatingTextStringOnCreature("There they are.  Kill them!!!", GetObjectByTag("Cultist3"));
            FloatingTextStringOnCreature("Get the scroll and destroy it!  They can not be allowed to escape!", GetObjectByTag("Cultist2"));
        }
    }
}
